<?php
include '../connection.php';

header('Content-Type: application/json');

$sql = "SELECT ID_GRUPO, NOMBRE_GRUPO, ESTADO FROM GRUPO";
$stmt = oci_parse($conn, $sql);

oci_execute($stmt);

$grupos = [];
while ($row = oci_fetch_assoc($stmt)) {
    $grupos[] = $row;
}

oci_free_statement($stmt);
oci_close($conn);

echo json_encode($grupos);
?>
