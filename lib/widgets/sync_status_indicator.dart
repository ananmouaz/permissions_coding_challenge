import 'package:flutter/material.dart';
import '../cubits/consent_state.dart';

class SyncStatusIndicator extends StatelessWidget {
  final SyncStatus status;
  final VoidCallback onRetry;

  const SyncStatusIndicator({
    Key? key,
    required this.status,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case SyncStatus.initial:
        return const _StatusCard(
          icon: Icons.cloud_off_outlined,
          color: Colors.grey,
          text: 'Not synced',
          showRetry: false,
        );
      case SyncStatus.pending:
        return _StatusCard(
          icon: Icons.sync,
          color: Colors.blue,
          text: 'Syncing...',
          showRetry: false,
          isLoading: true,
          onRetry: onRetry,
        );
      case SyncStatus.synced:
        return const _StatusCard(
          icon: Icons.cloud_done,
          color: Colors.green,
          text: 'Synced',
          showRetry: false,
        );
      case SyncStatus.failed:
        return _StatusCard(
          icon: Icons.cloud_off,
          color: Colors.red,
          text: 'Sync failed',
          showRetry: true,
          onRetry: onRetry,
        );
    }
  }
}

class _StatusCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final bool showRetry;
  final bool isLoading;
  final VoidCallback? onRetry;

  const _StatusCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
    required this.showRetry,
    this.isLoading = false,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isLoading
              ? SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          )
              : Icon(icon, color: color),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (showRetry) ...[
            const SizedBox(width: 16),
            InkWell(
              onTap: onRetry,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh, color: color, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Retry',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}