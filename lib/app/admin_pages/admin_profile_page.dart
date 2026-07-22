import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_styles.dart';
import '../../features/auth/domain/entities/auth_entity.dart';
import 'widgets/property_detail_helpers.dart';

class AdminProfilePage extends StatelessWidget {
  final AuthEntity admin;

  const AdminProfilePage({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Admin Profile',
          style: getBoldStyle(
            fontSize: AppFonts.titleMedium,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            // Avatar
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  admin.name.isNotEmpty
                      ? admin.name[0].toUpperCase()
                      : 'A',
                  style: getBoldStyle(
                    fontSize: AppFonts.headlineSmall,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              admin.name,
              style: getBoldStyle(
                fontSize: AppFonts.titleLarge,
                color: AppColors.secondaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.30)),
              ),
              child: Text(
                admin.role.toUpperCase(),
                style: getMediumStyle(
                  fontSize: AppFonts.labelSmall,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Info card
            PropertyDetailCard(
              child: Column(
                children: [
                  PropertyInfoRow(
                    icon: Icons.person_outline,
                    label: 'Name',
                    value: admin.name,
                  ),
                  const Divider(height: 20),
                  PropertyInfoRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: admin.email,
                  ),
                  const Divider(height: 20),
                  PropertyInfoRow(
                    icon: Icons.verified_user_outlined,
                    label: 'Role',
                    value: admin.role,
                  ),
                  const Divider(height: 20),
                  PropertyInfoRow(
                    icon: Icons.badge_outlined,
                    label: 'ID',
                    value: '${admin.id}',
                  ),
                  const Divider(height: 20),
                  PropertyInfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Member Since',
                    value: admin.createdAt.length > 10
                        ? admin.createdAt.substring(0, 10)
                        : admin.createdAt,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
