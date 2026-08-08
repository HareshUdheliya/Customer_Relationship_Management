document.addEventListener("DOMContentLoaded", function () {
  if (typeof ApexCharts === "undefined") return;

  var el1 = document.querySelector("#leadsConversionChart");
  if (el1) {
    new ApexCharts(el1, {
      chart: { type: "line", height: 260, toolbar: { show: false } },
      series: [{ name: "Converted Leads", data: [8, 12, 10, 15, 18, 22] }],
      xaxis: { categories: ["Feb","Mar","Apr","May","Jun","Jul"] },
      colors: ["#696cff"],
      stroke: { curve: "smooth", width: 3 },
      dataLabels: { enabled: false },
      grid: { borderColor: "#eceef1" }
    }).render();
  }

  var el2 = document.querySelector("#taskCompletionChart");
  if (el2) {
    new ApexCharts(el2, {
      chart: { type: "radialBar", height: 260 },
      series: [76],
      labels: ["Completed"],
      colors: ["#28c76f"]
    }).render();
  }
});
