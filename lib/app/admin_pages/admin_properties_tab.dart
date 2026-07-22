import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/admin_table_card.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_styles.dart';
import '../../features/properties/domain/entities/property_entity.dart';
import '../../features/properties/presentation/cubit/properties_cubit.dart';
import '../../core/utils/status_badge_helper.dart';
import 'admin_empty_view.dart';
import 'admin_error_view.dart';
import 'admin_images_cell.dart';
import 'admin_loading_widget.dart';
import 'admin_table_helpers.dart';
import 'property_details_page.dart';

class AdminPropertiesTab extends StatelessWidget {
  const AdminPropertiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertiesCubit, PropertiesState>(builder: (ctx, state) {
      if (state is PropertiesLoading || state is PropertiesActionLoading) {
        return const AdminLoadingWidget();
      }
      if (state is PropertiesFailure) {
        return AdminErrorView(
            message: state.message, onRetry: () => ctx.read<PropertiesCubit>().load());
      }
      if (state is PropertiesSuccess) {
        if (state.list.isEmpty) return const AdminEmptyView('No properties found');
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Total: ${state.list.length} properties',
                  style: getRegularStyle(
                      fontSize: AppFonts.bodySmall,
                      color: AppColors.textSecondaryColor),
                ),
              ),
              Expanded(
                child: AdminTableCard(
                  minWidth: 900,
                  // ID=1, Title=4, Listing=2, Status=2, Category=2, Images=1, Details=1, Actions=1
                  columnFlexes: const [1, 4, 2, 2, 2, 1, 1, 1],
                  headers: const [
                    'ID', 'Title', 'Listing', 'Status',
                    'Category', 'Images', 'Details', 'Actions'
                  ],
                  rows: state.list
                      .map((p) => DataRow(cells: [
                            DataCell(AdminTableW.cell('${p.id}')),
                            DataCell(AdminTableW.cell(p.title, bold: true)),
                            DataCell(AdminTableW.badge(p.listingType, AppColors.infoColor)),
                            DataCell(_propBadge(p.status)),
                            DataCell(AdminTableW.cell(p.category?.name ?? '-')),
                            DataCell(AdminImagesCell(images: p.images)),
                            DataCell(IconButton(
                              tooltip: 'View Details',
                              icon: const Icon(Icons.info_outline,
                                  size: 20, color: AppColors.primaryColor),
                              onPressed: () => _showDetails(ctx, p),
                            )),
                            DataCell(IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  size: 18, color: AppColors.errorColor),
                              onPressed: () => ctx.read<PropertiesCubit>().delete(p.id),
                            )),
                          ]))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      }
      return const AdminEmptyView('No properties');
    });
  }

  Widget _propBadge(String status) =>
      AdminTableW.badge(status, propertyStatusColor(status));

  void _showDetails(BuildContext context, PropertyEntity p) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PropertyDetailsPage(property: p),
      ),
    );
  }
}
