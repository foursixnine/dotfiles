<?php
print "\n";

$d = dir("/etc/lighttpd/sitios");
	#echo "Gestor: " . $d->handle . "\n";
	#echo "Ruta: " . $d->path . "\n";
	while (false !== ($entrada = $d->read())) {
		if($entrada != '.' AND $entrada != '..'){
		   echo $entrada."\n";
		}
	}
	$d->close();
	print "\n";
?>
