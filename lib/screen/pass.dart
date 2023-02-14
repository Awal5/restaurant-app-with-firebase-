import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';


class Pass extends StatefulWidget{

  @override
  Passing createState() =>  Passing();

}

class Passing extends State<Pass>{

  final CollectionReference _food = FirebaseFirestore.instance.collection('food');

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  String dropdownValue = 'Status';

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async{
    if(documentSnapshot != null){
      _namaController.text = documentSnapshot['nama'];
      _hargaController.text = documentSnapshot['harga'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx){
          return Padding(padding: EdgeInsets.only(
              top: 20, left: 20, right: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _namaController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                  ),
                  TextField(
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    controller: _hargaController,
                    decoration: const InputDecoration(labelText: 'Harga'),
                  ),
                  SizedBox(height: 10),
                  DropdownSearch<String>(
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                        hintText: "Status",
                      )),
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                  ),
                  items: ['Tersedia', 'Tidak Tersedia'],
                  onChanged: print,
                ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String nama = _namaController.text;
                      final double? harga = double.tryParse(_hargaController.text);
                      if(harga != null){
                        await _food
                            .doc(documentSnapshot!.id)
                            .update({"nama": nama, "harga": harga});
                        _namaController.text = '';
                        _hargaController.text = '';
                      }
                    },
                  )
                ],
              ));
        });
  }
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async{
    if(documentSnapshot != null){
      _namaController.text = documentSnapshot['nama'];
      _hargaController.text = documentSnapshot['harga'].toString();
    }
    await showModalBottomSheet(

        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx){
          return Padding(padding: EdgeInsets.only(
              top: 20, left: 20, right: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _namaController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                  ),
                  TextField(
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    controller: _hargaController,
                    decoration: const InputDecoration(labelText: 'Harga'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text('Tambah'),
                    onPressed: () async {
                      final String nama = _namaController.text;
                      final double? harga = double.tryParse(_hargaController.text);
                      if(harga != null){
                        await _food
                            .add({"nama": nama, "harga": harga});
                        _namaController.text = '';
                        _hargaController.text = '';
                      }
                    },
                  )
                ],
              ));
        });

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Berhasil Menambahkan Data")));
  }
  Future<void> _delete(String productId) async{
    await _food.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('berhasil menghapus Data')));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Data"),
        centerTitle: true,

      ),
      backgroundColor: const Color.fromRGBO(158, 178, 59, 1),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.white,
        onPressed: () => _create(),
        child: const Icon(Icons.add,),
      ),
      body: StreamBuilder(
        stream: _food.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            var listAllDocs = streamSnapshot.data!.docs;
            return ListView.builder(
                itemCount: listAllDocs.length,
                itemBuilder: (context, index){
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Icon(Icons.fastfood_rounded, color: Colors.black),
                      title: Text(documentSnapshot['nama'], style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(documentSnapshot['harga'].toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                onPressed: ()=>
                                    _update(documentSnapshot),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red,),
                                onPressed: ()=>
                                    _delete(documentSnapshot.id),
                              ),
                            ]),
                      ),
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