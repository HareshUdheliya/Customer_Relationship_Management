/* Dashboard Page Logic */
document.addEventListener("DOMContentLoaded", function () {
  console.log("Dashboard Page JS initialized.");

  // Quick stat interaction or live refresh simulation
  var refreshBtn = document.getElementById("btnRefreshStats");
  if (refreshBtn) {
    refreshBtn.addEventListener("click", function () {
      refreshBtn.classList.add("spin-animation");
      setTimeout(function () {
        refreshBtn.classList.remove("spin-animation");
      }, 600);
    });
  }

  // ApexCharts initialization check (delegated to existing dashboard.js or self-handled)
  if (typeof ApexCharts !== "undefined" && document.querySelector("#revenueChart")) {
    var options = {
      series: [{
        name: 'Revenue',
        data: [31, 40, 28, 51, 42, 109, 100]
      }, {
        name: 'Leads',
        data: [11, 32, 45, 32, 34, 52, 41]
      }],
      chart: {
        height: 310,
        type: 'area',
        toolbar: { show: false }
      },
      dataLabels: { enabled: false },
      stroke: { curve: 'smooth', width: 2 },
      colors: ['#696cff', '#00cfdd'],
      xaxis: {
        categories: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      }
    };

    var chartContainer = document.querySelector("#revenueChart");
    if (chartContainer && !chartContainer.hasChildNodes()) {
      var chart = new ApexCharts(chartContainer, options);
      chart.render();
    }
  }
});
