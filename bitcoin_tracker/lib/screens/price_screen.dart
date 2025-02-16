import 'dart:convert';
import 'package:bitcoin_tracker/modal_class/modal_rates_data.dart';
import 'package:bitcoin_tracker/services/get_rates_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bitcoin_tracker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  Rates? ratesdata;

  @override
  void initState() {
    super.initState();
    fetchCryptoRates();
  }

  fetchCryptoRates() async {
    setState(() async {
      final fetchedrates =
          await BitcoinRatesService().fetchRates(selectedCurrency);
      if (fetchedrates != null) {
        setState(() {
          ratesdata = fetchedrates;
        });
      }
    });
  }

  DropdownButton<String> buildDropDownItem() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList
          .map((currency) => DropdownMenuItem(
                child: Text(currency),
                value: currency,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
        });
        fetchCryptoRates();
      },
    );
  }

  Widget buildCryptoCard(String crypto, num? rate) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            rate != null
                ? '1 $crypto = $rate $selectedCurrency'
                : "Fetching Data...",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildCryptoCard("BTC", ratesdata?.btcrates),
          // buildCryptoCard("BTC", ratesdata.ethrates),
          // buildCryptoCard("BTC", ratesdata.literates),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? buildDropDownItem() : SizedBox(),
          ),
        ],
      ),
    );
  }
}
