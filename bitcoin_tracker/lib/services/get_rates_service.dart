import 'dart:convert';

import 'package:bitcoin_tracker/modal_class/modal_rates_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BitcoinRatesService {
  Future<Rates?> fetchRates(String currency) async {
    final url =
        'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,litecoin&vs_currencies=$currency';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> convertedData = jsonDecode(response.body);
        print("\n\n Runtime type of jsonDecode $convertedData\n\n");
        return Rates.fromJson(convertedData, currency);
      }
      throw Exception('Failed to fetch rates');
    } catch (e) {
      print('E: $e');
      // Ensures return
    }
  }
}
