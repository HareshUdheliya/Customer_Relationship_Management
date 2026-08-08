/* Reports Page Logic */
document.addEventListener("DOMContentLoaded", function () {
  console.log("Reports Page JS initialized.");

  // Check if existing reports.js or ApexCharts initialized
  if (typeof ApexCharts !== "undefined" && document.querySelector("#salesReportChart")) {
    var options = {
      series: [{
        name: 'Sales ($)',
        data: [12000, 18000, 15000, 24000, 31000, 28000, 42000]
      }],
      chart: {
        type: 'bar',
        height: 320
      },
      colors: ['#696cff'],
      xaxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul']
      }
    };
    var chartContainer = document.querySelector("#salesReportChart");
    if (chartContainer && !chartContainer.hasChildNodes()) {
      var chart = new ApexCharts(chartContainer, options);
      chart.render();
    }
  }
});
