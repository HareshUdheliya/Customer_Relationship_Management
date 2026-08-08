/* Profile Page Logic */
document.addEventListener("DOMContentLoaded", function () {
  console.log("Profile Page JS initialized.");

  // Populate dynamic profile details from localStorage if available
  var name = localStorage.getItem("crmUserName");
  var email = localStorage.getItem("crmUserEmail");
  var role = localStorage.getItem("crmUserRole");

  if (name || email) {
    var nameHeading = document.querySelector(".card-body.text-center h5");
    if (nameHeading && name) nameHeading.textContent = name;

    var emailInput = document.querySelector("input[type='email']");
    if (emailInput && email) emailInput.value = email;

    var roleLabel = document.querySelector(".card-body.text-center span.text-muted");
    if (roleLabel && role) {
      roleLabel.textContent = role === "admin" ? "Administrator" : "Employee / Staff";
    }
  }
});
