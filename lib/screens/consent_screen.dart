import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/consent_cubit.dart';
import '../cubits/consent_state.dart';
import '../widgets/consent_toggle.dart';
import '../widgets/sync_status_indicator.dart';

class ConsentScreen extends StatelessWidget {
  const ConsentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Privacy Settings'),
        elevation: 0,
      ),
      body: BlocBuilder<ConsentCubit, ConsentState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  const Text(
                    'Data Sharing Preferences',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please choose which information you\'d like to share with us to improve your experience.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Toggle switches
                  ConsentToggle(
                    title: 'Share Location',
                    description: 'Allow access to your location to enable location-based features',
                    icon: Icons.location_on,
                    value: state.consent.shareLocation,
                    onChanged: (value) {
                      context.read<ConsentCubit>().updateConsent(
                        shareLocation: value,
                      );
                    },
                  ),
                  ConsentToggle(
                    title: 'Share Usage Analytics',
                    description: 'Help us improve by sharing anonymous usage data',
                    icon: Icons.analytics,
                    value: state.consent.shareUsageAnalytics,
                    onChanged: (value) {
                      context.read<ConsentCubit>().updateConsent(
                        shareUsageAnalytics: value,
                      );
                    },
                  ),
                  ConsentToggle(
                    title: 'Share Crash Reports',
                    description: 'Send crash reports to help us fix issues faster',
                    icon: Icons.bug_report,
                    value: state.consent.shareCrashReports,
                    onChanged: (value) {
                      context.read<ConsentCubit>().updateConsent(
                        shareCrashReports: value,
                      );
                    },
                  ),
                  const SizedBox(height: 32),

                  // Sync section
                  const Text(
                    'Sync Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: SyncStatusIndicator(
                      status: state.syncStatus,
                      onRetry: () {
                        context.read<ConsentCubit>().retrySync();
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Sync buttons (for demo)
                  const Text(
                    'Demo Controls',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _DemoButton(
                        text: 'Simulate Success',
                        icon: Icons.check_circle,
                        color: Colors.green,
                        onPressed: () {
                          context.read<ConsentCubit>().simulateSuccessSync();
                        },
                      ),
                      _DemoButton(
                        text: 'Simulate Failure',
                        icon: Icons.error,
                        color: Colors.red,
                        onPressed: () {
                          context.read<ConsentCubit>().simulateFailureSync();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Save button at the bottom
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ConsentCubit>().syncConsent();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Save and Sync',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DemoButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _DemoButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}