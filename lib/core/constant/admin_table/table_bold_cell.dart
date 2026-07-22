import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../../utils/app_styles.dart';

/// Renders text in a semi-bold style used for primary column values (e.g. names).
class TableBoldCell extends StatelessWidget {
  final String text;

  const TableBoldCell(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: getMediumStyle(
          fontSize: AppFonts.bodyMedium,
          color: AppColors.secondaryColor,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );
}
