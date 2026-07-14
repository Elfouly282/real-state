import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utils/app_colors.dart';

class PinCodeFields extends StatefulWidget {
  final int length;
  final Function(String) onChanged;
  final Function(String) onCompleted;
  final bool enabled;
  final TextStyle? textStyle;

  const PinCodeFields({
    super.key,
    this.length = 6,
    required this.onChanged,
    required this.onCompleted,
    this.enabled = true,
    this.textStyle,
  });

  @override
  State<PinCodeFields> createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialPinField(
      length: widget.length,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      onCompleted: widget.onCompleted,
      keyboardType: TextInputType.number,
      autoFocus: true,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      theme: MaterialPinTheme(
        shape: MaterialPinShape.circle,
        borderColor: AppColors.pink,
        cursorColor: AppColors.pink,
        fillColor: AppColors.yello,
        disabledColor: AppColors.bordergrey,
        cellSize: const Size(56, 56),
        spacing: 8.0,
      ),
    );
  }
}
