import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:barcode_scan/barcode_scan.dart';
void main(){
  runApp(MaterialApp(
    home:HomePage(),
  ));
}
class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "Hey there";
  Future _scanQR() async{
    try{
      String qrRes = (await BarcodeScanner.scan()) as String;
      setState(() {
        result = qrRes;
      });
    }on PlatformException catch(ex){
      if(ex.code==BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera ki permission to de do $ex";
        });
      }
      else if(ex.code==BarcodeScanner.cameraAccessGranted){
        setState(() {
          result = "Camera ki permission dene ke liye dhanyavad 😎 $ex";
        });
      }
      else {
          setState(() {
            result = "Kuch to gadbad hai Daya $ex";
          });
        }
    }on FormatException {
      setState(() {
        result = " You pressed back bina Scan kare ";
      });
    }catch(ex){
      setState(() {
        result = " You pressed back bina Scan kare ";
      });
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:const Text('Qr Scanner'),
      ),
      body: Center(
        child: Text(
          result,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon:const Icon(Icons.camera),
        label: const Text('Scan'),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}