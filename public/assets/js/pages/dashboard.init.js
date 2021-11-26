var options = {
    series: GetFolderInformation(1),
    labels: GetFolderInformation(0),
    chart: {
    width: 400,
    type: 'donut',
  },
  plotOptions: {
    pie: {
      startAngle: -90,
      endAngle: 270
    }
  },
  dataLabels: {
    enabled: true
  },
  fill: {
    type: 'line',
  },
  legend: {
    formatter: function(val, opts) {
      return val + " - " + opts.w.globals.series[opts.seriesIndex]
    }
  },
  title: {
    text: ''
  },
  responsive: [{
    breakpoint: 480,
    options: {
      chart: {
        width: 270
      },
      legend: {
        position: 'bottom'
      }
    }
  }]
  };

  var chart = new ApexCharts(document.querySelector("#donut-chart"), options);
  chart.render();