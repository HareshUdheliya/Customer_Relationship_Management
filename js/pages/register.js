/* Register Page Script */
(function () {
  function getRegisteredUsers() {
    var stored = localStorage.getItem("crmRegisteredUsers");
    return stored ? JSON.parse(stored) : [];
  }

  function saveRegisteredUser(user) {
    var users = getRegisteredUsers();
    users.push(user);
    localStorage.setItem("crmRegisteredUsers", JSON.stringify(users));
  }

  function showError(msg) {
    var errorEl = document.getElementById("registerError");
    if (!errorEl) return;
    errorEl.textContent = msg;
    errorEl.classList.remove("d-none");
  }

  function hideError() {
    var errorEl = document.getElementById("registerError");
    if (!errorEl) return;
    errorEl.classList.add("d-none");
  }

  document.addEventListener("DOMContentLoaded", function () {
    var registerForm = document.getElementById("registerForm");
    if (!registerForm) return;

    registerForm.addEventListener("submit", function (e) {
      e.preventDefault();
      hideError();

      var nameInput = document.getElementById("fullName");
      var emailInput = document.getElementById("email");
      var roleInput = document.getElementById("role");
      var passwordInput = document.getElementById("password");
      var confirmPasswordInput = document.getElementById("confirmPassword");
      var termsInput = document.getElementById("terms");

      var name = nameInput ? nameInput.value.trim() : "";
      var email = emailInput ? emailInput.value.trim().toLowerCase() : "";
      var role = roleInput ? roleInput.value : "user";
      var password = passwordInput ? passwordInput.value : "";
      var confirmPassword = confirmPasswordInput ? confirmPasswordInput.value : "";
      var terms = termsInput ? termsInput.checked : false;

      if (!name || !email || !password || !confirmPassword) {
        showError("Please fill out all required fields.");
        return;
      }

      if (password.length < 6) {
        showError("Password must be at least 6 characters long.");
        return;
      }

      if (password !== confirmPassword) {
        showError("Passwords do not match. Please re-check.");
        return;
      }

      if (!terms) {
        showError("You must agree to the Terms & Privacy Policy to register.");
        return;
      }

      // Check if email already exists
      if (email === "admin@example.com" || email === "user@example.com") {
        showError("This email is reserved for demo logins. Please use a different email.");
        return;
      }

      var existingUsers = getRegisteredUsers();
      var duplicate = existingUsers.some(function (u) {
        return u.email.toLowerCase() === email;
      });

      if (duplicate) {
        showError("An account with this email already exists. Please sign in instead.");
        return;
      }

      // Save user
      saveRegisteredUser({
        name: name,
        email: email,
        role: role,
        password: password,
        createdAt: new Date().toISOString()
      });

      // Redirect to login with success flag
      window.location.href = "login.html?registered=1";
    });
  });
})();
