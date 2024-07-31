// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newlearn_fe_web/manage/model/clova_answer_model.dart';

class ClovaApiManage {
  static const String apiUrl = 'http://3.37.85.254:5003/clova_chat';

  static Future<FinalAnswerDetail> fetchFinalAnswer({
    required String companyName,
    required String stockCode,
    required String period,
  }) async {
    final url = Uri.parse(apiUrl);
    final body = jsonEncode({
      'query':
          '$stockCode, $companyName의 실시간 주가와 ESG 데이터 그리고 재무제표 데이터의 $period년치를 보고 ESG와 가치통합 평가를 하여 주식 매수 BUY,HOLD 의견을 줘.'
    });

    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // 응답 본문을 UTF-8로 디코딩
      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return FinalAnswerDetail.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to fetch final answer: ${response.statusCode}');
    }
  }
}
