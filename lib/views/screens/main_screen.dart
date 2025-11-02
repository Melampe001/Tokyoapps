import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../viewmodels/roulette_viewmodel.dart';
import '../../utils/constants.dart';
import '../widgets/roulette_wheel_widget.dart';
import '../widgets/prediction_panel.dart';
import '../widgets/stats_chart.dart';
import '../widgets/subscription_upgrade_dialog.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }
  
  Future<void> _requestPermissions() async {
    // Request camera permission for OCR
    await Permission.camera.request();
    
    // Request vibration permission
    await Permission.vibration.request();
  }
  
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RouletteViewModel>(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tokyo Roulette'),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        actions: [
          // Roulette type toggle
          Switch(
            value: viewModel.isEuropean,
            onChanged: (_) => viewModel.toggleRouletteType(),
            activeColor: AppColors.neonGreen,
          ),
          Text(
            viewModel.isEuropean ? 'EUR' : 'USA',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 16),
          
          // Subscription badge
          GestureDetector(
            onTap: () => _showSubscriptionDialog(context),
            child: Chip(
              label: Text(
                viewModel.subscription.tier.toString().split('.').last.toUpperCase(),
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              backgroundColor: _getTierColor(viewModel.subscription.tier),
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: isLandscape ? _buildLandscapeLayout(viewModel) : _buildPortraitLayout(viewModel),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
  
  Widget _buildPortraitLayout(RouletteViewModel viewModel) {
    return IndexedStack(
      index: _selectedIndex,
      children: [
        _buildMainTab(viewModel),
        _buildStatsTab(viewModel),
        _buildHistoryTab(viewModel),
      ],
    );
  }
  
  Widget _buildLandscapeLayout(RouletteViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _buildMainTab(viewModel),
        ),
        Expanded(
          flex: 2,
          child: _buildStatsTab(viewModel),
        ),
      ],
    );
  }
  
  Widget _buildMainTab(RouletteViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Last spin result with neon effect
          if (viewModel.lastSpinNumber != null) ...[
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.getNumberColor(viewModel.lastSpinNumber!).withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'LAST SPIN',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    viewModel.lastSpinNumber == 37 ? '00' : '${viewModel.lastSpinNumber}',
                    style: TextStyle(
                      color: AppColors.getNumberColor(viewModel.lastSpinNumber!),
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: AppColors.getNumberColor(viewModel.lastSpinNumber!).withOpacity(0.8),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
          
          // Roulette wheel visualization
          const RouletteWheelWidget(),
          const SizedBox(height: 20),
          
          // Spin buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: viewModel.isLoading ? null : () => viewModel.performManualSpin(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('MANUAL SPIN'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonRed,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: viewModel.isLoading ? null : () => _performCameraSpin(viewModel),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('CAMERA SPIN'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Spin counts (for testing requirement)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSpinCounter('Manual', viewModel.manualSpinCount, AppConstants.requiredManualSpins),
                _buildSpinCounter('Camera', viewModel.cameraSpinCount, AppConstants.requiredCameraSpins),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Prediction panel
          const PredictionPanel(),
        ],
      ),
    );
  }
  
  Widget _buildSpinCounter(String label, int count, int required) {
    final percentage = (count / required * 100).clamp(0, 100);
    final isComplete = count >= required;
    
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          '$count / $required',
          style: TextStyle(
            color: isComplete ? AppColors.neonGreen : AppColors.neonRed,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 80,
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation(
              isComplete ? AppColors.neonGreen : AppColors.neonRed,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatsTab(RouletteViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'STATISTICS',
            style: TextStyle(
              color: AppColors.neonRed,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          
          // 3D Bar chart
          const StatsChart(),
          const SizedBox(height: 20),
          
          // Number frequency grid
          _buildFrequencyGrid(viewModel),
        ],
      ),
    );
  }
  
  Widget _buildFrequencyGrid(RouletteViewModel viewModel) {
    final maxNumber = viewModel.isEuropean ? 37 : 38;
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: maxNumber,
      itemBuilder: (context, index) {
        final number = index;
        final frequency = viewModel.history.where((s) => s.number == number).length;
        
        return Container(
          decoration: BoxDecoration(
            color: AppColors.getNumberColor(number).withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.getNumberColor(number),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number == 37 ? '00' : '$number',
                style: TextStyle(
                  color: AppColors.getNumberColor(number),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$frequency',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildHistoryTab(RouletteViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SPIN HISTORY',
                style: TextStyle(
                  color: AppColors.neonRed,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _confirmClearHistory(viewModel),
                icon: const Icon(Icons.delete),
                label: const Text('Clear'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade900,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: viewModel.history.length,
            itemBuilder: (context, index) {
              final spin = viewModel.history[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.getNumberColor(spin.number),
                  child: Text(
                    spin.number == 37 ? '00' : '${spin.number}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  spin.getColorName(),
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  '${spin.method.toUpperCase()} - ${spin.timestamp.toString().substring(0, 19)}',
                  style: const TextStyle(color: Colors.white60),
                ),
                trailing: Icon(
                  spin.method == 'camera' ? Icons.camera_alt : Icons.touch_app,
                  color: AppColors.neonGreen,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      backgroundColor: AppColors.cardBackground,
      selectedItemColor: AppColors.neonRed,
      unselectedItemColor: Colors.white60,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.casino),
          label: 'Roulette',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Stats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
    );
  }
  
  Future<void> _performCameraSpin(RouletteViewModel viewModel) async {
    // Initialize camera if needed
    if (!viewModel.isCameraInitialized) {
      final initialized = await viewModel.initializeCamera();
      if (!initialized) {
        _showError('Camera not available');
        return;
      }
    }
    
    await viewModel.performCameraSpin();
    
    if (viewModel.errorMessage != null) {
      _showError(viewModel.errorMessage!);
    }
  }
  
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
  
  void _showSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const SubscriptionUpgradeDialog(),
    );
  }
  
  void _confirmClearHistory(RouletteViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History?'),
        content: const Text('This will delete all spin records. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              viewModel.clearHistory();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
  
  Color _getTierColor(SubscriptionTier tier) {
    switch (tier) {
      case SubscriptionTier.free:
        return Colors.grey;
      case SubscriptionTier.advanced:
        return Colors.blue;
      case SubscriptionTier.premium:
        return Colors.amber;
    }
  }
}
