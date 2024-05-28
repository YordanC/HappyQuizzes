// Este archivo script.js contiene código JavaScript para interactuar con el backend y manipular el DOM en las páginas HTML.


// Función para cargar la lista de estudiantes desde el backend y mostrarla en la tabla HTML
// Función para eliminar un estudiante
// Función para eliminar un estudiante





// Función para cargar la lista de estudiantes desde el backend y mostrarla en la tabla HTML
function cargarEstudiantes() {
    fetch('../backend/estudiante/read.php')
        .then(response => response.json())
        .then(estudiantes => {
            const tablaEstudiantes = document.getElementById('tabla-estudiantes');
            const tbody = tablaEstudiantes.querySelector('tbody');
            tbody.innerHTML = ''; // Limpiar el contenido existente de la tabla

            // Iterar sobre la lista de estudiantes y crear filas para cada uno
            estudiantes.forEach(estudiante => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${estudiante.id_documento}</td>
                    <td>${estudiante.nombre}</td>
                    <td>${estudiante.apellido}</td>
                    <td>${estudiante.estado}</td>
                    <td><button onclick="eliminarEstudiante(${estudiante.id_documento})">Eliminar</button></td>
                `;
                tbody.appendChild(tr); // Agregar la fila a la tabla
            });
        })
        .catch(error => console.error('Error al cargar estudiantes:', error));
}
 // Función para guardar un estudiante en el backend
 function guardarEstudiante(formData) {
    $.ajax({
        url: '../backend/estudiante/create.php',
        method: 'POST',
        data: formData,
        success: function(response) {
            alert(response.message);
            cargarEstudiantes();
            $('#formulario-estudiante')[0].reset();
        },
        error: function(xhr, status, error) {
            console.error('Error al guardar estudiante:', error);
            alert('Error al guardar el estudiante');
        }
    });
}

// Función para eliminar un estudiante
function eliminarEstudiante(idEstudiante) {
    if (confirm("¿Estás seguro de que quieres eliminar este estudiante?")) {
        fetch(`../backend/estudiante/delete.php?id=${idEstudiante}`, {
            method: 'DELETE'
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                alert(data.message);
                cargarEstudiantes(); // Vuelve a cargar la lista de estudiantes después de eliminar uno
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error al eliminar estudiante:', error);
            alert('Error al eliminar el estudiante');
        });
    }
}

document.addEventListener('DOMContentLoaded', function() {
    // Cargar los grupos al cargar la página
    cargarGrupos();

    // Manejar el envío del formulario
    document.getElementById('create-group-form').addEventListener('submit', function(event) {
        event.preventDefault();
        const formData = new FormData(this);

        fetch('../backend/grupo/create.php', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                alert('Grupo creado con éxito');
                this.reset();
                cargarGrupos();
            } else {
                alert('Error: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error al crear el grupo');
        });
    });
});


function cargarGrupos() {
    fetch('../backend/grupo/read.php')
        .then(response => response.json())
        .then(data => {
            const grupoTableBody = document.querySelector('#grupo-table tbody');
            grupoTableBody.innerHTML = '';

            data.forEach(grupo => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${grupo.ID_GRUPO}</td>
                    <td>${grupo.NOMBRE_GRUPO}</td>
                    <td>${grupo.ESTADO}</td>
                `;
                grupoTableBody.appendChild(row);
            });
        })
        .catch(error => {
            console.error('Error al cargar los grupos:', error);
        });
}

document.addEventListener('DOMContentLoaded', function() {
    // Cargar los exámenes al cargar la página
    cargarExamenes();

    // Manejar el envío del formulario
    document.getElementById('create-exam-form').addEventListener('submit', function(event) {
        event.preventDefault();
        const formData = new FormData(this);

        fetch('../backend/examen/create.php', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                alert('Examen creado con éxito');
                this.reset();
                cargarExamenes();
            } else {
                alert('Error: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error al crear el examen');
        });
    });
});

function cargarExamenes() {
    fetch('../backend/examen/read.php')
        .then(response => response.json())
        .then(data => {
            const examenTableBody = document.querySelector('#examen-table tbody');
            examenTableBody.innerHTML = '';

            data.forEach(examen => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${examen.id_examen}</td>
                    <td>${examen.descripcion}</td>
                    <td>${examen.porcentaje_examen}</td>
                    <td>${examen.categoria}</td>
                    <td>${examen.nota_examen}</td>
                    <td>${examen.cantidad_preguntas}</td>
                    <td>${examen.tiempo}</td>
                    <td>${examen.tiempo_finalizacion}</td>
                    <td>${examen.porcentaje_correctas}</td>
                    <td>${examen.porcentaje_incorrectas}</td>
                    <td>${examen.horario_id_horario}</td>
                `;
                examenTableBody.appendChild(row);
            });
        })
        .catch(error => {
            console.error('Error al cargar los exámenes:', error);
        });
}



// Llamar a las funciones de carga al cargar la página
window.onload = function() {
    cargarEstudiantes();
    cargarGrupos();
    //cargarExamenes();
    //cargarProfesores();
};
