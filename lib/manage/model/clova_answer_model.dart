import 'dart:convert';

class FinalAnswerDetail {
  final String buysellopinion;
  final String reason;

  FinalAnswerDetail({required this.buysellopinion, required this.reason});

  factory FinalAnswerDetail.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return FinalAnswerDetail(
      buysellopinion: json['buysellopinion'] ?? '',
      reason: json['reason'] ?? '',
    );
  }
}
