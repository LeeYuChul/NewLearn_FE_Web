class FinalAnswerDetail {
  final String buysellopinion;
  final String reason;

  FinalAnswerDetail({required this.buysellopinion, required this.reason});

  factory FinalAnswerDetail.fromJson(Map<String, dynamic> json) {
    return FinalAnswerDetail(
      buysellopinion: json['buysellopinion'] ?? '',
      reason: json['reason'] ?? '',
    );
  }
}
