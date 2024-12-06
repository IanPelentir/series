import 'package:flutter/material.dart';
import 'serie.dart';

class CadastroSerieScreen extends StatefulWidget {
  @override
  _CadastroSerieScreenState createState() => _CadastroSerieScreenState();
}

class _CadastroSerieScreenState extends State<CadastroSerieScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _genero = '';
  String _descricao = '';
  String _capa = '';
  double _pontuacao = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Série'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                onSaved: (value) => _nome = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da série';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gênero'),
                onSaved: (value) => _genero = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o gênero da série';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                onSaved: (value) => _descricao = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição da série';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Capa (URL)'),
                onSaved: (value) => _capa = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a URL da capa da série';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pontuação'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _pontuacao = double.tryParse(value ?? '') ?? 0.0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a pontuação da série';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira uma pontuação válida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Serie novaSerie = Serie(
                      nome: _nome,
                      genero: _genero,
                      descricao: _descricao,
                      capa: _capa,
                      pontuacao: _pontuacao,
                    );
                    adicionarSerie(novaSerie);
                    Navigator.pushNamed(context, '/comparacao');
                  }
                },
                child: Text('Salvar e Comparar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Serie> series = [];

void adicionarSerie(Serie serie) {
  series.add(serie);
  print('Série adicionada: ${serie.nome}');
}
