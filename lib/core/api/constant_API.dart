class ApiConstants {
  static const String baseUrl = 'https://real.newcinderella.online/';
}

class EndPoints {
  static const String baseUrl = '/api/v1';

  // Auth
  static const String login = '$baseUrl/auth/login';
  static const String logout = '$baseUrl/auth/logout';

  // Dashboard
  static const String dashboard = '$baseUrl/admin/dashboard';

  // Categories
  static const String listCategories = '$baseUrl/admin/categories';
  static const String createCategory = '$baseUrl/admin/categories';

  static String getCategory(int id) => '$baseUrl/admin/categories/$id';
  static String updateCategory(int id) => '$baseUrl/admin/categories/$id';
  static String deleteCategory(int id) => '$baseUrl/admin/categories/$id';

  // Properties
  static const String listProperties = '$baseUrl/admin/properties';
  static const String createProperty = '$baseUrl/admin/properties';

  static String getProperty(int id) => '$baseUrl/admin/properties/$id';
  static String updateProperty(int id) => '$baseUrl/admin/properties/$id';
  static String deleteProperty(int id) => '$baseUrl/admin/properties/$id';

  // Agents
  static const String listAgents = '$baseUrl/admin/agents';
  static const String createAgent = '$baseUrl/admin/agents';

  static String getAgent(int id) => '$baseUrl/admin/agents/$id';
  static String updateAgent(int id) => '$baseUrl/admin/agents/$id';
  static String deleteAgent(int id) => '$baseUrl/admin/agents/$id';

  // Users
  static const String listUsers = '$baseUrl/admin/users';

  static String getUser(int id) => '$baseUrl/admin/users/$id';
  static String blockUser(int id) => '$baseUrl/admin/users/$id/block';

  // Orders
  static const String listOrders = '$baseUrl/admin/orders';

  static String getOrder(int id) => '$baseUrl/admin/orders/$id';
}
