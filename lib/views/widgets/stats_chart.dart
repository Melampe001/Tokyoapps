import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../viewmodels/roulette_viewmodel.dart';
import '../../utils/constants.dart';

class StatsChart extends StatefulWidget {
  const StatsChart({super.key});

  @override
  State<StatsChart> createState() => _StatsChartState();
}

class _StatsChartState extends State<StatsChart> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RouletteViewModel>(context);
    
    if (viewModel.history.isEmpty) {
      return Container(
        height: 300,
        alignment: Alignment.center,
        child: const Text(
          'No data available\nSpin to see statistics',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white60),
        ),
      );
    }
    
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.neonGreen.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: _getMaxFrequency(viewModel).toDouble(),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: AppColors.cardBackground.withOpacity(0.9),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      'Number ${group.x.toInt()}\n${rod.toY.toInt()} spins',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() % 5 == 0) {
                        return Text(
                          value == 37 ? '00' : '${value.toInt()}',
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 10,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 10,
                        ),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 1,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.white10,
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(show: false),
              barGroups: _createBarGroups(viewModel),
            ),
          );
        },
      ),
    );
  }
  
  List<BarChartGroupData> _createBarGroups(RouletteViewModel viewModel) {
    final maxNumber = viewModel.isEuropean ? 37 : 38;
    final List<BarChartGroupData> groups = [];
    
    // Calculate frequency for each number
    Map<int, int> frequency = {};
    for (int i = 0; i < maxNumber; i++) {
      frequency[i] = 0;
    }
    
    for (var spin in viewModel.history) {
      frequency[spin.number] = (frequency[spin.number] ?? 0) + 1;
    }
    
    // Create bar groups with 3D effect
    for (int i = 0; i < maxNumber; i++) {
      final freq = frequency[i] ?? 0;
      final color = AppColors.getNumberColor(i);
      
      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: freq.toDouble() * _animation.value,
              color: color.withOpacity(0.8),
              width: 8,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: _getMaxFrequency(viewModel).toDouble(),
                color: Colors.white.withOpacity(0.05),
              ),
              rodStackItems: [
                BarChartRodStackItem(
                  0,
                  freq.toDouble() * _animation.value,
                  color,
                ),
              ],
            ),
          ],
          showingTooltipIndicators: [],
        ),
      );
    }
    
    return groups;
  }
  
  int _getMaxFrequency(RouletteViewModel viewModel) {
    final maxNumber = viewModel.isEuropean ? 37 : 38;
    int maxFreq = 0;
    
    Map<int, int> frequency = {};
    for (int i = 0; i < maxNumber; i++) {
      frequency[i] = 0;
    }
    
    for (var spin in viewModel.history) {
      frequency[spin.number] = (frequency[spin.number] ?? 0) + 1;
      if (frequency[spin.number]! > maxFreq) {
        maxFreq = frequency[spin.number]!;
      }
    }
    
    return maxFreq > 0 ? maxFreq + 2 : 10;
  }
}
