<?php
include '../connection.php';

// Obtener los datos actualizados del estudiante desde el formulario HTML
$id_documento = $_POST['id_documento'];
$nombre = $_POST['nombre'];
$apellido = $_POST['apellido'];
$estado = $_POST['estado'];

// Consulta SQL para actualizar los datos del estudiante
$sql = "UPDATE estudiante SET nombre = '$nombre', apellido = '$apellido', estado = '$estado' WHERE id_documento = $id_documento";

// Preparar la sentencia
$stmt = oci_parse($conn, $sql);

// Ejecutar la sentencia
$result = oci_execute($stmt);

// Verificar si la actualización fue exitosa
if ($result) {
    echo "Datos del estudiante actualizados exitosamente.";
} else {
    echo "Error al actualizar los datos del estudiante: " . oci_error($conn)['message'];
}

// Cerrar la conexión
oci_close($conn);
?>
