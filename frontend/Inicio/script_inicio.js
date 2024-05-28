document.addEventListener('DOMContentLoaded', function () {
    const ctx1 = document.getElementById('chart1').getContext('2d');
    const ctx2 = document.getElementById('chart2').getContext('2d');
    const ctx3 = document.getElementById('chart3').getContext('2d');

    new Chart(ctx1, {
        type: 'pie',
        data: {
            labels: ['Tema 1', 'Tema 2', 'Tema 3', 'Tema 4'],
            datasets: [{
                label: 'Examenes por tema',
                data: [12, 19, 3, 5],
                backgroundColor: [
                    '#FF6384',
                    '#36A2EB',
                    '#FFCE56',
                    '#4BC0C0'
                ],
                hoverOffset: 4
            }]
        }
    });

    new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: ['Grupo 1', 'Grupo 2', 'Grupo 3', 'Grupo 4'],
            datasets: [{
                label: 'Examenes por grupo',
                data: [12, 19, 3, 5],
                backgroundColor: '#36A2EB'
            }]
        }
    });

    new Chart(ctx3, {
        type: 'doughnut',
        data: {
            labels: ['Curso 1', 'Curso 2', 'Curso 3', 'Curso 4'],
            datasets: [{
                label: 'Examenes presentados por curso',
                data: [12, 19, 3, 5],
                backgroundColor: [
                    '#FF6384',
                    '#36A2EB',
                    '#FFCE56',
                    '#4BC0C0'
                ],
                hoverOffset: 4
            }]
        }
    });
});
