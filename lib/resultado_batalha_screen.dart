import 'package:flutter/material.dart';
import 'serie.dart';

class ResultadoBatalhaScreen extends StatelessWidget {
  final Serie serie1;
  final Serie serie2;

  ResultadoBatalhaScreen({required this.serie1, required this.serie2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado da Batalha'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Comparando Séries',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Image.network(serie1.capa, height: 150),
                      Text(serie1.nome, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Gênero: ${serie1.genero}'),
                      Text('Descrição: ${serie1.descricao}'),
                      Text('Pontuação: ${serie1.pontuacao.toStringAsFixed(1)}'),
                      Text('Vitórias: ${serie1.vitorias}'),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Image.network(serie2.capa, height: 150),
                      Text(serie2.nome, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Gênero: ${serie2.genero}'),
                      Text('Descrição: ${serie2.descricao}'),
                      Text('Pontuação: ${serie2.pontuacao.toStringAsFixed(1)}'),
                      Text('Vitórias: ${serie2.vitorias}'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _registrarVitoria(serie1, serie2);
                Navigator.pop(context);
              },
              child: Text('Registrar Vitória da Série 1'),
            ),
            ElevatedButton(
              onPressed: () {
                _registrarVitoria(serie2, serie1);
                Navigator.pop(context);
              },
              child: Text('Registrar Vitória da Série 2'),
            ),
          ],
        ),
      ),
    );
  }

  void _registrarVitoria(Serie vencedora, Serie perdedora) {
    vencedora.vitorias++;
    print('Vitória registrada para ${vencedora.nome}');
    print('${vencedora.nome} tem agora ${vencedora.vitorias} vitórias.');
  }
}
