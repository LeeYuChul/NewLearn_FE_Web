class StockDataModel {
  final String nowPrice;
  final String previousClosePrice;
  final String openingPrice;
  final String highPrice;
  final String lowPrice;
  final String volume;
  final String tradingVolume;
  final String marketCap;
  final String foreignPossessionRate;
  final String high52Week;
  final String low52Week;
  final String per;
  final String eps;
  final String estimatedPer;
  final String estimatedEps;
  final String pbr;
  final String bps;
  final String dividendYield;
  final String dividendPerShare;

  StockDataModel.fromJson(Map<String, dynamic> json)
      : nowPrice = json['nowPrice'] ?? '',
        previousClosePrice = json['previousClosePrice'] ?? '',
        openingPrice = json['openingPrice'] ?? '',
        highPrice = json['highPrice'] ?? '',
        lowPrice = json['lowPrice'] ?? '',
        volume = json['volume'] ?? '',
        tradingVolume = json['tradingVolume'] ?? '',
        marketCap = json['marketCap'] ?? '',
        foreignPossessionRate = json['foreignPossessionRate'] ?? '',
        high52Week = json['high52Week'] ?? '',
        low52Week = json['low52Week'] ?? '',
        per = json['per'] ?? '',
        eps = json['eps'] ?? '',
        estimatedPer = json['estimatedPer'] ?? '',
        estimatedEps = json['estimatedEps'] ?? '',
        pbr = json['pbr'] ?? '',
        bps = json['bps'] ?? '',
        dividendYield = json['dividendYield'] ?? '',
        dividendPerShare = json['dividendPerShare'] ?? '';
}
