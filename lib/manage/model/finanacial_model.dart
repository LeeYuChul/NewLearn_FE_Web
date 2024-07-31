class FinancialDataModel {
  final String name;
  final Map<String, double> periodData;

  FinancialDataModel.fromJson(Map<String, dynamic> json)
      : name = json['Name'] as String,
        periodData = (json['periodData'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value?.toDouble() ?? 0.0));
}
