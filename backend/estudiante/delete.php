<?php
include '../connection.php';

$idEstudiante = $_POST['id'] ?? '';

$response = [];

$sql = "DELETE FROM estudiantes WHERE ID_DOCUMENTO = :idEstudiante";
$stmt = oci_parse($conn, $sql);
oci_bind_by_name($stmt, ':idEstudiante', $idEstudiante);

if (oci_execute($stmt)) {
    $response['message'] = 'Estudiante eliminado correctamente.';
} else {
    $error = oci_error($stmt);
    $response['error'] = 'Error al eliminar el estudiante: ' . $error['message'];
}

oci_free_statement($stmt);
oci_close($conn);

echo json_encode($response);
?>
