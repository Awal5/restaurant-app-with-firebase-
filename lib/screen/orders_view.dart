import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Map<String, dynamic>> orderList = [
    {
      "makanan": "Burger",
      "jumlah": 2,
      "harga": 45000
    },
    {
      "makanan": "Mie",
      "jumlah": 1,
      "harga": 8000
    },
    {
      "makanan": "Burger",
      "jumlah": 3,
      "harga": 60000
    },
    {
      "makanan": "Ayam Goreng",
      "jumlah": 4,
      "harga": 90000
    },
    {
      "makanan": "Bakmie",
      "jumlah": 3,
      "harga": 8000
    },
    {
      "makanan": "Burger",
      "jumlah": 3,
      "harga": 20000
    },

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Customer Orders"),

          actions: [
            Padding(
                padding: EdgeInsets.only(top: 20, right: 15),
                child: Container(
                  child: Text(
                    "Pembelian : 16", style: TextStyle(fontWeight: FontWeight.w700),),
                ),)
          ],
        ),
      body: ListView(
        children: orderList.map((data){
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text("Makanan : ${data["makanan"]}"),
              subtitle: Text("Jumlah : ${data["jumlah"]}"),
              trailing: Text("Harga : ${data["harga"]}"),
            ),
          );
        }).toList(),
      ),


    );
  }
}


