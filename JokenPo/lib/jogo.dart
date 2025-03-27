import 'package:flutter/material.dart';
import 'dart:math';

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage("images/padrao.png");
  var _resultadoFinal = "Boa Sorte!!!";
  int _pontosUsuario = 0;
  int _pontosApp = 0;

  void _opcaoSelecionada(String escolhaUsuario) {
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];

    setState(() {
      _imagemApp = AssetImage("images/$escolhaApp.png");
    });

    if ((escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")) {
      setState(() {
        _resultadoFinal = "Parabéns!!! Você ganhou!!!";
        _pontosUsuario++;
      });
    } else if (escolhaUsuario == escolhaApp) {
      setState(() {
        _resultadoFinal = "Empate! Jogue novamente.";
      });
    } else {
      setState(() {
        _resultadoFinal = "Você perdeu! Tente novamente.";
        _pontosApp++;
      });
    }
  }

  Color _getResultadoColor() {
    if (_resultadoFinal.contains("ganhou")) {
      return Colors.blue;
    } else if (_resultadoFinal.contains("perdeu")) {
      return Colors.red;
    }
    return Colors.amber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('JokenPo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Image(image: _imagemApp, height: 100),
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha uma opção abaixo:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _opcaoWidget("papel", "Papel"),
              _opcaoWidget("pedra", "Pedra"),
              _opcaoWidget("tesoura", "Tesoura"),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              _resultadoFinal,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _getResultadoColor()),
            ),
          ),
          Text(
            "Placar: Você $_pontosUsuario - $_pontosApp App",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _opcaoWidget(String opcao, String nome) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _opcaoSelecionada(opcao),
          child: Image(image: AssetImage("images/$opcao.png"), height: 100),
        ),
        SizedBox(height: 8),
        Text(
          nome,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
