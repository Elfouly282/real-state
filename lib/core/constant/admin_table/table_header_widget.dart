import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import 'table_constants.dart';

// ── TableHeaderWidget ─────────────────────────────────────────────────────────

/// Sticky header row rendered above the data rows.
///
/// - The **ID** column is rendered as a fixed [kIdW]-wide slot.
/// - Every other column receives an [Expanded] with the matching flex ratio.
/// - Padding follows the [kTableH] / [kColGap] constants so all columns
///   align perfectly with [TableRowWidget].
class TableHeaderWidget extends StatelessWidget {
  final List<String> headers;
  final List<int> flexes;

  const TableHeaderWidget({
    super.key,
    required this.headers,
    required this.flexes,
  });

  // ── text style ──────────────────────────────────────────────────────────────

  static TextStyle get _labelStyle => TextStyle(
        fontSize: AppFonts.labelSmall,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryColor,
        letterSpacing: 0.5,
        fontFamily: AppFonts.questFont,
      );

  // ── helpers ─────────────────────────────────────────────────────────────────

  /// Left padding for a non-ID column at index [i].
  static double _leftPad(int i) => kColGap / 2;

  /// Right padding for a non-ID column at index [i] in a list of [total] headers.
  static double _rightPad(int i, int total) =>
      (i == total - 1) ? kTableH : kColGap / 2;

  // ── build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final cols = <Widget>[];

    for (int i = 0; i < headers.length; i++) {
      final isId = headers[i].toUpperCase() == 'ID';

      if (isId) {
        cols.add(_buildIdCell());
      } else {
        cols.add(_buildRegularCell(i));
      }
    }

    return Container(
      height: kHeaderH,
      color: AppColors.tableHeaderBg,
      child: Row(children: cols),
    );
  }

  // ── cell builders ────────────────────────────────────────────────────────────

  Widget _buildIdCell() {
    return SizedBox(
      width: kIdW,
      child: Padding(
        padding: const EdgeInsets.only(left: kTableH, right: kColGap / 2),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('ID', style: _labelStyle),
        ),
      ),
    );
  }

  Widget _buildRegularCell(int i) {
    return Expanded(
      flex: flexes[i],
      child: Padding(
        padding: EdgeInsets.only(
          left: _leftPad(i),
          right: _rightPad(i, headers.length),
        ),
        child: Text(
          headers[i].toUpperCase(),
          style: _labelStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
