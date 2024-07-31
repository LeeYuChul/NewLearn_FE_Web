class EsgNewsModel {
  final int newsId;
  final String newsTitle;
  final String esgCategory;
  final int esgScore;
  final String companyCode;

  EsgNewsModel.fromJson(Map<String, dynamic> json)
      : newsId = json['기사 ID'] as int,
        newsTitle = json['기사 한글명'] ?? '',
        esgCategory = json['기사 ESG 분야'] ?? '',
        esgScore = json['기사 ESG 점수'] as int,
        companyCode = json['기업 코드'] ?? '';
}
