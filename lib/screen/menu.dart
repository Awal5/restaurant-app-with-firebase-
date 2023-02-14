import 'package:flutter/material.dart';
import 'package:uas_rizkiawal_2042019/screen/admin_view.dart';
import 'package:uas_rizkiawal_2042019/screen/cashier_view.dart';

class Menu extends StatefulWidget{
  _MenuState createState() => new _MenuState();
}

class _MenuState extends State<Menu>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(158, 178, 59, 1),
        centerTitle: true,
        title: Text('Login As'),
      ),
      backgroundColor: const Color.fromRGBO(189, 199, 190, 1),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 17, vertical: 8)),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => (MyHomePage(title: "Admin",))));
                }, child: Text("Login As Admin",style: TextStyle(fontSize: 20,color: Colors.white),)),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => (Cashier())));
                }, child: Text("Login As Cashier",style: TextStyle(fontSize: 20,color: Colors.white) ,)),

          ],
        ),
      ),

    );

  }
}