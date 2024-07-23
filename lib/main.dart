import 'package:flutter/material.dart';
import 'class/pessoa.dart'; 
import 'class/validacoes.dart'; 

void main() {
  runApp(CalculadoraIMCApp());
}

class CalculadoraIMCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculadoraIMCPage(),
    );
  }
}

class CalculadoraIMCPage extends StatefulWidget {
  @override
  _CalculadoraIMCPageState createState() => _CalculadoraIMCPageState();
}

class _CalculadoraIMCPageState extends State<CalculadoraIMCPage> {
  final _nomeController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  String _resultado = '';
  
  void _calcularIMC() {
    final nome = _nomeController.text;
    final peso = double.tryParse(_pesoController.text);
    final altura = double.tryParse(_alturaController.text);

    final nomeErro = validarNome(nome);
    final pesoErro = validarPeso(peso);
    final alturaErro = validarAltura(altura);

    if (nomeErro.isNotEmpty) {
      setState(() {
        _resultado = nomeErro;
      });
      return;      
    } else if (pesoErro.isNotEmpty) {
      setState(() {
        _resultado = pesoErro;
      });
      return;        
    } else if (alturaErro.isNotEmpty) {
      setState(() {
        _resultado = alturaErro;
      });
      return;        
    }        

    final pessoa = Pessoa(nome, peso!, altura!);
    final imc = pessoa.calcularIMC();
    final classificacao = pessoa.classificacaoIMC(imc);

    setState(() {
      _resultado = 'Nome: $nome\nIMC: ${imc.toStringAsFixed(2)}\nClassificação: $classificacao';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _pesoController,
              decoration: InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _alturaController,
              decoration: InputDecoration(labelText: 'Altura (m)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularIMC,
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 20),
            Text(
              _resultado,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}