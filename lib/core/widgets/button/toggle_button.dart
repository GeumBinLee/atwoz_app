import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:atwoz_app/core/theme/app_colors.dart';

class ToggleButton extends StatelessWidget {
  final bool controller;
  final void Function(dynamic) onChanged;

  const ToggleButton({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
        width: 42.0,
        height: 24.0,
        valueFontSize: 0,
        toggleSize: 20.0,
        value: controller,
        borderRadius: 50.0,
        padding: 2.0,
        activeColor: AppColors.colorPrimary500,
        inactiveColor: AppColors.colorGrey500,
        showOnOff: true,
        onToggle: onChanged);
  }
}
