<?php
include '../connection.php';

$nombre = $_POST['nombre'] ?? '';
$apellido = $_POST['apellido'] ?? '';
$estado = $_POST['estado'] ?? '';

$response = [];

$sql = "INSERT INTO estudiantes (nombre, apellido, estado) VALUES ('$nombre', '$apellido', '$estado')";
if (mysqli_query($conn, $sql)) {
    $response['message'] = 'Estudiante guardado correctamente.';
} else {
    $response['error'] = 'Error al guardar el estudiante: ' . mysqli_error($conn);
}

mysqli_close($conn);

echo json_encode($response);
?>
