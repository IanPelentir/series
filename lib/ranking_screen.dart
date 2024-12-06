import 'package:flutter/material.dart';
import 'cadastro_serie_screen.dart';
import 'serie.dart';

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ordenar a lista de séries por número de vitórias
    List<Serie> seriesOrdenadas = List.from(series);
    seriesOrdenadas.sort((a, b) => b.vitorias.compareTo(a.vitorias));

    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking de Séries'),
      ),
      body: ListView.builder(
        itemCount: seriesOrdenadas.length,
        itemBuilder: (context, index) {
          Serie serie = seriesOrdenadas[index];
          return ListTile(
            leading: Image.network(serie.capa, width: 50, height: 50),
            title: Text(serie.nome),
            subtitle: Text('Vitórias: ${serie.vitorias}'),
          );
        },
      ),
    );
  }
}
