import 'package:flutter/material.dart';
import 'cadastro_serie_screen.dart';
import 'comparacao_series_screen.dart';
import 'ranking_screen.dart';
import 'api_service.dart';
import 'serie.dart';
import 'pdf_generator.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batalha de Séries',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/cadastro': (context) => CadastroSerieScreen(),
        '/comparacao': (context) => ComparacaoSeriesScreen(),
        '/ranking': (context) => RankingScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Serie> series = [];

  @override
  void initState() {
    super.initState();
    _fetchSeriesAndGenres();
  }

  Future<void> _fetchSeriesAndGenres() async {
    try {
      Map<int, String> genres = await apiService.fetchGenres();
      List<Serie> fetchedSeries = await apiService.fetchSeries(genres);
      setState(() {
        series = fetchedSeries;
      });
      print('Séries carregadas: ${series.length}');
    } catch (e) {
      print('Failed to load series or genres: $e');
    }
  }

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
              'Bem-vindo à Batalha de Séries!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cadastro');
                  },
                  icon: Icon(Icons.add),
                  label: Text('Cadastrar Série'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/comparacao');
                  },
                  icon: Icon(Icons.compare),
                  label: Text('Comparar Séries'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ranking');
                  },
                  icon: Icon(Icons.leaderboard),
                  label: Text('Ranking'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    PdfGenerator.generatePdf(series);
                  },
                  icon: Icon(Icons.picture_as_pdf),
                  label: Text('Gerar Relatório'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: series.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: series.length,
                itemBuilder: (context, index) {
                  Serie serie = series[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(serie.capa, width: 50, height: 50),
                      title: Text(serie.nome),
                      subtitle: Text('Gênero: ${serie.genero}\nDescrição: ${serie.descricao}\nPontuação: ${serie.pontuacao}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
