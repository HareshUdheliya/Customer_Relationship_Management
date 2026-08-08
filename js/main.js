/* ===========================================================
   CRM Main JS
   Theme config + menu & auth navbar state initialization
   =========================================================== */

// Theme configuration
window.templateConfig = {
  skin: "default",
  contentLayout: "wide",
  headerType: "fixed",
  navbarType: "sticky",
  menuFixed: true,
  menuCollapsed: false,
  showDropdownOnHover: true,
  direction: "ltr",
};

document.addEventListener("DOMContentLoaded", function () {
  // Initialize the vertical menu (Sneat's menu.js exposes window.Menu)
  var menuEl = document.querySelector("#layout-menu");
  if (menuEl && window.Menu) {
    var menu = new Menu(menuEl, {
      orientation: "vertical",
      closeChildren: false,
    });
    window.Helpers && Helpers.setCollapsed(true, false);
  }

  // Perfect Scrollbar on the menu inner
  var psMenu = document.querySelector(".menu-inner");
  if (psMenu && window.PerfectScrollbar) {
    new PerfectScrollbar(psMenu, {
      wheelPropagation: false,
      suppressScrollX: true,
    });
  }

  // Sidebar toggle (mobile + collapse)
  document.querySelectorAll(".layout-menu-toggle").forEach(function (btn) {
    btn.addEventListener("click", function (e) {
      e.preventDefault();
      document.documentElement.classList.toggle("layout-menu-expanded");
    });
  });

  // Active menu item auto-highlight based on current page
  var current = window.location.pathname.split("/").pop() || "index.html";
  document.querySelectorAll(".menu-link").forEach(function (link) {
    var href = link.getAttribute("href");
    if (href === current) {
      var item = link.closest(".menu-item");
      if (item) item.classList.add("active");
    }
  });

  function getStoredUser() {
    var role =
      sessionStorage.getItem("crmUserRole") ||
      localStorage.getItem("crmUserRole");
    var email =
      sessionStorage.getItem("crmUserEmail") ||
      localStorage.getItem("crmUserEmail");
    if (!role || !email) {
      return null;
    }
    return { role: role, email: email };
  }

  function wireLogoutLinks() {
    document.querySelectorAll('a[href="login.html"]').forEach(function (link) {
      link.addEventListener("click", function () {
        sessionStorage.removeItem("crmUserRole");
        sessionStorage.removeItem("crmUserEmail");
        sessionStorage.removeItem("crmUserName");
        localStorage.removeItem("crmUserRole");
        localStorage.removeItem("crmUserEmail");
        localStorage.removeItem("crmUserName");
      });
      link.setAttribute("href", "login.html?logout=1");
    });
  }

  function applyNavbarState(user) {
    var loginGroup = document.querySelector(".nav-login-group");
    var profileDropdown = document.querySelector(".dropdown-user");

    if (user) {
      // User is logged in: show profile dropdown, hide login buttons
      if (loginGroup) loginGroup.classList.add("d-none");
      if (profileDropdown) profileDropdown.classList.remove("d-none");

      // Update avatar initials
      var avatar = document.querySelector(".dropdown-user .crm-avatar-sm");
      if (avatar) {
        var name =
          sessionStorage.getItem("crmUserName") ||
          localStorage.getItem("crmUserName");
        if (name) {
          var parts = name.split(" ");
          avatar.textContent = (
            parts[0][0] + (parts[1] ? parts[1][0] : "")
          ).toUpperCase();
        } else {
          avatar.textContent = user.role === "admin" ? "AD" : "EM";
        }
      }
    } else {
      // Guest mode (not logged in): show login/register buttons, hide profile dropdown
      if (loginGroup) loginGroup.classList.remove("d-none");
      if (profileDropdown) profileDropdown.classList.add("d-none");
    }
  }

  function updateWelcomeText(user) {
    var displayName = user
      ? sessionStorage.getItem("crmUserName") ||
        localStorage.getItem("crmUserName") ||
        (user.role === "admin" ? "Admin" : "Employee")
      : "Guest";
    document
      .querySelectorAll(".content-wrapper .text-muted")
      .forEach(function (node) {
        if (node.textContent.trim().startsWith("Welcome back")) {
          node.textContent = user
            ? "Welcome back, " +
              displayName +
              ". Here's what's happening today."
            : "Welcome to CRM System. Sign in to preview the CRM workspace.";
        }
      });
  }

  function updateProfilePage(user) {
    if (!user) return;
    var name =
      sessionStorage.getItem("crmUserName") ||
      localStorage.getItem("crmUserName") ||
      (user.role === "admin" ? "Admin User" : "Employee User");
    var avatar = document.querySelector(".crm-avatar-sm.mx-auto.mb-3");
    if (avatar) {
      var parts = name.split(" ");
      avatar.textContent = (
        parts[0][0] + (parts[1] ? parts[1][0] : "")
      ).toUpperCase();
    }

    var nameHeading = document.querySelector(".card-body.text-center h5");
    if (nameHeading) {
      nameHeading.textContent = name;
    }

    var roleLabel = document.querySelector(
      ".card-body.text-center span.text-muted",
    );
    if (roleLabel) {
      roleLabel.textContent =
        user.role === "admin" ? "Administrator" : "Employee";
    }

    var profileFields = document.querySelectorAll(
      ".card.mb-4 .card-body input.form-control",
    );
    if (profileFields.length >= 4) {
      profileFields[0].value = name;
      profileFields[1].value = user.email;
      profileFields[2].value = "+91 98200 00000";
      profileFields[3].value =
        user.role === "admin" ? "Administrator" : "Employee";
    }
  }

  var pageName = window.location.pathname.split("/").pop() || "index.html";
  var user = getStoredUser();

  if (pageName !== "login.html" && pageName !== "register.html") {
    applyNavbarState(user);
    if (user) {
      wireLogoutLinks();
      updateWelcomeText(user);
      updateProfilePage(user);
    } else {
      updateWelcomeText(null);
    }
  } else {
    applyNavbarState(null);
  }
});
