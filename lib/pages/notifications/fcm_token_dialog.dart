import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../features/notifications/notification_state.dart';
import '../../l10n/app_localizations.dart';

Future<void> showFcmTokenDialog(
  BuildContext context,
  NotificationState notificationState,
) async {
  final l10n = AppLocalizations.of(context)!;
  final token = notificationState.fcmToken;
  final content =
      token ?? notificationState.error ?? l10n.fcmTokenUnavailable;

  await showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(l10n.fcmToken),
        content: SelectableText(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.close),
          ),
          if (token != null)
            FilledButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: token));
                if (!dialogContext.mounted) return;
                Navigator.pop(dialogContext);
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.fcmTokenCopied)),
                );
              },
              icon: const Icon(Icons.copy),
              label: Text(l10n.copyFcmToken),
            ),
        ],
      );
    },
  );
}
