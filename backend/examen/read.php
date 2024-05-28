<?php
include '../connection.php';

// Consulta SQL para obtener todos los exámenes
$sql = "SELECT * FROM examen";

// Preparar la sentencia
$stmt = oci_parse($conn, $sql);

// Ejecutar la sentencia
$result = oci_execute($stmt);

// Verificar si la ejecución fue exitosa
if ($result) {
    // Inicializar un array para almacenar los exámenes
    $examenes = array();

    // Recorrer los resultados y almacenarlos en el array
    while ($row = oci_fetch_assoc($stmt)) {
        $examen = array(
            'id_examen' => $row['ID_EXAMEN'],
            'descripcion' => $row['DESCRIPCION'],
            'porcentaje_examen' => $row['PORCENTAJE_EXAMEN'],
            'categoria' => $row['CATEGORIA'],
            'nota_examen' => $row['NOTA_EXAMEN'],
            'cantidad_preguntas' => $row['CANTIDAD_PREGUNTAS'],
            'tiempo' => $row['TIEMPO'],
            'tiempo_finalizacion' => $row['TIEMPO_FINALIZACION'],
            'porcentaje_correctas' => $row['PORCENTAJE_CORRECTAS'],
            'porcentaje_incorrectas' => $row['PORCENTAJE_INCORRECTAS'],
            'horario_id_horario' => $row['HORARIO_ID_HORARIO']
        );
        array_push($examenes, $examen);
    }

    // Convertir el array a formato JSON y enviarlo como respuesta
    echo json_encode($examenes);
} else {
    // Si hubo un error en la ejecución, enviar un mensaje de error
    echo "Error al obtener los exámenes: " . oci_error($conn)['message'];
}

// Cerrar la conexión
oci_close($conn);
?>
