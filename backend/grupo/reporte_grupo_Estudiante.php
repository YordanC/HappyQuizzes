<?php
header('Content-Type: application/json; charset=utf-8');
error_reporting(E_ALL);
ini_set('display_errors', 1);
include '../connection.php';

// Verificar si se proporcionó el parámetro id_grupo
if (isset($_GET['id_grupo'])) {
    // Obtener el valor del parámetro id_grupo
    $idGrupo = $_GET['id_grupo'];

    // Consulta SQL
    $sql = "SELECT 
                e.id_documento, 
                e.nombre, 
                e.apellido, 
                AVG(ex.puntaje_examen) AS promedio_notas, 
                CASE 
                    WHEN AVG(ex.puntaje_examen) >= 70 THEN 'Aprobado' 
                    ELSE 'Reprobado' 
                END AS estado 
            FROM 
                estudiante e
            JOIN 
                examen_estudiante ex ON e.id_documento = ex.estudiante_id_documento
            JOIN
                examen_grupo eg ON ex.exam_id_exam = eg.examen_id_examen
            JOIN
                grupo g ON g.id_grupo = eg.grupo_id_grupo
            WHERE
                g.id_grupo = :id_grupo
            GROUP BY 
            e.id_documento, e.nombre, e.apellido";

// Preparar la sentencia
$stmt = oci_parse($conn, $sql);

// Vincular el parámetro id_grupo
oci_bind_by_name($stmt, ':id_grupo', $idGrupo);

// Ejecutar la sentencia
oci_execute($stmt);

// Arreglo para almacenar los estudiantes
$estudiantes = array();

// Recorrer los resultados y almacenar en el arreglo
while ($row = oci_fetch_assoc($stmt)) {
    $estudiante = array(
        'id_documento' => $row['ID_DOCUMENTO'],
        'nombre' => $row['NOMBRE'],
        'apellido' => $row['APELLIDO'],
        'promedio_notas' => $row['PROMEDIO_NOTAS'],
        'estado' => $row['ESTADO']
    );
    $estudiantes[] = $estudiante;
}

// Cerrar la conexión
oci_close($conn);

// Convertir los datos a JSON
$estudiantes_json = json_encode($estudiantes);

// Enviar los datos JSON al HTML
echo $estudiantes_json;
} else {
// Si no se proporciona el parámetro id_grupo, devolver un error
echo json_encode(array('error' => 'No se proporcionó el parámetro id_grupo.'));
}
?>

