function togglePasswordVisibility() {
    const passwordInput = document.getElementById('password');
    const passwordIcon = document.querySelector('.toggle-password');
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        passwordIcon.textContent = '🙈';
    } else {
        passwordInput.type = 'password';
        passwordIcon.textContent = '👁️';
    }
}

document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Evitar el envío automático del formulario

    const idInput = document.getElementById('id');
    const passwordInput = document.getElementById('password');

    // Verificar si ambos campos están diligenciados
    if (idInput.value.trim() === '' || passwordInput.value.trim() === '') {
        alert('Por favor diligencia ambos campos.');
        return;
    }

    // Verificar si el campo ID tiene un formato de correo electrónico válido
    const emailFormat = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailFormat.test(idInput.value.trim())) {
        alert('Por favor ingresa un correo electrónico válido en el campo ID. ');
        return;
    }

    // Si la validación es exitosa, redirigir al usuario a la página de inicio
    
     console.log("Redireccionando...");
window.location.href = "/frontend/Inicio/inicio.html";

});

// Asegurarnos de que el campo de contraseña esté oculto al cargar la página
window.addEventListener('DOMContentLoaded', function() {
    const passwordInput = document.getElementById('password');
    passwordInput.type = 'password';
});

// Función para alternar la visibilidad de la contraseña y cambiar el ícono
function togglePasswordVisibility() {
    const passwordInput = document.getElementById('password');
    const passwordIcon = document.querySelector('.toggle-password');
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        passwordIcon.textContent = '🙈';
    } else {
        passwordInput.type = 'password';
        passwordIcon.textContent = '👁️';
    }
}

// Agregar el evento de clic al ícono del ojo
document.querySelector('.toggle-password').addEventListener('click', togglePasswordVisibility);
