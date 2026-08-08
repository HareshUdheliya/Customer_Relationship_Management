/* Authentication helper for the CRM login page */
(function () {
  function getRoleFromCredentials(email, password) {
    if (email === "admin@example.com" && password === "admin123") {
      return "admin";
    }
    if (email === "user@example.com" && password === "user123") {
      return "user";
    }
    return null;
  }

  function getQueryParam(name) {
    return new URLSearchParams(window.location.search).get(name);
  }

  function updateRoleDisplay() {
    var roleLabel = document.getElementById("loginRoleLabel");
    var roleHint = document.getElementById("loginRoleHint");
    if (!roleLabel || !roleHint) {
      return;
    }

    roleLabel.textContent = "Automatic";
    roleHint.textContent = "Enter admin or employee credentials. Role is assigned automatically.";
  }

  function showError(message) {
    var errorEl = document.getElementById("loginError");
    if (!errorEl) {
      return;
    }
    errorEl.textContent = message;
    errorEl.classList.remove("d-none");
  }

  function hideError() {
    var errorEl = document.getElementById("loginError");
    if (!errorEl) {
      return;
    }
    errorEl.classList.add("d-none");
  }

  document.addEventListener("DOMContentLoaded", function () {
    if (getQueryParam("logout") === "1") {
      localStorage.removeItem("crmUserRole");
      localStorage.removeItem("crmUserEmail");
    }

    updateRoleDisplay();

    var loginForm = document.getElementById("loginForm");
    if (!loginForm) {
      return;
    }

    loginForm.addEventListener("submit", function (event) {
      event.preventDefault();
      hideError();

      var emailInput = document.getElementById("email");
      var passwordInput = document.getElementById("password");
      if (!emailInput || !passwordInput) {
        return;
      }

      var email = emailInput.value.trim().toLowerCase();
      var password = passwordInput.value;
      var role = getRoleFromCredentials(email, password);

      if (!role) {
        showError("Invalid credentials. Use admin@example.com / admin123 or user@example.com / user123.");
        return;
      }

      localStorage.setItem("crmUserRole", role);
      localStorage.setItem("crmUserEmail", email);
      window.location.href = "index.html";
    });
  });
})();
