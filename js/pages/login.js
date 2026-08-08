/* Login Page Script */
(function () {
  function getRegisteredUsers() {
    var stored = localStorage.getItem("crmRegisteredUsers");
    return stored ? JSON.parse(stored) : [];
  }

  function authenticateUser(email, password) {
    var registered = getRegisteredUsers();
    var found = registered.find(function (u) {
      return (
        u.email.toLowerCase() === email.toLowerCase() && u.password === password
      );
    });

    if (found) {
      return {
        role: found.role || "user",
        email: found.email,
        name: found.name,
      };
    }

    // UI-only preview mode: accept any non-empty credentials.
    return {
      role: "user",
      email: email,
      name: email.split("@")[0] || "CRM User",
    };
  }

  function getQueryParam(name) {
    return new URLSearchParams(window.location.search).get(name);
  }

  function showError(message) {
    var errorEl = document.getElementById("loginError");
    if (!errorEl) return;
    errorEl.textContent = message;
    errorEl.classList.remove("d-none");
    errorEl.classList.remove("alert-success");
    errorEl.classList.add("alert-danger");
  }

  function showSuccess(message) {
    var errorEl = document.getElementById("loginError");
    if (!errorEl) return;
    errorEl.textContent = message;
    errorEl.classList.remove("d-none");
    errorEl.classList.remove("alert-danger");
    errorEl.classList.add("alert-success");
  }

  document.addEventListener("DOMContentLoaded", function () {
    if (getQueryParam("logout") === "1") {
      sessionStorage.removeItem("crmUserRole");
      sessionStorage.removeItem("crmUserEmail");
      sessionStorage.removeItem("crmUserName");
      localStorage.removeItem("crmUserRole");
      localStorage.removeItem("crmUserEmail");
      localStorage.removeItem("crmUserName");
      showSuccess("You have been signed out successfully.");
    } else if (getQueryParam("registered") === "1") {
      showSuccess(
        "Account created successfully! Please sign in with your credentials.",
      );
    }

    var loginForm = document.getElementById("loginForm");
    if (!loginForm) return;

    loginForm.addEventListener("submit", function (e) {
      e.preventDefault();

      var emailInput = document.getElementById("email");
      var passwordInput = document.getElementById("password");
      var rememberInput = document.getElementById("remember");
      if (!emailInput || !passwordInput) return;

      var email = emailInput.value.trim().toLowerCase();
      var password = passwordInput.value;

      if (!email || !password) {
        showError("Please enter both email address and password.");
        return;
      }

      var user = authenticateUser(email, password);
      if (!email || !password) {
        showError("Please enter both email address and password.");
        return;
      }

      // Always set session storage for current tab/browser window
      sessionStorage.setItem("crmUserRole", user.role);
      sessionStorage.setItem("crmUserEmail", user.email);
      sessionStorage.setItem("crmUserName", user.name);

      // If Remember Me is checked, persist in localStorage as well
      if (rememberInput && rememberInput.checked) {
        localStorage.setItem("crmUserRole", user.role);
        localStorage.setItem("crmUserEmail", user.email);
        localStorage.setItem("crmUserName", user.name);
      } else {
        localStorage.removeItem("crmUserRole");
        localStorage.removeItem("crmUserEmail");
        localStorage.removeItem("crmUserName");
      }

      window.location.href = "index.html";
    });
  });
})();
