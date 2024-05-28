//function cancelar() {
    // Lógica para cancelar la creación del examen
   // alert("La creación del examen ha sido cancelada.");
//}
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('create-exam-form').addEventListener('submit', function(event) {
        event.preventDefault();
        const formData = new FormData(this);
        
        fetch('../backend/estudiante/create.php', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                alert('Examen creado con éxito');
                // Limpiar el formulario o redireccionar
                this.reset();
            } else {
                alert('Error: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error al crear el examen');
        });
    });

    // Event listener for "Añadir" button
    document.getElementById('anadir-pregunta').addEventListener('click', function() {
        const buscarPreguntaInput = document.getElementById('buscar-pregunta').value;
        // Lógica para añadir la pregunta
        alert('Pregunta añadida: ' + buscarPreguntaInput);
    });

    // Load grupos and porcentaje options
    cargarGrupos();
    cargarPorcentajes();
});

function cargarGrupos() {
    fetch('backend/cargar_grupos.php')
        .then(response => response.json())
        .then(data => {
            const grupoSelect = document.getElementById('grupo');
            data.forEach(grupo => {
                const option = document.createElement('option');
                option.value = grupo.id;
                option.textContent = grupo.nombre;
                grupoSelect.appendChild(option);
            });
        })
        .catch(error => {
            console.error('Error al cargar grupos:', error);
        });
}

function cargarPorcentajes() {
    const porcentajeSelect = document.getElementById('porcentaje');
    for (let i = 10; i <= 100; i += 10) {
        const option = document.createElement('option');
        option.value = i;
        option.textContent = i + '%';
        porcentajeSelect.appendChild(option);
    }
}
