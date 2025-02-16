import 'dart:convert';

class Rates {
  num btcrates;
  num ethrates;
  num literates;

  Rates(
      {required this.btcrates,
      required this.ethrates,
      required this.literates});

  factory Rates.fromJson(Map<String, dynamic> json, String currency) {
    print("Json Data : $json");
    print("CUrrency : $currency");
    currency = currency.toLowerCase();

    return Rates(
        btcrates: json['bitcoin']?[currency] ?? 0.0,
        ethrates: json['ethereum']?[currency] ?? 0.0,
        literates: json['litecoin']?[currency] ?? 0.0);
  }
}
