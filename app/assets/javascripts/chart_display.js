document.addEventListener('DOMContentLoaded', function(event) {
  const chart = document.querySelector('.chart-container');

  if (chart) {
    const chartLegends = document.querySelectorAll('.percentage-chart + .chart-legend');
    chartLegends.forEach(function(chartLegend) {
      chartLegend.setAttribute('transform', "translate(50, 100)");
    })
  }
})
