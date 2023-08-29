#!/bin/bash

#export OPENQA="$HOME/Projects/suse.com/github.com/os-autoinst"
#export OPENQA_CONFIG="${OPENQA}/openQA/local/openqa"

export TEST_PG="DBI:Pg:dbname=test"
export OPENQA_SRC="$HOME/Projects/suse.com/openQA"
export OPENQA_BASEDIR="${OPENQA_SRC}/openQA"
export OPENQA_CONFIG="${OPENQA_BASEDIR}/openQA/config"
export OPENQA_WEBUI="$OPENQA_BASEDIR"
export OSAUTOINST_SRC="$OPENQA_BASEDIR/../os-autoinst"
export OPENQA_LIBPATH="$OPENQA_BASEDIR/lib"
export PERL5LIB=$OPENQA_LIBPATH:$OPENQA_BASEDIR/t/lib

function setup_tmux (){
    tmux new -s openqa-workspace -d
    #tmux new-window -topenqa-workspace:0 -n "root"
    tmux new-window -topenqa-workspace:1 -n "os-autoinst"
    tmux new-window -topenqa-workspace:2 -n "openQA WebUI"
    tmux new-window -topenqa-workspace:3 -n "openQA tests"
    tmux new-window -topenqa-workspace:4 -n "openQA Monitoring"
    tmux new-window -topenqa-workspace:5 -n "Workspace"
    
    tmux send-keys -topenqa-workspace:1 "cd ${OSAUTOINST_SRC}; clear" C-m
    tmux send-keys -topenqa-workspace:2 "cd ${OPENQA_BASEDIR}; clear" C-m
    tmux send-keys -topenqa-workspace:3 "cd ${OPENQA_SRC}/test-distri; clear" C-m
    tmux send-keys -topenqa-workspace:4 "cd ${OPENQA_BASEDIR}/; clear" C-m
    tmux send-keys -topenqa-workspace:5 "cd ${OPENQA}/; clear" C-m
    tmux attach-session -topenqa-workspace
}
