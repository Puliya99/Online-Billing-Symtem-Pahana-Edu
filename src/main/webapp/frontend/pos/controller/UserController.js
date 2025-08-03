import { UserModel } from "../model/UserModel";

$("#login-btn").on('click', () => {
    let username = $("#username").val(),
        password = $("#password").val();

    if (!username || !password) {
        showErrorAlert("Please enter username and password!");
        return;
    }

    let user = new UserModel(username, password);
    $.ajax({
        url: "http://localhost:8081/PahanaEduBillingSystem/UserModel",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify(user),
        success: function (response) {
            if (response === "valid") {
                $("#login-section").hide();
                $("#nav_bar, #dashboard-section").show();
                Swal.fire({
                    icon: 'success',
                    title: 'Login Successful',
                    showConfirmButton: false,
                    timer: 1500
                });
            } else {
                showErrorAlert("Invalid username or password!");
            }
        },
        error: function () {
            showErrorAlert("Error during login");
        }
    });
});

function showErrorAlert(message) {
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: message,
    });
}