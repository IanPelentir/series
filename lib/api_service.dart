import 'dart:convert';
import 'package:http/http.dart' as http;
import 'serie.dart';

class ApiService {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '4262037ac8584fec0a64fdf52e796413';

  Future<Map<int, String>> fetchGenres() async {
    final response = await http.get(Uri.parse('$baseUrl/genre/tv/list?api_key=$apiKey&language=pt-BR'));

    if (response.statusCode == 200) {
      List genresList = json.decode(response.body)['genres'];
      Map<int, String> genres = {};
      for (var genre in genresList) {
        genres[genre['id']] = genre['name'];
      }
      return genres;
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<List<Serie>> fetchSeries(Map<int, String> genres) async {
    final response = await http.get(Uri.parse('$baseUrl/tv/popular?api_key=$apiKey&language=pt-BR'));

    if (response.statusCode == 200) {
      List seriesList = json.decode(response.body)['results'];
      return seriesList.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> data = entry.value;
        return Serie.fromJson(data, genres, index);
      }).toList();
    } else {
      throw Exception('Failed to load series');
    }
  }
}
