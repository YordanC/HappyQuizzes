<?php
include '../connection.php';

// Obtener los datos del formulario
$id_documento = $_POST['id_documento'];
$nombre = $_POST['nombre'];
$apellido = $_POST['apellido'];

// Consulta SQL para actualizar el profesor
$sql = "UPDATE profesor SET nombre = :nombre, apellido = :apellido WHERE id_documento = :id_documento";

// Preparar la sentencia
$stmt = oci_parse($conn, $sql);

// Bind de los parámetros
oci_bind_by_name($stmt, ':nombre', $nombre);
oci_bind_by_name($stmt, ':apellido', $apellido);
oci_bind_by_name($stmt, ':id_documento', $id_documento);

// Ejecutar la sentencia
$result = oci_execute($stmt);

// Verificar si la ejecución fue exitosa
if ($result) {
    echo "Profesor actualizado correctamente";
} else {
    // Si hubo un error en la ejecución, enviar un mensaje de error
    echo "Error al actualizar el profesor: " . oci_error($conn)['message'];
}

// Cerrar la conexión
oci_close($conn);
?>
