class AppConstants {
  // API Configuration
  static const String KhamnyBaseUrl = 'https://washing-cars.storage-te.com';

  // Auth Endpoints
  static const String registerEndpoint = '/api/auth/register';
  static const String loginEndpoint = '/api/auth/login';
  static const String sendResetPasswordOtpEndpoint =
      '/api/auth/send-restpassword-otp';
  static const String verifyResetPasswordOtpEndpoint =
      '/api/auth/verify-restpassword-otp';
  static const String changePasswordEndpoint =
      '/api/auth/change-password-with-restpassword-otp';

  // Dynamic Endpoints
  static const String citiesEndpoint = '/api/dynamic/cities';

  // Address Endpoints
  static const String addressesEndpoint = '/api/addresses';
  static String setDefaultAddressEndpoint(int id) =>
      '/api/addresses/$id/set-default';

  // Cars Endpoints
  static const String carsEndpoint = '/api/cars';
  static String setDefaultCarEndpoint(int id) => '/api/cars/$id/set-default';
  static const String brandsEndpoint = '/api/brands';
  static const String carTypesEndpoint = '/api/types';

  // User Endpoints
  static const String resendOtpEndpoint = '/api/user/resend-otp';
  static const String verifyOtpEndpoint = '/api/user/verify-otp';
  static const String refreshTokenEndpoint = '/api/user/refresh';

  static const String arabicLangCode = 'ar';
  static const String englishLangCode = 'en';

  static const String lastAuthProviderCacheKey = 'last_auth_provider';

  // Error Messages
  static const String networkErrorMessage = 'خطأ في الشبكة';
  static const String serverErrorMessage = 'خطأ في الخادم';
  static const String cacheErrorMessage = 'خطأ في التخزين المؤقت';
  static const String unknownErrorMessage = 'خطأ غير معروف';

  // Success Messages
  static const String productAddedToCart = 'تمت إضافة المنتج إلى السلة بنجاح';
  static const String orderPlacedSuccessfully = 'تم تأكيد الطلب بنجاح';
  static const String dataLoadedSuccessfully = 'تم تحميل البيانات بنجاح';
}
