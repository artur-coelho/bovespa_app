import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
  "https://api.hgbrasil.com/finance?format=json-cors&key=6dcdc08a";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.blue, primaryColor: Colors.blue),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
            "IBOVESPA",
            style: TextStyle(
                fontSize: 26.0,
                color: Colors.black87,
                fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados...",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                      "Erro ao carregar dados...",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
              } else {

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.account_balance,
                        size: 150.0, color: Colors.blue[600],),
                      TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(fontSize: 18, color: Colors.blue,),
                      ),
                      FlatButton(
                        color: Colors.blue,
                          onPressed: () {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text("valor da ação"
                                        //snapshot.data["results"]["BIDI4"]["price"]
                                            //.toStringAsFixed(2)
                                        ),
                                  );
                                }
                            );
                          },
                          child: Text(
                            "CONSULTAR",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black),
                          )
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }

}


