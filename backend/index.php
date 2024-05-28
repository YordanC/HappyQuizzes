<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tabla de Estudiantes</title>
    <!-- Agregar aquí cualquier enlace a CSS o scripts adicionales -->
</head>
<body>
    <h1>Tabla de Estudiantes</h1>
    <div id="tablaEstudiantes"></div>

    <script>
        // Hacer una solicitud AJAX para obtener la tabla de estudiantes
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                // Insertar la tabla de estudiantes en el div correspondiente
                document.getElementById("tablaEstudiantes").innerHTML = this.responseText;
            }
        };
        xhttp.open("GET", "backend/read.php", true);
        xhttp.send();
    </script>
</body>
</html>

