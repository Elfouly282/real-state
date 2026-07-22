import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import 'table_constants.dart';
import 'table_header_widget.dart';
import 'table_row_widget.dart';
import 'table_scrollbar_widget.dart';

// ── AdminTableCard ────────────────────────────────────────────────────────────

/// Responsive admin data table with:
/// - Sticky header (horizontally synced with rows).
/// - Vertical scroll inside the card when rows overflow the viewport.
/// - Sticky horizontal scrollbar at the bottom when content is wider.
/// - Shrinks to fit content height when rows are few (no empty white space).
class AdminTableCard extends StatefulWidget {
  /// Column label strings. The first column named **"ID"** is always rendered
  /// as a fixed [kIdW]-wide slot; all others use flex sizing.
  final List<String> headers;

  /// One [DataRow] per data record.
  final List<DataRow> rows;

  /// Flex ratios per column (length must equal [headers.length]).
  /// Defaults to `2` for every column when omitted.
  final List<int>? columnFlexes;

  /// Minimum total table width. When the available viewport is narrower,
  /// a horizontal scroll is activated. Defaults to `headers.length × 120`.
  final double? minWidth;

  const AdminTableCard({
    super.key,
    required this.headers,
    required this.rows,
    this.columnFlexes,
    this.minWidth,
  });

  @override
  State<AdminTableCard> createState() => AdminTableCardState();
}

// ── AdminTableCardState ───────────────────────────────────────────────────────

class AdminTableCardState extends State<AdminTableCard> {
  // Separate controllers so Flutter never throws "ScrollController attached to
  // multiple scroll views" — header & rows each have their own, kept in sync.
  late final ScrollController _rowsScroll;
  late final ScrollController _headerScroll;

  // ── lifecycle ────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _rowsScroll   = ScrollController();
    _headerScroll = ScrollController();
    _rowsScroll.addListener(_syncHeader);
  }

  @override
  void dispose() {
    _rowsScroll.removeListener(_syncHeader);
    _rowsScroll.dispose();
    _headerScroll.dispose();
    super.dispose();
  }

  // ── sync ─────────────────────────────────────────────────────────────────────

  void _syncHeader() {
    if (_headerScroll.hasClients &&
        _headerScroll.offset != _rowsScroll.offset) {
      _headerScroll.jumpTo(_rowsScroll.offset);
    }
  }

  // ── build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final flexes = widget.columnFlexes ?? List.filled(widget.headers.length, 2);

    return LayoutBuilder(
      builder: (_, outer) {
        final tableW     = _tableWidth(outer.maxWidth);
        final needsHScroll = tableW > outer.maxWidth;
        final shrink     = _shouldShrink(outer.maxHeight, needsHScroll);
        final availRows  = _availableRowsHeight(outer.maxHeight, needsHScroll);

        return SizedBox(
          height: shrink ? _naturalCardHeight(needsHScroll) : null,
          child: DecoratedBox(
            decoration: _cardDecoration,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                mainAxisSize: shrink ? MainAxisSize.min : MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(tableW),
                  const Divider(
                    height: kDividerH,
                    thickness: kDividerH,
                    color: AppColors.tableRowDivider,
                  ),
                  _buildRows(tableW, needsHScroll, shrink, availRows, flexes),
                  if (needsHScroll) _buildScrollbar(tableW, outer.maxWidth),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ── layout helpers ────────────────────────────────────────────────────────────

  double _tableWidth(double available) {
    final minW = widget.minWidth ??
        (widget.headers.length * 120.0).clamp(400.0, double.infinity);
    return available >= minW ? available : minW;
  }

  bool _shouldShrink(double outerH, bool needsHScroll) {
    return widget.rows.length * kRowH <= _availableRowsHeight(outerH, needsHScroll);
  }

  double _availableRowsHeight(double outerH, bool needsHScroll) {
    final overhead = kHeaderH + kDividerH + (needsHScroll ? kScrollbarH : 0);
    return (outerH - overhead).clamp(0.0, double.infinity);
  }

  double _naturalCardHeight(bool needsHScroll) {
    final overhead = kHeaderH + kDividerH + (needsHScroll ? kScrollbarH : 0);
    return widget.rows.length * kRowH + overhead;
  }

  // ── section builders ──────────────────────────────────────────────────────────

  Widget _buildHeader(double tableW) {
    return SingleChildScrollView(
      controller: _headerScroll,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        width: tableW,
        child: TableHeaderWidget(
          headers: widget.headers,
          flexes: widget.columnFlexes ?? List.filled(widget.headers.length, 2),
        ),
      ),
    );
  }

  Widget _buildRows(
    double tableW,
    bool needsHScroll,
    bool shrink,
    double availRows,
    List<int> flexes,
  ) {
    final content = shrink
        ? _buildShrinkRows(flexes)
        : _buildScrollRows(availRows, flexes);

    final scrollable = SingleChildScrollView(
      controller: _rowsScroll,
      scrollDirection: Axis.horizontal,
      physics: needsHScroll
          ? const ClampingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      child: SizedBox(
        width: tableW,
        child: ColoredBox(color: AppColors.white, child: content),
      ),
    );

    return shrink ? scrollable : Expanded(child: scrollable);
  }

  Widget _buildShrinkRows(List<int> flexes) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        widget.rows.length,
        (i) => TableRowWidget(
          row: widget.rows[i],
          headers: widget.headers,
          flexes: flexes,
          isOdd: i.isOdd,
          showDivider: i < widget.rows.length - 1,
        ),
      ),
    );
  }

  Widget _buildScrollRows(double height, List<int> flexes) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        itemCount: widget.rows.length,
        itemExtent: kRowH,
        itemBuilder: (_, i) => TableRowWidget(
          row: widget.rows[i],
          headers: widget.headers,
          flexes: flexes,
          isOdd: i.isOdd,
          showDivider: i < widget.rows.length - 1,
        ),
      ),
    );
  }

  Widget _buildScrollbar(double tableW, double viewportW) {
    return TableScrollbarWidget(
      controller: _rowsScroll,
      contentW: tableW,
      viewportW: viewportW,
    );
  }

  // ── decoration ────────────────────────────────────────────────────────────────

  static BoxDecoration get _cardDecoration => BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.tableRowDivider),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      );
}
