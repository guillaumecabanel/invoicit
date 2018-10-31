document.addEventListener('DOMContentLoaded', function(event) {
  var chart = document.querySelector('.chart-container');

  if (chart) {
    var chartLegends = document.querySelectorAll('.percentage-chart + .chart-legend');
    chartLegends.forEach(function(chartLegend) {
      chartLegend.setAttribute('transform', "translate(50, 100)");
    })
  }
})
