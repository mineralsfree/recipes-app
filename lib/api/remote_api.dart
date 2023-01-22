import 'dart:convert';
import 'dart:io';

import 'package:front/model/Recipe.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// ignore: avoid_classes_with_only_static_members
class RemoteApi {
  static Future<List<Recipe>> getRecipesRecommendation(String? jwt,
      int offset,
      int limit, {
        String? searchTerm,
      }) async =>
      http
          .get(
        _ApiUrlBuilder.characterList(offset, limit, searchTerm: searchTerm),
        headers: {"Authorization": 'Bearer $jwt'}
      )
          .mapFromResponse<List<Recipe>, List<dynamic>>(
            (jsonArray) => _parseItemListFromJsonArray(
          jsonArray,
              (jsonObject) => Recipe.fromJson(jsonObject),
        ),
      );

  static List<T> _parseItemListFromJsonArray<T>(
      List<dynamic> jsonArray,
      T Function(dynamic object) mapper,
      ) =>
      jsonArray.map(mapper).toList();
}

class GenericHttpException implements Exception {}
class UnauthorizedException implements Exception {}
class NoConnectionException implements Exception {}

// ignore: avoid_classes_with_only_static_members
class _ApiUrlBuilder {
  static const _baseUrl = 'http://localhost:5000';
  static const _charactersResource = '/api/recipes/recommend';

  static Uri characterList(
      int offset,
      int limit, {
        String? searchTerm,
      }) =>
      Uri.parse(
        '$_baseUrl$_charactersResource?'
            'page=$offset'
            '&size=$limit'
            '${_buildSearchTermQuery(searchTerm)}',
      );

  static String _buildSearchTermQuery(String? searchTerm) =>
      searchTerm != null && searchTerm.isNotEmpty
          ? '&name=${searchTerm.replaceAll(' ', '+').toLowerCase()}'
          : '';
}

extension on Future<http.Response> {
  Future<R> mapFromResponse<R, T>(R Function(T) jsonParser) async {
    try {
      final response = await this;
      if (response.statusCode == 200) {
        return jsonParser(jsonDecode(response.body));
      }
      if (response.statusCode == 401){
        throw UnauthorizedException();
      }
      else {
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
  }
}