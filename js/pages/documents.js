/* Documents Page Logic */
document.addEventListener("DOMContentLoaded", function () {
  console.log("Documents Page JS initialized.");

  var searchInput = document.getElementById("docSearchInput");
  if (searchInput) {
    searchInput.addEventListener("keyup", function () {
      var query = searchInput.value.toLowerCase();
      var rows = document.querySelectorAll("tbody tr, .doc-file-card");
      rows.forEach(function (row) {
        var text = row.textContent.toLowerCase();
        row.style.display = text.indexOf(query) > -1 ? "" : "none";
      });
    });
  }
});
