import 'package:flutter/material.dart';
//import 'package:http/http.dart';
class Coin extends StatefulWidget {
  //const Coin({Key? key}) : super(key: key);

  @override
  _CoinState createState() => _CoinState();
}

class _CoinState extends State<Coin> {
  List<Data> data = [
    Data(name: 'Bitcoin', symbolCurrency: 'BTC', rank: 1, price: 32500.0),
    Data(name: 'Ethereum', symbolCurrency: 'ETH', rank: 2, price: 2100.0)
  ];

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

  void _loadCoin() async {

  }
}
class Data{
  late String name;
  late String symbolCurrency;
  late int rank;
  late double price;

  Data({required this.name,required this.symbolCurrency,required this.rank,required this.price});

}
