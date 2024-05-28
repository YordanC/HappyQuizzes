document.addEventListener('DOMContentLoaded', function() {
    cargarGrupos();

    // Manejar el evento de clic en el botón de filtro
    document.getElementById('search-button').addEventListener('click', function() {
        const searchInput = document.getElementById('search-input').value;
        // Lógica para filtrar los grupos según el nombre (puedes implementarla si lo necesitas)
    });
});

function cargarGrupos() {
    fetch('/P_HappyQuizzes/backend/grupo/read.php') // Ruta al archivo PHP corregida
        .then(response => {
            if (!response.ok) {
                throw new Error('Error al cargar los grupos: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            const grupoTableBody = document.querySelector('#grupo-table tbody');
            grupoTableBody.innerHTML = '';

            data.forEach(grupo => {
                const row = document.createElement('tr');

                // Agregar clases para el estado (activo o inactivo) y color correspondiente
                const estadoClass = grupo.ESTADO.toLowerCase() === 'activo' ? 'activo' : 'inactivo';

                row.innerHTML = `
                    <td>${grupo.ID_GRUPO}</td>
                    <td>${grupo.NOMBRE_GRUPO}</td>
                    <td class="estado ${estadoClass}">${grupo.ESTADO}</td>
                    <td><a href="grupoEstudiantes.html">Ver más</a></td>
                `;
                grupoTableBody.appendChild(row);
            });
        })
        .catch(error => {
            console.error(error);
            alert('Error al cargar los grupos. Por favor, inténtalo de nuevo más tarde.');
        });
}
