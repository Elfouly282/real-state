class ApiConstants {
  static const String baseUrl = 'https://real.newcinderella.online';
}

class EndPoints {
  static const String apiVersion = '/api/v1';

  // ==========================================
  // Auth (Shared)
  // ==========================================

  static const String register = '$apiVersion/auth/register';
  static const String login = '$apiVersion/auth/login';
  static const String logout = '$apiVersion/auth/logout';

  static const String me = '$apiVersion/auth/me';
  static const String updateProfile = '$apiVersion/auth/profile';
  static const String changePassword = '$apiVersion/auth/password';
  static const String forgotPassword = '$apiVersion/auth/forgot-password';
  static const String resetPassword = '$apiVersion/auth/reset-password';
  static const String deleteAccount = '$apiVersion/auth/account';

  // ==========================================
  // Admin
  // ==========================================

  static const String dashboard = '$apiVersion/admin/dashboard';

  // Categories
  static const String listCategories = '$apiVersion/admin/categories';

  static const String createCategory = '$apiVersion/admin/categories';

  static String getCategory(int id) => '$apiVersion/admin/categories/$id';

  static String updateCategory(int id) => '$apiVersion/admin/categories/$id';

  static String deleteCategory(int id) => '$apiVersion/admin/categories/$id';

  // Properties
  static const String listProperties = '$apiVersion/admin/properties';

  static const String createProperty = '$apiVersion/admin/properties';

  static String getProperty(int id) => '$apiVersion/admin/properties/$id';

  static String updateProperty(int id) => '$apiVersion/admin/properties/$id';

  static String deleteProperty(int id) => '$apiVersion/admin/properties/$id';

  // Agents
  static const String listAgents = '$apiVersion/admin/agents';

  static const String createAgent = '$apiVersion/admin/agents';

  static String getAgent(int id) => '$apiVersion/admin/agents/$id';

  static String updateAgent(int id) => '$apiVersion/admin/agents/$id';

  static String deleteAgent(int id) => '$apiVersion/admin/agents/$id';

  // Users
  static const String listUsers = '$apiVersion/admin/users';

  static String getUser(int id) => '$apiVersion/admin/users/$id';

  static String blockUser(int id) => '$apiVersion/admin/users/$id/block';

  // Orders
  static const String listOrders = '$apiVersion/admin/orders';

  static String getOrder(int id) => '$apiVersion/admin/orders/$id';

  // ==========================================
  // User
  // ==========================================

  // Home
  static const String home = '$apiVersion/home';

  // Properties
  static const String properties = '$apiVersion/properties';

  static String propertyById(int id) => '$apiVersion/properties/$id';

  static String propertyBySlug(String slug) => '$apiVersion/properties/$slug';

  static String similarProperties(int id) =>
      '$apiVersion/properties/$id/similar';

  static const String recommendations = '$apiVersion/me/recommendations';

  // Reviews
  static String propertyReviews(int propertyId) =>
      '$apiVersion/properties/$propertyId/reviews';

  // Favorites
  static const String favorites = '$apiVersion/favorites';

  static String removeFavorite(int propertyId) =>
      '$apiVersion/favorites/$propertyId';

  // Orders
  static const String orders = '$apiVersion/orders';

  // Chat
  static const String conversations = '$apiVersion/conversations';

  static String conversation(int id) => '$apiVersion/conversations/$id';

  static String sendMessage(int conversationId) =>
      '$apiVersion/conversations/$conversationId/messages';
}
