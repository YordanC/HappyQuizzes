<?php
include '../connection.php';

// Obtener el ID del profesor a eliminar desde el formulario HTML
$id_documento = $_POST['id_documento'];

// Consulta SQL para eliminar el profesor
$sql = "DELETE FROM profesor WHERE id_documento = $id_documento";

// Preparar la sentencia
$stmt = oci_parse($conn, $sql);

// Ejecutar la sentencia
$result = oci_execute($stmt);

// Verificar si la eliminación fue exitosa
if ($result) {
    echo "Profesor eliminado exitosamente.";
} else {
    echo "Error al eliminar el profesor: " . oci_error($conn)['message'];
}

// Cerrar la conexión
oci_close($conn);
