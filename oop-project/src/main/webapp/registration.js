document.getElementById('registration-form').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent the form from submitting the traditional way

    // Get form data
    const fullName = document.getElementById('full-name').value;
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirm-password').value;
    const course = document.getElementById('course').value;

    // Create a string with the form data
    const data = `Full Name: ${fullName}\nEmail: ${email}\nPassword: ${password}\nConfirm Password: ${confirmPassword}\nCourse: ${course}\n\n`;

    // Create a Blob with the data
    const blob = new Blob([data], { type: 'text/plain' });

    // Create a link element
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = 'registration_data.txt'; // The name of the file to be downloaded

    // Append the link to the body (required for Firefox)
    document.body.appendChild(link);

    // Programmatically click the link to trigger the download
    link.click();

    // Remove the link from the document
    document.body.removeChild(link);

    // Optionally, you can reset the form after submission
    document.getElementById('registration-form').reset();
});