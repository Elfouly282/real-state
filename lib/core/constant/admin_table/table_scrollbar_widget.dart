import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import 'table_constants.dart';

// ── TableScrollbarWidget ──────────────────────────────────────────────────────

/// A sticky horizontal drag-to-scroll bar pinned at the bottom of the table.
///
/// Always visible when the table content is wider than the viewport.
/// Dragging the thumb scrolls both the header and the data rows in sync
/// via the shared [controller].
class TableScrollbarWidget extends StatefulWidget {
  final ScrollController controller;
  final double contentW;
  final double viewportW;

  const TableScrollbarWidget({
    super.key,
    required this.controller,
    required this.contentW,
    required this.viewportW,
  });

  @override
  State<TableScrollbarWidget> createState() => TableScrollbarWidgetState();
}

// ── TableScrollbarWidgetState ─────────────────────────────────────────────────

class TableScrollbarWidgetState extends State<TableScrollbarWidget> {
  double _thumbLeft = 0;

  // ── thumb metrics ────────────────────────────────────────────────────────────

  double get _thumbWidth {
    final ratio = widget.viewportW / widget.contentW;
    return (ratio * widget.viewportW).clamp(40.0, widget.viewportW);
  }

  double get _maxThumbLeft => (widget.viewportW - _thumbWidth).clamp(0.0, double.infinity);

  // ── lifecycle ────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  // ── scroll sync ──────────────────────────────────────────────────────────────

  void _onScroll() {
    if (!mounted) return;
    final maxScroll =
        (widget.contentW - widget.viewportW).clamp(1.0, double.infinity);
    setState(() {
      _thumbLeft =
          (widget.controller.offset / maxScroll).clamp(0.0, 1.0) * _maxThumbLeft;
    });
  }

  // ── drag handler ─────────────────────────────────────────────────────────────

  void _onDrag(DragUpdateDetails details) {
    final maxScroll  = widget.contentW - widget.viewportW;
    final thumbTrack = widget.viewportW - _thumbWidth;
    if (thumbTrack <= 0) return;

    final newOffset = widget.controller.offset +
        details.delta.dx / thumbTrack * maxScroll;
    widget.controller.jumpTo(newOffset.clamp(0.0, maxScroll));
  }

  // ── build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragUpdate: _onDrag,
      child: Container(
        height: kScrollbarH,
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Stack(
          children: [
            _buildTrack(),
            _buildThumb(),
          ],
        ),
      ),
    );
  }

  // ── track & thumb ─────────────────────────────────────────────────────────────

  Widget _buildTrack() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.tableRowDivider,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildThumb() {
    return Positioned(
      left: _thumbLeft,
      top: 0,
      bottom: 0,
      width: _thumbWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
