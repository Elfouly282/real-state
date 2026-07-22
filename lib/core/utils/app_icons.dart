import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class AppIcons {
  AppIcons._();

  static const IconData dashboard     = Icons.dashboard_outlined;
  static const IconData categories    = Icons.category_outlined;
  static const IconData properties    = Icons.home_work_outlined;
  static const IconData agents        = Icons.support_agent_outlined;
  static const IconData users         = Icons.people_outline;
  static const IconData orders        = Icons.receipt_long_outlined;
  static const IconData logout        = Icons.logout_outlined;
  static const IconData menu          = Icons.menu_rounded;

  static const IconData add           = Icons.add_rounded;
  static const IconData edit          = Icons.edit_outlined;
  static const IconData delete        = Icons.delete_outline;
  static const IconData details       = Icons.info_outline;
  static const IconData refresh       = Icons.refresh_rounded;
  static const IconData close         = Icons.close_rounded;
  static const IconData save          = Icons.save_outlined;
  static const IconData search        = Icons.search_rounded;
  static const IconData filter        = Icons.filter_list_rounded;
  static const IconData back          = Icons.arrow_back_rounded;
  static const IconData send          = Icons.send_rounded;

  static const IconData email         = Icons.email_outlined;
  static const IconData password      = Icons.lock_outline;
  static const IconData passwordShow  = Icons.visibility_outlined;
  static const IconData passwordHide  = Icons.visibility_off_outlined;
  static const IconData person        = Icons.person_outline;
  static const IconData phone         = Icons.phone_outlined;

  static const IconData property      = Icons.home_work_outlined;
  static const IconData bedroom       = Icons.bed_outlined;
  static const IconData bathroom      = Icons.bathtub_outlined;
  static const IconData kitchen       = Icons.kitchen_outlined;
  static const IconData location      = Icons.location_on_outlined;
  static const IconData address       = Icons.location_city_outlined;
  static const IconData coordinates   = Icons.my_location_outlined;
  static const IconData price         = Icons.attach_money_outlined;
  static const IconData listingType   = Icons.swap_horiz_outlined;
  static const IconData salesCount    = Icons.trending_up_outlined;
  static const IconData featured      = Icons.star_rounded;
  static const IconData notFeatured   = Icons.star_border_rounded;
  static const IconData images        = Icons.photo_library_outlined;
  static const IconData noImage       = Icons.hide_image_outlined;
  static const IconData description   = Icons.notes_outlined;

  static const IconData usersCount    = Icons.people_outline;
  static const IconData revenue       = Icons.attach_money_outlined;
  static const IconData pending       = Icons.pending_actions_outlined;

  static const IconData online        = Icons.circle;
  static const IconData block         = Icons.block_outlined;
  static const IconData unblock       = Icons.lock_open_outlined;
  static const IconData verified      = Icons.verified_outlined;
  static const IconData tag           = Icons.tag_outlined;

  static const IconData notification  = Icons.notifications_outlined;
  static const IconData notifBadge    = Icons.circle;

  static const IconData prevArrow     = Icons.chevron_left_rounded;
  static const IconData nextArrow     = Icons.chevron_right_rounded;
  static const IconData dropDown      = Icons.keyboard_arrow_down_rounded;

  static const IconData agentBio      = Icons.info_outline;
  static const IconData company       = Icons.business_outlined;
  static const IconData license       = Icons.badge_outlined;

  static const IconData categoryItem  = Icons.category_outlined;
  static const IconData slug          = Icons.tag_outlined;

  static const IconData order         = Icons.receipt_long_outlined;
  static const IconData orderPaid     = Icons.check_circle_outline;
  static const IconData orderPending  = Icons.hourglass_empty_rounded;
  static const IconData orderCancel   = Icons.cancel_outlined;

  static const String homeSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
    d="M9 22V12h6v10M2 9.5L12 2l10 7.5V21a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1z"/>
</svg>''';

  static const String buildingSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
    d="M3 21h18M4 21V7l8-4v18M20 21V11l-8-4M9 9v.01M9 12v.01M9 15v.01M9 18v.01"/>
</svg>''';

  static const String dashboardSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
    d="M3 3h7v7H3zm11 0h7v7h-7zM3 14h7v7H3zm11 3a4 4 0 1 0 8 0a4 4 0 0 0-8 0"/>
</svg>''';

  static const String agentSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
    d="M12 2a5 5 0 1 0 0 10A5 5 0 0 0 12 2zm0 12c-5.33 0-8 2.67-8 4v2h16v-2c0-1.33-2.67-4-8-4z"/>
</svg>''';

  static const String usersSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
    d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2m8-10a4 4 0 1 0 0-8a4 4 0 0 0 0 8m10 10v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/>
</svg>''';

  static const String orderSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
    d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8zm4 0v6h-6M16 13H8m8 4H8m2-8H8"/>
</svg>''';

  static const String categorySvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
    d="M10 3H3v7h7zm11 0h-7v7h7zM10 14H3v7h7zm11 0h-7v7h7z"/>
</svg>''';

  static const String locationSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
    d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7m0 9.5a2.5 2.5 0 0 1 0-5a2.5 2.5 0 0 1 0 5"/>
</svg>''';

  static const String keysSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
    d="M21 2l-2 2m-7.61 7.61a5.5 5.5 0 1 1-7.778 7.778a5.5 5.5 0 0 1 7.777-7.777zm0 0L15.5 7.5m0 0l3 3L22 7l-3-3m-3.5 3.5L19 4"/>
</svg>''';

  static const String revenueSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
    d="M12 1v22M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
</svg>''';

  static const String notificationSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
    d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9m-4.27 13a2 2 0 0 1-3.46 0"/>
</svg>''';

  static const String logoutSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
    d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4m7 14l5-5l-5-5m5 5H9"/>
</svg>''';
}

