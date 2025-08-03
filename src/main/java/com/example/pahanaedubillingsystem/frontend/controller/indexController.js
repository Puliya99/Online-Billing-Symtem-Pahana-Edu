const displayNoneSections = () => {
    $("#login-section").css("display", "none");
    $("#dashboard-section").css("display", "none");
    $("#customer-section").css("display", "none");
    $("#item-section").css("display", "none");
    $("#bill-section").css("display", "none");
    $("#help-section").css("display", "none");
};

displayNoneSections();
$("#login-section").css("display", "block");

$("#dashboard").on('click', () => {
    displayNoneSections();
    $("#dashboard-section").css("display", "block");
});

$("#customer").on('click', () => {
    displayNoneSections();
    $("#customer-section").css("display", "block");
});

$("#item").on('click', () => {
    displayNoneSections();
    $("#item-section").css("display", "block");
});

$("#bill").on('click', () => {
    displayNoneSections();
    $("#bill-section").css("display", "block");
});

$("#help").on('click', () => {
    displayNoneSections();
    $("#help-section").css("display", "block");
});

$("#logout").on('click', () => {
    displayNoneSections();
    $("#login-section").css("display", "block");
    $("#nav_bar").css("display", "none");
});