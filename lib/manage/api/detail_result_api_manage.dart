// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newlearn_fe_web/manage/model/esg_result_model.dart';
import 'package:newlearn_fe_web/manage/model/finanacial_model.dart';
import 'package:newlearn_fe_web/manage/model/realtime_stock_model.dart';

class DetailResultApiManage {
  static String baseUrl = 'http://3.37.85.254:5001';
  static String esgBaseUrl = 'http://3.37.85.254:5002';
  static String stockBaseUrl = 'http://15.165.27.24';

  // 재무제표 데이터를 가져오는 API
  static Future<List<FinancialDataModel>> fetchFinancialData(
      String companyStockCode, int period) async {
    final url = Uri.parse('$baseUrl/financial_statements');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'company_stock_code': companyStockCode,
      'period': period,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      final List<dynamic> jsonResponse = jsonDecode(responseBody);
      return jsonResponse
          .map((json) => FinancialDataModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load financial data: ${response.statusCode}');
    }
  }

  // ESG 뉴스 결과를 가져오는 API
  static Future<List<EsgNewsModel>> fetchEsgNewsResults(
      String companyStockCode) async {
    final url = Uri.parse('$esgBaseUrl/esg_results');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'company_stock_code': companyStockCode,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      final List<dynamic> jsonResponse = jsonDecode(responseBody);
      return jsonResponse.map((json) => EsgNewsModel.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load ESG news results: ${response.statusCode}');
    }
  }

  // 주식 데이터를 가져오는 API
  static Future<StockDataModel> fetchStockData(String companyStockCode) async {
    final url = Uri.parse('$stockBaseUrl/stock/$companyStockCode');
    final headers = {'Content-Type': 'application/json'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
      return StockDataModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Failed to load stock data: ${response.statusCode}');
    }
  }
}
