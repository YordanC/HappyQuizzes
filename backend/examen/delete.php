<?php
include '../connection.php';

// Obtener el ID del examen a eliminar desde el formulario HTML
$id_examen = $_POST['id_examen'];

// Consulta SQL para eliminar el examen
$sql = "DELETE FROM examen WHERE id_examen = $id_examen";

// Preparar la sentencia
$stmt = oci_parse($conn, $sql);

// Ejecutar la sentencia
$result = oci_execute($stmt);

// Verificar si la eliminación fue exitosa
if ($result) {
    echo "Examen eliminado exitosamente.";
} else {
    echo "Error al eliminar el examen: " . oci_error($conn)['message'];
}

// Cerrar la conexión
oci_close($conn);
?>
