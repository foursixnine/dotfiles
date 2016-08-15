#!/bin/php

<?php 

$usuario = 'foursixnine';
$password = '-';
$url = 'https://dinamico.cdmon.org/onlineService.php?enctype=MD5&n='.$usuario.'&p='.md5($password);
$respuestaServidorCdmon = '';
$curlSession = curl_init();

function errorActualizacion(){

	return false;

}


$curlOptions = array(
			CURLOPT_URL => $url,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_SSL_VERIFYPEER => false
		);

curl_setopt_array($curlSession, $curlOptions);

$salida = curl_exec($curlSession);

curl_close($curlSession);

$respuesta = explode('&', $salida);

foreach ($respuesta as $estaRespuesta) {

		if(trim($estaRespuesta != '')){
		
			if(eregi('^[0-9A-Za-z]+=[0-9A-Za-z\.]+$', $estaRespuesta)){
			
				list($parametro, $valor) = explode('=', $estaRespuesta);
				$respuestaServidorCdmon[trim($parametro)] = trim($valor);

			}

		}

	}


$mensaje = ($respuestaServidorCdmon['resultat'] == 'guardatok')? 'Los datos han sido actualizados exitosamente'  : errorActualizacion();

print "\n\n";
print "La respuesta del servidor fue: \n";
print $mensaje."\n\n";
print date('d-m-y h:i:s')."\n";

?>
