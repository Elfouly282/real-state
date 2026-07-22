import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../../utils/app_styles.dart';

/// Renders text in a light / secondary style used for supporting data.
class TableMutedCell extends StatelessWidget {
  final String text;

  const TableMutedCell(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: getRegularStyle(
          fontSize: AppFonts.bodySmall,
          color: AppColors.textSecondaryColor,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );
}
