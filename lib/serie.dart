class Serie {
  final String nome;
  final String genero;
  final String descricao;
  final String capa;
  final double pontuacao;
  int vitorias;

  Serie({
    required this.nome,
    required this.genero,
    required this.descricao,
    required this.capa,
    required this.pontuacao,
    this.vitorias = 0,
  });

  factory Serie.fromJson(Map<String, dynamic> json, Map<int, String> genres, int index) {
    String genero = json['gender'] == 1 ? 'Feminino' : 'Masculino';
    String descricao = json['overview'];

    // Gerar nomes de séries de 1 a 9 e de A a D
    String nome = (index < 9) ? 'Série ${index + 1}' : 'Série ${String.fromCharCode(65 + index - 9)}';

    return Serie(
      nome: nome,
      genero: genero,
      descricao: descricao,
      capa: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      pontuacao: json['vote_average'].toDouble(),
    );
  }
}
