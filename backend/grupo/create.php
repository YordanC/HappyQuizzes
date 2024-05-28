<?php
include '../connection.php';

header('Content-Type: application/json');

$tema = $_POST['tema'] ?? null;
$grupo = $_POST['grupo'] ?? null;
$porcentaje = $_POST['porcentaje'] ?? null;
$horaPublicacion = $_POST['hora-publicacion'] ?? null;
$fechaPublicacion = $_POST['fecha-publicacion'] ?? null;
$tiempoLimite = $_POST['tiempo-limite'] ?? null;

$response = [];

if (!$tema || !$grupo || !$porcentaje || !$horaPublicacion || !$fechaPublicacion || !$tiempoLimite) {
    $response['status'] = 'error';
    $response['message'] = 'Faltan datos necesarios.';
    echo json_encode($response);
    exit;
}

$sql = "INSERT INTO EXAMEN (TEMA, ID_GRUPO, PORCENTAJE, HORA_PUBLICACION, FECHA_PUBLICACION, TIEMPO_LIMITE) 
        VALUES (:tema, :grupo, :porcentaje, TO_DATE(:horaPublicacion, 'HH24:MI:SS'), TO_DATE(:fechaPublicacion, 'YYYY-MM-DD'), TO_DATE(:tiempoLimite, 'HH24:MI:SS'))";

$stmt = oci_parse($conn, $sql);

oci_bind_by_name($stmt, ':tema', $tema);
oci_bind_by_name($stmt, ':grupo', $grupo);
oci_bind_by_name($stmt, ':porcentaje', $porcentaje);
oci_bind_by_name($stmt, ':horaPublicacion', $horaPublicacion);
oci_bind_by_name($stmt, ':fechaPublicacion', $fechaPublicacion);
oci_bind_by_name($stmt, ':tiempoLimite', $tiempoLimite);

if (oci_execute($stmt)) {
    $response['status'] = 'success';
    $response['message'] = 'Examen creado exitosamente.';
} else {
    $error = oci_error($stmt);
    $response['status'] = 'error';
    $response['message'] = 'Error al crear el examen: ' . $error['message'];
}

oci_free_statement($stmt);
oci_close($conn);

echo json_encode($response);
?>
