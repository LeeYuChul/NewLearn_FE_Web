// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newlearn_fe_web/manage/model/clova_answer_model.dart';

class ClovaApiManage {
  static const String apiUrl =
      'https://clovastudio.stream.ntruss.com/testapp/v1/skillsets/pxzpzfac/versions/11/final-answer';
  static const String apiKey =
      'NTA0MjU2MWZlZTcxNDJiYx5nJ9z87DKxlyRynnpD92tzfGHkZUwGbaaySiF5jj/d';
  static const String apiGwKey = 'EJWfdqk0rE2FRZtyWjwqUSBXdXZfZjBpMS0EUACu';
  static const String requestId = '42754569-0553-4628-880e-3d5a789ee03c';

  static Future<FinalAnswerDetail> fetchFinalAnswer({
    required String companyName,
    required String stockCode,
    required String period,
  }) async {
    final url = Uri.parse(apiUrl);
    final headers = {
      'X-NCP-CLOVASTUDIO-API-KEY': apiKey,
      'X-NCP-APIGW-API-KEY': apiGwKey,
      'X-NCP-CLOVASTUDIO-REQUEST-ID': requestId,
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
      "Access-Control-Allow-Headers":
          "Origin, X-Requested-With, Content-Type, Accept",
      'Accept': 'application/json', // 추가된 헤더
      'Cache-Control': 'no-cache', // 추가된 헤더
    };
    final body = jsonEncode({
      'query':
          '$stockCode, $companyName의 실시간 주가(PBR,PER 등), ESG 데이터, 재무제표 3년치 데이터를 보고 ESG와 가치투자를 종합적으로 판단하여 가치 통합 평가를 하여 주식 매수의견을 주세요',
      'tokenStream': false,
    });
    print('클로바 요청됨 : $body');

    final response = await http.post(url, headers: headers, body: body);
    print(response);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final String finalAnswerString = jsonResponse['result']['finalAnswer'];
      return FinalAnswerDetail.fromJson(finalAnswerString);
    } else {
      throw Exception('Failed to fetch final answer: ${response.statusCode}');
    }
  }
}
