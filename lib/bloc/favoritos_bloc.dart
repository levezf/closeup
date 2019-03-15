import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/models/filme.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosBloc implements BlocBase{

  Map <String, Filme> _favoritos={};

  final _favoritoController = BehaviorSubject<Map <String, Filme>>(seedValue: {});
  Stream<Map<String, Filme>> get outFav => _favoritoController.stream;


  FavoritosBloc(){


    SharedPreferences.getInstance().then((pref){
      if(pref.getKeys().contains("favoritos")){
        _favoritos= json.decode(pref.getString("favoritos")).map((k, v){
           return MapEntry(k, Filme.fromJson(v));
        }).cast<String, Filme>();

        _favoritoController.add(_favoritos);
      }

    });

  }

  void toggleFavorite(Filme filme){
    if(_favoritos.containsKey(filme.id)) _favoritos.remove(filme.id);
    else _favoritos[filme.id] = filme;

    _favoritoController.sink.add(_favoritos);
    _saveFavoritos();
  }


  void _saveFavoritos(){
    SharedPreferences.getInstance().then((pref){
      pref.setString("favoritos", json.encode(_favoritos));
    });
  }

  @override
  void dispose() {
    _favoritoController.close();
  }
}