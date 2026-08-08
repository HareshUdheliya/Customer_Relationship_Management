/* Notes Page Logic */
document.addEventListener("DOMContentLoaded", function () {
  console.log("Notes Page JS initialized.");

  var searchInput = document.getElementById("noteSearchInput");
  if (searchInput) {
    searchInput.addEventListener("keyup", function () {
      var query = searchInput.value.toLowerCase();
      var items = document.querySelectorAll(".note-card, tbody tr");
      items.forEach(function (item) {
        var text = item.textContent.toLowerCase();
        item.style.display = text.indexOf(query) > -1 ? "" : "none";
      });
    });
  }
});
