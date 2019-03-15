
import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/database/api.dart';
import 'package:closeup/models/filme.dart';

class FilmesBloc implements BlocBase{

  Api _api;

  final StreamController<List<Filme>> _bannerController = StreamController<List<Filme>>.broadcast();
  final StreamController<List<Filme>> _maisVotadosController = StreamController<List<Filme>>.broadcast();
  final StreamController<List<Filme>> _popularesController = StreamController<List<Filme>>.broadcast();
  final StreamController<List<Filme>> _receitaController = StreamController<List<Filme>>.broadcast();
  final StreamController<List<Filme>> _generoController = StreamController<List<Filme>>.broadcast();

  final StreamController<List<Filme>> _sugestaoController = StreamController<List<Filme>>.broadcast();
  final StreamController<List<Filme>> _searchController = StreamController<List<Filme>>.broadcast();


  Map<int, dynamic> _controllers = Map<int, dynamic> ();
  Map<int, dynamic> _filmes = Map<int, dynamic>();


  Stream outFilmes(int category)=> _controllers[category].stream;



  FilmesBloc(){
    _api = Api();
    _controllers.addAll({
      0:_bannerController,
      1:_maisVotadosController,
      2:_popularesController,
      3:_receitaController,
      4:_generoController,
      5:_sugestaoController,
      6:_searchController
    });
    _filmes.addAll({
      0:List<Filme>(),
      1:List<Filme>(),
      2:List<Filme>(),
      3:List<Filme>(),
      4:List<Filme>(),
      5:List<String>(),
      6:List<Filme>()
    });


  }

  void discover(int category)async {
    _filmes[category]  = await _api.descobrir(category);
    _controllers[category].sink.add(_filmes[category]);
  }
  void discoverForGenres(int category, int genero) async{
    _filmes[category] = await _api.descobrir(category, genero: genero);
    _controllers[category].sink.add(_filmes[category]);
  }

  @override
  void dispose() {
    _bannerController.close();
    _maisVotadosController.close();
    _popularesController.close();
    _receitaController.close();
    _generoController.close();
    _sugestaoController.close();
    _searchController.close();
  }

  void nextFilmes(int category, {int genero}) async {
    if(genero!=null){
      _filmes[category]  += await _api.descobrir(category,nextPage: true, genero: genero);

    }else{
      _filmes[category]  += await _api.descobrir(category,nextPage: true);
    }
    _controllers[category].sink.add(_filmes[category]);
  }

  void search(int category, String search) async{

    _filmes[category] = await _api.search(category, search);
    _controllers[category].sink.add(_filmes[category]);

  }

  void moreSearch(int category, String search) async{
    _filmes[category] += await _api.search(category, search, nextPage: true);
    _controllers[category].sink.add(_filmes[category]);
  }

}