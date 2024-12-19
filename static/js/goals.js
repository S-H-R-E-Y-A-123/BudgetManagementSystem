// goals-progress.js

const goalChartContext = document.getElementById('goalChart').getContext('2d');
let goalChart;

// Initialize empty data for the chart
let chartData = {
  labels: [],
  datasets: [{
    label: 'Goal Progress',
    data: [],
    backgroundColor: ['#76b041', '#b0d481'],
  }]
};

function addGoal() {
  const targetAmount = parseFloat(document.getElementById('targetAmount').value);
  const currentAmount = parseFloat(document.getElementById('currentAmount').value);
  const goalName = `Goal ${chartData.labels.length + 1}`;

  // Update chart data
  chartData.labels.push(goalName);
  chartData.datasets[0].data.push(currentAmount);

  // Re-render the chart
  if (goalChart) {
    goalChart.destroy();
  }

  goalChart = new Chart(goalChartContext, {
    type: 'pie',
    data: chartData,
    options: {
      responsive: true,
      plugins: {
        tooltip: {
          callbacks: {
            label: (context) => `${context.label}: ₹${context.raw} out of ₹${targetAmount}`
          }
        }
      }
    }
  });

  // Clear input fields after adding
  document.getElementById('goal-form').reset();
}