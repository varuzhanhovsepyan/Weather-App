import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/notifications/notification_state.dart';
import '../../l10n/app_localizations.dart';
import 'fcm_token_dialog.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(l10n.pushNotifications),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: Consumer<NotificationState>(
        builder: (context, notificationState, child) {
          if (notificationState.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final token = notificationState.fcmToken;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.fcmToken,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                Material(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SelectableText(
                      token ??
                          notificationState.error ??
                          l10n.fcmTokenUnavailable,
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                if (token != null) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        showFcmTokenDialog(context, notificationState);
                      },
                      icon: const Icon(Icons.copy),
                      label: Text(l10n.copyFcmToken),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
