/* Customers Page Logic */
document.addEventListener("DOMContentLoaded", function () {
  console.log("Customers Page JS initialized.");

  // Table search filter
  var searchInput = document.getElementById("customerSearchInput");
  if (searchInput) {
    searchInput.addEventListener("keyup", function () {
      var query = searchInput.value.toLowerCase();
      var rows = document.querySelectorAll("tbody tr");
      rows.forEach(function (row) {
        var text = row.textContent.toLowerCase();
        row.style.display = text.indexOf(query) > -1 ? "" : "none";
      });
    });
  }
});
