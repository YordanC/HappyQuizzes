<?php
include '../connection.php';

// Obtener los datos del formulario HTML
$nombre = $_POST['nombre'];
$apellido = $_POST['apellido'];

// Consulta SQL para insertar un nuevo profesor
$sql = "INSERT INTO profesor (nombre, apellido) VALUES ('$nombre', '$apellido')";

// Preparar la sentencia
$stmt = oci_parse($conn, $sql);

// Ejecutar la sentencia
$result = oci_execute($stmt);

// Verificar si la inserción fue exitosa
if ($result) {
    echo "Nuevo profesor agregado exitosamente.";
} else {
    echo "Error al agregar el profesor: " . oci_error($conn)['message'];
}

// Cerrar la conexión
oci_close($conn);
?>
