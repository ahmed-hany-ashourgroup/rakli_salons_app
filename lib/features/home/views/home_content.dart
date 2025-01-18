// Updated HomeContent Widget
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String selectedPeriod = 'Weekly';
  final List<String> periods = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeriodSelector(),
          const SizedBox(height: 20),
          _buildStatisticsCards(),
          const SizedBox(height: 32),
          const Text(
            'Analytics',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildAnalyticsChart(),
          const SizedBox(height: 24),
          _buildGenderDistribution(),
          const SizedBox(height: 24),
          _buildRevenueChart(),
          const SizedBox(height: 66),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: PopupMenuButton<String>(
        initialValue: selectedPeriod,
        onSelected: (String value) {
          setState(() {
            selectedPeriod = value;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                selectedPeriod,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        itemBuilder: (BuildContext context) {
          return periods.map((String period) {
            return PopupMenuItem<String>(
              value: period,
              child: Text(period),
            );
          }).toList();
        },
      ),
    );
  }

  Widget _buildStatisticsCards() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildStatCard(
          'Total Bookings',
          '2004',
          Icons.calendar_today,
          Colors.pink,
          null,
        ),
        _buildStatCard(
          'Customers',
          '3000',
          Icons.people,
          Colors.blue,
          const _TrendIndicator(
            percentage: 20,
            isIncrease: false,
          ),
        ),
        _buildStatCard(
          'Active Services',
          '3',
          Icons.design_services,
          Colors.blue,
          null,
        ),
        _buildStatCard(
          'Upcoming\nAppointments',
          '4',
          Icons.schedule,
          Colors.orange,
          const _TrendIndicator(
            percentage: 20,
            isIncrease: true,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    Widget? trailing,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 24,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildAnalyticsChart() {
  return Container(
    height: 200,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 4,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Analytics',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: BarChart(
            BarChartData(
              barGroups: _getBarGroups(),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const months = [
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug'
                      ];
                      return Text(
                        months[value.toInt()],
                        style: const TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

List<BarChartGroupData> _getBarGroups() {
  const months = [0, 1, 2, 3, 4, 5, 6, 7];
  final oldCustomers = [20, 40, 100, 150, 60, 90, 40, 50];
  final newCustomers = [30, 60, 140, 80, 70, 50, 30, 40];

  return List.generate(months.length, (index) {
    return BarChartGroupData(
      x: months[index],
      barRods: [
        BarChartRodData(
          toY: oldCustomers[index].toDouble(),
          color: Colors.blue,
          width: 8,
        ),
        BarChartRodData(
          toY: newCustomers[index].toDouble(),
          color: Colors.green,
          width: 8,
        ),
      ],
    );
  });
}

Widget _buildGenderDistribution() {
  return Container(
    height: 200,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 4,
        ),
      ],
    ),
    child: PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 30,
            color: Colors.blue,
            title: 'Male\n30%',
            radius: 80,
          ),
          PieChartSectionData(
            value: 70,
            color: Colors.pink,
            title: 'Female\n70%',
            radius: 80,
          ),
        ],
      ),
    ),
  );
}

Widget _buildRevenueChart() {
  return Container(
    height: 200,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 4,
        ),
      ],
    ),
    child: LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const months = [
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug'
                ];
                return Text(
                  months[value.toInt()],
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 1000),
              FlSpot(1, 1800),
              FlSpot(2, 1600),
              FlSpot(3, 2200),
              FlSpot(4, 1800),
              FlSpot(5, 2000),
              FlSpot(6, 1800),
              FlSpot(7, 1600),
            ],
            isCurved: true,
            color: Colors.blue.withOpacity(0.5),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.1),
            ),
          ),
        ],
      ),
    ),
  );
}

class _TrendIndicator extends StatelessWidget {
  final double percentage;
  final bool isIncrease;

  const _TrendIndicator({
    required this.percentage,
    required this.isIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${percentage.toStringAsFixed(0)}%',
          style: TextStyle(
            color: isIncrease ? Colors.green : Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Icon(
          isIncrease ? Icons.arrow_upward : Icons.arrow_downward,
          color: isIncrease ? Colors.green : Colors.red,
          size: 14,
        ),
      ],
    );
  }
}
