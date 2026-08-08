/* ===========================================================
   Dashboard charts (ApexCharts)
   Sample data now — will be replaced by real API data once
   the backend is connected.
   =========================================================== */

document.addEventListener("DOMContentLoaded", function () {
  if (typeof ApexCharts === "undefined") return;

  // ---- Leads by status (bar chart) ----
  var leadsEl = document.querySelector("#leadsStatusChart");
  if (leadsEl) {
    new ApexCharts(leadsEl, {
      chart: { type: "bar", height: 260, toolbar: { show: false } },
      series: [{ name: "Leads", data: [42, 28, 19, 11, 6] }],
      xaxis: { categories: ["New", "Contacted", "Qualified", "Won", "Lost"] },
      colors: ["#696cff"],
      plotOptions: { bar: { borderRadius: 6, columnWidth: "45%" } },
      dataLabels: { enabled: false },
      grid: { borderColor: "#eceef1" }
    }).render();
  }

  // ---- Customers growth (area chart) ----
  var customersEl = document.querySelector("#customersGrowthChart");
  if (customersEl) {
    new ApexCharts(customersEl, {
      chart: { type: "area", height: 260, toolbar: { show: false } },
      series: [{ name: "Customers", data: [120, 132, 141, 154, 162, 178, 190, 205, 221, 236, 248, 261] }],
      xaxis: {
        categories: ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
      },
      colors: ["#28c76f"],
      dataLabels: { enabled: false },
      stroke: { curve: "smooth", width: 2 },
      fill: { type: "gradient", gradient: { shadeIntensity: 1, opacityFrom: 0.35, opacityTo: 0.05 } },
      grid: { borderColor: "#eceef1" }
    }).render();
  }

  // ---- Task status (donut chart) ----
  var tasksEl = document.querySelector("#taskStatusChart");
  if (tasksEl) {
    new ApexCharts(tasksEl, {
      chart: { type: "donut", height: 260 },
      series: [12, 19, 7],
      labels: ["Pending", "In Progress", "Completed"],
      colors: ["#ff9f43", "#696cff", "#28c76f"],
      legend: { position: "bottom" },
      dataLabels: { enabled: false }
    }).render();
  }
});
