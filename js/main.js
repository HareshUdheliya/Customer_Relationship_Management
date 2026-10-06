/* ===========================================================
   CRM Main JS
   Menu + sidebar toggle + active link highlight
   (Login state is now handled on the SERVER by Site1.Master.cs,
    so the old localStorage login code was removed)
   =========================================================== */

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
    var menuEl = document.querySelector("#layout-menu");
    if (menuEl && window.Menu) {
        new Menu(menuEl, { orientation: "vertical", closeChildren: false });
    }

    var psMenu = document.querySelector(".menu-inner");
    if (psMenu && window.PerfectScrollbar) {
        new PerfectScrollbar(psMenu, { wheelPropagation: false, suppressScrollX: true });
    }

    // hamburger button (small screens) + dark overlay click
    var btn = document.getElementById("crmMenuBtn");
    var overlay = document.getElementById("crmOverlay");
    if (btn) {
        btn.addEventListener("click", function () {
            document.documentElement.classList.toggle("layout-menu-expanded");
        });
    }
    if (overlay) {
        overlay.addEventListener("click", function () {
            document.documentElement.classList.remove("layout-menu-expanded");
        });
    }

    // highlight the menu link of the current page
    var current = (window.location.pathname.split("/").pop() || "Default.aspx").toLowerCase();
    document.querySelectorAll(".menu-link").forEach(function (link) {
        var href = (link.getAttribute("href") || "").toLowerCase();
        if (href === current) {
            var item = link.closest(".menu-item");
            if (item) item.classList.add("active");
        }
    });

    // auto hide success alerts after 4 seconds
    setTimeout(function () {
        document.querySelectorAll(".alert-success.alert-dismissible").forEach(function (a) {
            a.style.transition = "opacity .5s";
            a.style.opacity = "0";
            setTimeout(function () { a.remove(); }, 500);
        });
    }, 4000);
});