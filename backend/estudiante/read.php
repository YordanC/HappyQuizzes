<?php
header('Content-Type: text/html; charset=utf-8');
error_reporting(E_ALL);
ini_set('display_errors', 1);
include '../connection.php';

// Consulta SQL
$sql = "SELECT * FROM estudiante";


// Preparar la sentencia
$stmt = oci_parse($conn, $sql);

// Ejecutar la sentencia
oci_execute($stmt);

// Arreglo para almacenar los estudiantes
$estudiantes = array();

// Recorrer los resultados y almacenar en el arreglo
while ($row = oci_fetch_assoc($stmt)) {
    $estudiante = array(
        'id_documento' => $row['ID_DOCUMENTO'],
        'nombre' => $row['NOMBRE'],
        'apellido' => $row['APELLIDO'],
        'estado' => $row['ESTADO']
    );
    $estudiantes[] = $estudiante;
}

// Cerrar la conexión
oci_close($conn);

// Convertir los datos a JSON
$estudiantes_json = json_encode($estudiantes);

// Enviar los datos JSON al HTML
echo $estudiantes_json;
?>