class AppIconify extends StatelessWidget {
  final String svg;
  final double size;
  final Color? color;

  const AppIconify({
    super.key,
    required this.svg,
    this.size = 24,
    this.color,
  });

  factory AppIconify.home({double size = 24, Color? color}) =>
      AppIconify(svg: AppIcons.homeSvg, size: size, color: color);

  factory AppIconify.building({double size = 24, Color? color}) =>
      AppIconify(svg: AppIcons.buildingSvg, size: size, color: color);

  factory AppIconify.dashboard({double size = 24, Color? color}) =>
      AppIconify(svg: AppIcons.dashboardSvg, size: size, color: color);

  factory AppIconify.agent({double size = 24, Color? color}) =>
      AppIconify(svg: AppIcons.agentSvg, size: size, color: color);

  factory AppIconify.users({double size = 24, Color? color}) =>
      AppIconify(svg: AppIcons.usersSvg, size: size, color: color);

  factory AppIconify.order({double size = 24, Color? color}) =>
      AppIconify(svg: AppIcons.orderSvg, size: size, color: color);

  factory AppIconify.category({double size = 24, Color? color}) =>
      AppIconify(svg: AppIcons.categorySvg, size: size, color: color);

  factory AppIconify.location({double size = 24, Color? color}) =>
      AppIconify(svg: AppIcons.locationSvg, size: size, color: color);

  factory AppIconify.keys({double size = 24, Color? color}) =>
      AppIconify(svg: AppIcons.keysSvg, size: size, color: color);

  factory AppIconify.revenue({double size = 24, Color? color}) =>
      AppIconify(svg: AppIcons.revenueSvg, size: size, color: color);

  factory AppIconify.notification({double size = 24, Color? color}) =>
      AppIconify(svg: AppIcons.notificationSvg, size: size, color: color);

  factory AppIconify.logout({double size = 24, Color? color}) =>
      AppIconify(svg: AppIcons.logoutSvg, size: size, color: color);

  @override
  Widget build(BuildContext context) {
    return Iconify(
      svg,
      size: size,
      color: color,
    );
  }
}
