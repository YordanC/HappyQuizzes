<?php
include '../connection.php';

// Obtener los datos actualizados del examen desde el formulario HTML
$id_examen = $_POST['id_examen'];
$descripcion = $_POST['descripcion'];
$porcentaje_examen = $_POST['porcentaje_examen'];
$categoria = $_POST['categoria'];
$nota_examen = $_POST['nota_examen'];
$cantidad_preguntas = $_POST['cantidad_preguntas'];
$tiempo = $_POST['tiempo'];
$tiempo_finalizacion = $_POST['tiempo_finalizacion'];
$porcentaje_correctas = $_POST['porcentaje_correctas'];
$porcentaje_incorrectas = $_POST['porcentaje_incorrectas'];
$horario_id_horario = $_POST['horario_id_horario'];

// Consulta SQL para actualizar los datos del examen
$sql = "UPDATE examen SET descripcion = '$descripcion', porcentaje_examen = '$porcentaje_examen', categoria = '$categoria', nota_examen = '$nota_examen', cantidad_preguntas = '$cantidad_preguntas', tiempo = '$tiempo', tiempo_finalizacion = '$tiempo_finalizacion', porcentaje_correctas = '$porcentaje_correctas', porcentaje_incorrectas = '$porcentaje_incorrectas', horario_id_horario = '$horario_id_horario' WHERE id_examen = $id_examen";

// Preparar la sentencia
$stmt = oci_parse($conn, $sql);

// Ejecutar la sentencia
$result = oci_execute($stmt);

// Verificar si la actualización fue exitosa
if ($result) {
    echo "Datos del examen actualizados exitosamente.";
} else {
    echo "Error al actualizar los datos del examen: " . oci_error($conn)['message'];
}

// Cerrar la conexión
oci_close($conn);
?>
