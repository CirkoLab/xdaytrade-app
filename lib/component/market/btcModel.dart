import 'package:flutter/material.dart';

class btcMarket {
  String icon,name,pairValue,priceValue,priceDollar,percent;
  Color colorChg;
  btcMarket({this.icon,this.name,this.pairValue,this.percent,this.priceDollar,this.priceValue,this.colorChg});
}

List<btcMarket> btcMarketList = [
  btcMarket(
    icon: "assets/image/market/ae.png",
    name: "AE",
    pairValue: "0.5",
    priceValue: "0.0001164",
    priceDollar: "\$0.4632",
    percent: "-0.18%",
    colorChg: Colors.red
  ),
  btcMarket(
    icon: "assets/image/market/aion.png",
    name: "AION",
    pairValue: "0.6",
    priceValue: "0.0000341",
    priceDollar: "\$0.1358",
    percent: "-0.87%",
    colorChg: Colors.red
  ),
  btcMarket(
    icon: "assets/image/market/btc.png",
    name: "BCHSV",
    pairValue: "0.6",
    priceValue: "0.0001645",
    priceDollar: "\$65.5132",
    percent: "-0.18%",
    colorChg: Colors.red
  ),
  btcMarket(
    icon: "assets/image/market/EOS.png",
    name: "EOS",
    pairValue: "0.6",
    priceValue: "0.0001645",
    priceDollar: "\$3.3932",
    percent: "+0.03%",
    colorChg: Color(0xFF00C087)
  ),
  btcMarket(
    icon: "assets/image/market/ETC.png",
    name: "ETC",
    pairValue: "0.8",
    priceValue: "0.0011011",
    priceDollar: "\$4.539122",
    percent: "+3.36%",
    colorChg: Color(0xFF00C087)
  ),
  btcMarket(
    icon: "assets/image/market/eth.png",
    name: "ETH",
    pairValue: "380.8",
    priceValue: "0.0364231",
    priceDollar: "\$137.539122",
    percent: "+1.36%",
    colorChg: Color(0xFF00C087)
  ),
  btcMarket(
    icon: "assets/image/market/NEO.png",
    name: "NEO",
    pairValue: "2.6",
    priceValue: "0.0064231",
    priceDollar: "\$9.129122",
    percent: "+0.36%",
    colorChg: Color(0xFF00C087)
  ),
];