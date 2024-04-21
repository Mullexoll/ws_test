import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webspark_test/domain/exceptions/api_exceptions.dart';

import '../../domain/models/data.model.dart';

class APIService {
  Future<List<CellData>> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> jsonDataList = jsonDecode(response.body)['data'];

      List<CellData> cellDataList =
          jsonDataList.map((json) => CellData.fromJson(json)).toList();

      return cellDataList;
    } else if (response.statusCode == 500) {
      throw InternalServerErrorException();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<void> postData(
      String endpoint, List<Map<String, dynamic>> data) async {
    final response = await http.post(
      Uri.parse(endpoint),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    switch (response.statusCode) {
      case 500:
        throw InternalServerErrorException();
      case 429:
        throw TooManyRequestException();
      case 400:
        throw BadRequestException();
    }
  }
}
