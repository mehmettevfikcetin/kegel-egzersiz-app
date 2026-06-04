import 'package:flutter/material.dart';

/// Two equal-width buttons side by side (cancel left, confirm right).
///
/// Lives in the dialog *content* (bounded width) rather than `AlertDialog.actions`
/// — the action bar is an `OverflowBar` that stacks the buttons vertically
/// because the app's `FilledButtonThemeData` forces full width
/// (`minimumSize: Size.fromHeight(52)` = infinite min width).
class _DialogButtonRow extends StatelessWidget {
  const _DialogButtonRow({
    required this.cancelLabel,
    required this.confirmLabel,
    required this.onCancel,
    required this.onConfirm,
    this.confirmColor,
  });

  final String cancelLabel;
  final String confirmLabel;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final Color? confirmColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: onCancel,
            child: Text(cancelLabel),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              backgroundColor: confirmColor,
              foregroundColor:
                  confirmColor != null ? Colors.black87 : null,
            ),
            onPressed: onConfirm,
            child: Text(confirmLabel),
          ),
        ),
      ],
    );
  }
}

/// A two-choice confirmation dialog with equal-width side-by-side buttons.
/// Returns `true` when confirmed, `false`/`null` otherwise.
Future<bool> showConfirmDialog(
  BuildContext context, {
  String? title,
  required String message,
  required String cancelLabel,
  required String confirmLabel,
  Color? confirmColor,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: title == null ? null : Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 24),
          _DialogButtonRow(
            cancelLabel: cancelLabel,
            confirmLabel: confirmLabel,
            confirmColor: confirmColor,
            onCancel: () => Navigator.pop(ctx, false),
            onConfirm: () => Navigator.pop(ctx, true),
          ),
        ],
      ),
    ),
  );
  return result ?? false;
}

/// A name-entry dialog (text field + equal-width side-by-side buttons).
/// Returns the trimmed text, or `null` if cancelled.
Future<String?> showNameInputDialog(
  BuildContext context, {
  required String title,
  required String label,
  required String cancelLabel,
  required String confirmLabel,
}) {
  return showDialog<String>(
    context: context,
    builder: (ctx) => _NameInputDialog(
      title: title,
      label: label,
      cancelLabel: cancelLabel,
      confirmLabel: confirmLabel,
    ),
  );
}

/// Owns the [TextEditingController] in its own State so it is disposed only
/// after the dialog is fully gone — disposing it inline (right after pop) made
/// the exit-animation frame rebuild the field with a disposed controller, which
/// cascaded into a framework `_dependents.isEmpty` crash.
class _NameInputDialog extends StatefulWidget {
  const _NameInputDialog({
    required this.title,
    required this.label,
    required this.cancelLabel,
    required this.confirmLabel,
  });

  final String title;
  final String label;
  final String cancelLabel;
  final String confirmLabel;

  @override
  State<_NameInputDialog> createState() => _NameInputDialogState();
}

class _NameInputDialogState extends State<_NameInputDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(labelText: widget.label),
            onSubmitted: (v) => Navigator.pop(context, v.trim()),
          ),
          const SizedBox(height: 24),
          _DialogButtonRow(
            cancelLabel: widget.cancelLabel,
            confirmLabel: widget.confirmLabel,
            onCancel: () => Navigator.pop(context),
            onConfirm: () => Navigator.pop(context, _controller.text.trim()),
          ),
        ],
      ),
    );
  }
}
