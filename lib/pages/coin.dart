import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Coin extends StatefulWidget {
  //const Coin({Key? key}) : super(key: key);

  @override
  _CoinState createState() => _CoinState();
}

class _CoinState extends State<Coin> {
  List<Data> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Coin TOP'),
        centerTitle: true,
      ),
      body:Container(
        child:ListView(
          children: _buildList(),
        ) ,
      ),
        floatingActionButton: FloatingActionButton (
        onPressed: () {
          _loadCoin();
    },
    child: Icon(Icons.refresh),

    ),
    );
  }

  List<Widget> _buildList()  {
    return data.map((Data f) => ListTile(
      title: Text (f.name),
      subtitle: Text(f.symbolCurrency),
      leading: CircleAvatar( child: Text(f.rank.toString())),
      trailing: Text('\$${f.price.toString()}'),
    )).toList();
  }

  Future _loadCoin() async{
    String url = "https://api.coincap.io/v2/assets?limit=10";
    final response = await http.get(Uri.parse(url));

    // if (response.statusCode==200){
    //   print(response.body);
    // }

    var allData = (json.decode(response.body) as Map)['data'];
    var dataList= <Data>[];
    allData.forEach((val){
      var record = Data(
          name: val['name'],
          symbolCurrency: val['symbol'],
          price: double.parse(val['priceUsd']),
          rank: int.parse(val['rank'])
      );
      dataList.add(record);
    });
    setState(() {
      data = dataList;
    });

  }
}
class Data{
  late String name;
  late String symbolCurrency;
  late int rank;
  late double price;

  Data({required this.name,required this.symbolCurrency,required this.rank,required this.price});

}
