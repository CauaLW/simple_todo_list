import 'package:flutter/material.dart';

class SwitchInput extends StatelessWidget {
  final bool initialValue;
  final String label;
  final bool enabled;
  final void Function(bool value)? onChanged;
  const SwitchInput({
    super.key,
    this.initialValue = false,
    required this.label,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Switch(
          value: initialValue,
          onChanged: enabled ? onChanged : null,
        ),
      ],
    );
  }
}
