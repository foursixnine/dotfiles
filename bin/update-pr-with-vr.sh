#!/bin/bash -ex

function cleanup() {
    if [ -d "$workdir" ]; then
        echo "Cleanning up ${workdir}"
        rm -rf "$workdir"
    fi
}

trap cleanup EXIT

pr_id="${1:-}"

json_content=$(gh pr view $pr_id --json title,number,body)
number=$(echo "$json_content" | jq -r '.number')
workdir=$(mktemp -d -t "OSADO-PR-$number-XXXX")
file="${workdir}/${number}-body.txt"

echo "$json_content" | jq -r '.body' > "$file"

run_json=$(gh pr checks $pr_id --json bucket,name,link,state) 
run_id=$(echo "$run_json" | jq -r '.[] | select(.name == "clone_mentioned_job") | .link | capture("runs/(?<id>[0-9]+)") | .id')
run_state=$(echo "$run_json" | jq -r '.[] | select(.name == "clone_mentioned_job") | .state')

log_archive="${workdir}/log.zip"

echo "RUN_ID is => $run_id"
echo "RUN_STATE is => $run_state"

#log_file="0_clone_mentioned_job.txt"
log_file="clone_mentioned_job/3_Clone and monitor job mentioned in PR description.txt"
log_api_path="/repos/os-autoinst/os-autoinst-distri-opensuse/actions/jobs/${run_id}/logs"

if [ "$run_state" == "SUCCESS" -o "$run_state" == "FAILURE" ]; then
    log_file="*_clone_mentioned_job.txt"
    log_api_path="/repos/os-autoinst/os-autoinst-distri-opensuse/actions/runs/${run_id}/logs"
fi

gh api \
 -H "Accept: application/vnd.github+json"\
 -H "X-GitHub-Api-Version: 2026-03-10" \
 $log_api_path > "$log_archive"

unzip -d "$workdir" "$log_archive"

ls -la "$workdir"

job_log=$(ls "${workdir}"/${log_file})

if [ ! -f "$job_log" ]; then
	echo "ERROR: '$log_file' not found, try again later"
fi

cloned_urls=$(awk '/into:/{f=1; next} /{"blocked_by_id/{f=0} f && / - /{print $NF}' "$job_log")

marker="#### Results from cloned jobs:"

perl -0777 -i -pe "s/\n+$marker.*//s" "$file"

# Per cloned url get job settings so the link looks like
# [![distri-version-test-flavor-arch@machine](&/badge)](&)

if [ -z "$cloned_urls" ]; then
    echo "NOTICE: No jobs found, not updating"
    exit 2
fi

{
    echo "" 
    echo "$marker"
    echo "$cloned_urls" | sed 's|.*|- [![&](&/badge)](&)|'
    echo ""
    echo "<sub>The above list is generated with a script with information from the \"clone_mentioned_job\" workflow.</sub>"
} >> "$file"

cat "$file"

gh pr edit $pr_id --body-file "$file"
