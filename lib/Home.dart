import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();
  String _resultado = "Resultado";
  _recuperaCep() async {
    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json/";
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];
    String ddd = retorno["ddd"];

    setState(() {
      if (complemento == "") {
        _resultado =
            "Logradouro: ${logradouro}\nBairro: ${bairro}\nLocalidade: ${localidade}\nUF: ${uf}\nDDD: ${ddd}";
      } else {
        _resultado =
            "Logradouro: ${logradouro}\nComplemento: ${complemento}\nBairro: ${bairro}\nLocalidade: ${localidade}\nUF: ${uf}\nDDD: ${ddd}";
      }
    });

    //print("resposta:" + response.statusCode.toString());
    //print("resposta:" + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Busque Cep"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: "Digite o cep: ex:05428200"),
                style: TextStyle(fontSize: 25),
                controller: _controllerCep,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Buscar",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: _recuperaCep),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                _resultado,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
