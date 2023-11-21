// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tfgirdi = TextEditingController();

  Future<void> veriYaz() async {
    var ad = await getApplicationDocumentsDirectory();
    var dosyalamaYolu = await ad.path;
    var dosya = File("$dosyalamaYolu/dosya.txt");
    dosya.writeAsString(tfgirdi.text);
    tfgirdi.text = "";
  }

  Future<void> veriOku() async {
    try {
      var ad = await getApplicationDocumentsDirectory();
      var dosyalamaYolu = await ad.path;
      var dosya = File("$dosyalamaYolu/dosya.txt");
      String okunanVeri = await dosya.readAsString();
      tfgirdi.text = okunanVeri;
    } catch (e) {
      e.toString();
    }
  }

  Future<void> veriSil() async {
    var ad = await getApplicationDocumentsDirectory();
    var dosyalamaYolu = await ad.path;
    var dosya = File("$dosyalamaYolu/dosya.txt");
    if (dosya.existsSync()) {
      dosya.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dosya Oluşturma Ekranı"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[300],
              border: Border.all(color: Colors.blue),
            ),
            width: 500,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                      controller: tfgirdi,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: 'Dosya Adı Gir',
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              veriYaz();
                            },
                            child: const Text("Yaz")),
                        ElevatedButton(
                            onPressed: () {
                              veriOku();
                            },
                            child: const Text("Oku")),
                        ElevatedButton(
                            onPressed: () {
                              veriSil();
                            },
                            child: const Text("Sil")),
                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
