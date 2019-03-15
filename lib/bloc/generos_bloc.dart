
import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/database/api.dart';
import 'package:closeup/models/filme.dart';
import 'package:closeup/models/genero.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:closeup/api_key.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class GenerosBloc extends BlocBase {


  List<Genero> generos;
  Api api;


  final StreamController<List<Genero>> _generoController = StreamController<List<Genero>>.broadcast();
  Stream get outGeneros => _generoController.stream;
  GenerosBloc(){
    api = Api();

  }
  void getGeneros()async {
    generos  = await api.getGeneros();
    _generoController.sink.add(generos);
  }

  @override
  void dispose() {
    _generoController.close();
  }


}
