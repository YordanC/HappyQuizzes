<?php
include '../connection.php';

// Consulta SQL para obtener todos los profesores
$sql = "SELECT * FROM profesor";

// Preparar la sentencia
$stmt = oci_parse($conn, $sql);

// Ejecutar la sentencia
$result = oci_execute($stmt);

// Verificar si la ejecución fue exitosa
if ($result) {
    // Inicializar un array para almacenar los profesores
    $profesores = array();

    // Recorrer los resultados y almacenarlos en el array
    while ($row = oci_fetch_assoc($stmt)) {
        $profesor = array(
            'id_documento' => $row['ID_DOCUMENTO'],
            'nombre' => $row['NOMBRE'],
            'apellido' => $row['APELLIDO']
        );
        array_push($profesores, $profesor);
    }

    // Convertir el array a formato JSON y enviarlo como respuesta
    echo json_encode($profesores);
} else {
    // Si hubo un error en la ejecución, enviar un mensaje de error
    echo "Error al obtener los profesores: " . oci_error($conn)['message'];
}

// Cerrar la conexión
oci_close($conn);
?>
