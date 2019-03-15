import 'package:closeup/models/filme.dart';
import 'package:closeup/models/genero.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:closeup/api_key.dart';

class Api {
  static const int MAIS_VOTADOS = 0;
  static const int POPULARES = 1;
  static const int BANNER = 2;
  static const int RECEITA = 3;
  static const int FILMES_GENERO = 4;
  static const int SUGESTAO_SEARCH = 5;
  static const int QUERY_SEARCH = 6;

  Map<int, dynamic> pages = {
    MAIS_VOTADOS: 1,
    POPULARES: 1,
    RECEITA: 1,
    FILMES_GENERO: 1,
    SUGESTAO_SEARCH: 1,
    QUERY_SEARCH: 1
  };

  int _nextPage = 1;
  static final Api _instance = Api.internal();

  factory Api() => _instance;
  Api.internal();

  Future<List<Filme>> descobrir(int category,
      {bool nextPage, int genero}) async {
    String categoryQuery;

    switch (category) {
      case MAIS_VOTADOS:
        categoryQuery = "vote_average";
        break;
      case POPULARES:
        categoryQuery = "popularity";
        break;
      case BANNER:
        categoryQuery = "vote_count";
        break;
      case RECEITA:
        categoryQuery = "revenue";
        break;
    }

    if (nextPage != null && nextPage) {
      pages[category] += 1;
    }

    http.Response response = await http.get(
        "https://api.themoviedb.org/3/discover/movie?api_key=$API_KEY&language=en-US${genero != null ? "" : "&sort_by=$categoryQuery.desc"}&include_adult=false&include_video=false&page=${pages[category]}${genero != null ? "&with_genres=$genero" : ""}");
    return decode(response);
  }

  Future<List<Genero>> getGeneros() async {
    http.Response response = await http.get(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=$API_KEY&language=en-US");

    var decoded = json.decode(response.body);

    return decoded["genres"].map<Genero>((map) {
      return Genero.fromJson(map);
    }).toList();
  }

  List<Filme> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<Filme> videos = decoded["results"].map<Filme>((map) {
        return Filme.fromJson(map);
      }).toList();

      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }

  Future<List> search(int category, String search, {bool nextPage}) async {
    int page;
    if (nextPage != null && nextPage) {
      if (category == QUERY_SEARCH) {
        pages[category] += 1;
        page = pages[category];
      } else {
        page = 1;
      }
    }

    http.Response response = await http.get(
        "https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&language=en-US&query=$search&page=$page&include_adult=false");

    if (category == SUGESTAO_SEARCH) {
      return (decode(response)
          .map((f) {
            return f.titulo;
          })
          .toList()
          .cast<String>());
    } else {
      return decode(response);
    }
  }
}
