import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import 'table_constants.dart';

// ── TableRowWidget ────────────────────────────────────────────────────────────

/// A single data row inside the admin table.
///
/// - The **ID** column is a fixed [kIdW]-wide slot, matching [TableHeaderWidget].
/// - Every other column receives an [Expanded] with its flex ratio.
/// - Odd rows get [AppColors.tableRowOdd] background for zebra-striping.
/// - A 1-px bottom border is drawn when [showDivider] is `true`.
class TableRowWidget extends StatelessWidget {
  final DataRow row;
  final List<String> headers;
  final List<int> flexes;
  final bool isOdd;
  final bool showDivider;

  const TableRowWidget({
    super.key,
    required this.row,
    required this.headers,
    required this.flexes,
    required this.isOdd,
    required this.showDivider,
  });

  // ── helpers ─────────────────────────────────────────────────────────────────

  static double _leftPad(int i) => kColGap / 2;

  static double _rightPad(int i, int total) =>
      (i == total - 1) ? kTableH : kColGap / 2;

  // ── build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isOdd ? AppColors.tableRowOdd : AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.tableRowDivider),
        ),
      ),
      child: SizedBox(
        height: kRowH,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildCells(),
        ),
      ),
    );
  }

  // ── cell builders ────────────────────────────────────────────────────────────

  List<Widget> _buildCells() {
    final cells = <Widget>[];

    for (int i = 0; i < row.cells.length; i++) {
      final isId = i < headers.length && headers[i].toUpperCase() == 'ID';

      if (isId) {
        cells.add(_buildIdCell(i));
      } else {
        cells.add(_buildRegularCell(i));
      }
    }

    return cells;
  }

  Widget _buildIdCell(int i) {
    return SizedBox(
      width: kIdW,
      child: Padding(
        padding: const EdgeInsets.only(left: kTableH, right: kColGap / 2),
        child: Align(
          alignment: Alignment.centerLeft,
          child: row.cells[i].child,
        ),
      ),
    );
  }

  Widget _buildRegularCell(int i) {
    final flex = i < flexes.length ? flexes[i] : 2;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.only(
          left: _leftPad(i),
          right: _rightPad(i, row.cells.length),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: row.cells[i].child,
        ),
      ),
    );
  }
}
