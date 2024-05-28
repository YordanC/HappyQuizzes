<?php
header('Content-Type: text/html; charset=utf-8');
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Datos de conexión
$usuario = 'JDARCILA';
$contraseña = '123456';
$nombre_host = 'localhost'; // O el nombre del host donde se encuentra la base de datos Oracle
$sid = 'xe'; // SID de la base de datos Oracle

// Intentar establecer la conexión
$conn = oci_connect($usuario, $contraseña, "(DESCRIPTION=(ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = $nombre_host)(PORT = 1521)))(CONNECT_DATA=(SID=$sid)))");

// Verificar si la conexión se estableció correctamente
if (!$conn) {
    $error = oci_error(); // Obtener el mensaje de error
    echo "Error de conexión: " . $error['message']; // Mostrar el mensaje de error
}
?>

