import 'package:dio/dio.dart';

/// Shared response-parsing utilities for all remote datasources.
/// Centralises the three patterns that repeat across every feature:
///   • extractSingle  — unwraps a single-item response
///   • extractList    — unwraps a list response
///   • dioMessage     — extracts a human-readable message from a DioException
abstract final class ResponseParser {
  ResponseParser._();

  /// Unwraps a single object from the server response.
  /// Handles both `List<dynamic>` (array-wrapped) and `Map` (plain object) shapes.
  static Map<String, dynamic> extractSingle(dynamic raw) {
    if (raw is List && raw.isNotEmpty) {
      final first = raw[0] as Map;
      return (first['data'] ?? first) as Map<String, dynamic>;
    }
    if (raw is Map) return (raw['data'] ?? raw) as Map<String, dynamic>;
    return {};
  }

  /// Unwraps a list of objects from the server response.
  static List extractList(dynamic raw) {
    if (raw is List && raw.isNotEmpty) {
      final first = raw[0];
      if (first is Map && first['data'] is List) return first['data'] as List;
      return raw;
    }
    if (raw is Map && raw['data'] is List) return raw['data'] as List;
    return [];
  }

  /// Extracts the most descriptive error message from a [DioException].
  static String dioMessage(DioException e) {
    final d = e.response?.data;
    if (d is List && d.isNotEmpty) {
      return (d[0] as Map)['message'] as String? ?? e.message ?? 'Unknown error';
    }
    if (d is Map) return d['message'] as String? ?? e.message ?? 'Unknown error';
    return e.message ?? 'Unknown error';
  }
}
