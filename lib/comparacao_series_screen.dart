import 'package:flutter/material.dart';
import 'cadastro_serie_screen.dart';
import 'serie.dart';
import 'resultado_batalha_screen.dart';

class ComparacaoSeriesScreen extends StatefulWidget {
  @override
  _ComparacaoSeriesScreenState createState() => _ComparacaoSeriesScreenState();
}

class _ComparacaoSeriesScreenState extends State<ComparacaoSeriesScreen> {
  Serie? _serie1;
  Serie? _serie2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batalha de Séries'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Selecione duas séries para comparar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<Serie>(
              decoration: InputDecoration(labelText: 'Série 1'),
              items: series.map((serie) {
                return DropdownMenuItem<Serie>(
                  value: serie,
                  child: Text(serie.nome),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _serie1 = value;
                });
              },
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<Serie>(
              decoration: InputDecoration(labelText: 'Série 2'),
              items: series.map((serie) {
                return DropdownMenuItem<Serie>(
                  value: serie,
                  child: Text(serie.nome),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _serie2 = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _serie1 != null && _serie2 != null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultadoBatalhaScreen(
                      serie1: _serie1!,
                      serie2: _serie2!,
                    ),
                  ),
                );
              }
                  : null,
              child: Text('Comparar Séries'),
            ),
          ],
        ),
      ),
    );
  }
}
