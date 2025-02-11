// Updated HomeContent Widget
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/views/appointments_view.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  ViewPeriod selectedPeriod = ViewPeriod.weekly; // Use enum for selected period

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
          Text(
            S.of(context).analytics,
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

  // Period Selector with Enum and Dropdown Menu
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
      child: PopupMenuButton<ViewPeriod>(
        color: kPrimaryColor,
        initialValue: selectedPeriod,
        onSelected: (ViewPeriod period) {
          setState(() {
            selectedPeriod = period;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _getPeriodText(selectedPeriod), // Convert enum to display text
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
          return ViewPeriod.values.map((ViewPeriod period) {
            return PopupMenuItem<ViewPeriod>(
              value: period,
              child: Text(
                _getPeriodText(period),
                style: AppStyles.regular14.copyWith(
                    color: Colors.white), // Convert enum to display text
              ),
            );
          }).toList();
        },
      ),
    );
  }

  // Helper function to convert enum to display text
  String _getPeriodText(ViewPeriod period) {
    switch (period) {
      case ViewPeriod.daily:
        return S.of(context).daily;
      case ViewPeriod.weekly:
        return S.of(context).weekly;
      case ViewPeriod.monthly:
        return S.of(context).monthly;
      case ViewPeriod.yearly:
        return S.of(context).yearly;
    }
  }

  Widget _buildStatisticsCards() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildStatCard(
          S.of(context).totalBookings,
          '2004',
          Icons.calendar_today,
          Colors.pink,
          null,
        ),
        _buildStatCard(
          S.of(context).customers,
          '3000',
          Icons.people,
          Colors.blue,
          const _TrendIndicator(
            percentage: 20,
            isIncrease: false,
          ),
        ),
        _buildStatCard(
          S.of(context).activeServices,
          '3',
          Icons.design_services,
          Colors.blue,
          null,
        ),
        _buildStatCard(
          S.of(context).upcomingAppointments,
          '4',
          Icons.schedule,
          Colors.orange,
          const _TrendIndicator(
            percentage: 20,
            isIncrease: true,
          ),
        ),
      ].map((card) {
        return SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width / 2 - 24,
          child: card,
        );
      }).toList(),
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
          FittedBox(
            child: Row(
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
          Text(
            S.of(context).analytics,
            style: const TextStyle(
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
                        final months = [
                          S.of(context).january,
                          S.of(context).february,
                          S.of(context).march,
                          S.of(context).april,
                          S.of(context).may,
                          S.of(context).june,
                          S.of(context).july,
                          S.of(context).august
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).genderDistribution,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 30,
                    color: Colors.blue,
                    title: "${S.of(context).male}\n30%",
                    radius: 80,
                  ),
                  PieChartSectionData(
                    value: 70,
                    color: Colors.pink,
                    title: "${S.of(context).female}\n70%",
                    radius: 80,
                  ),
                ],
              ),
            ),
          ),
        ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).revenue,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
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
                        final months = [
                          S.of(context).january,
                          S.of(context).february,
                          S.of(context).march,
                          S.of(context).april,
                          S.of(context).may,
                          S.of(context).june,
                          S.of(context).july,
                          S.of(context).august
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
          ),
        ],
      ),
    );
  }
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
