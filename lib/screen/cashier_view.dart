import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_rizkiawal_2042019/screen/orders_view.dart';

class Cashier extends StatefulWidget {
  const Cashier({Key? key}) : super(key: key);

  @override
  State<Cashier> createState() => _CashierState();
}

class _CashierState extends State<Cashier> {

  final CollectionReference _orders = FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Order"),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(158, 178, 59, 1),
      body: StreamBuilder(
        stream: _orders.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            var listAllDocs = streamSnapshot.data!.docs;
            return ListView.builder(
                itemCount: listAllDocs.length,
                itemBuilder: (context, index){
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: Column(

                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) => (Orders())));
                                  },
                                icon: Icon(Icons.person, size: 50,)),
                            SizedBox(width: 8,),
                            // Icon(Icons.person, size: 50,),
                            SizedBox(width: 12,),
                            Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(
                                        "Nama : " + documentSnapshot['nama'], style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 18),),
                                    Text(
                                      "Status Pesanan: " + documentSnapshot['status'],style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 18),),
                                  ],)


                            )
                          ],
                        )
                      ],
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
