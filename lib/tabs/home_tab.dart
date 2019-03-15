import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:closeup/bloc/filmes_bloc.dart';
import 'package:closeup/database/api.dart';
import 'package:closeup/widgets/banner_filmes.dart';
import 'package:closeup/widgets/categoria_filmes.dart';
import 'package:closeup/widgets/custom_title.dart';
import 'package:closeup/widgets/itens_filme_horizontal.dart';
import 'package:flutter/material.dart';

//Componente de Widget Custom
//banner com poster dos mais emocionantes
//ao clicar abre informações sobre o filme

//Componente de Widget Custom
//lista horizontal com categorias
//ao clicar abre uma lista de filmes daquela categoria

//Componente de Widget Custom
//lista horizontal Mais Votados
//lista horizontal Lançamentos
//lista horizontal Pŕoxima Estreias
//lista horizontal Em Cartaz

class HomeTab extends StatelessWidget {

  static const int MAIS_VOTADOS = 0;
  static const int POPULARES = 1;
  static const int BANNER = 2;
  static const int RECEITA = 3;
  static const int FILMES_GENERO = 4;



  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 0.0, bottom: 10.0, left: 10.0, right: 10.0),
      children: <Widget>[
        BannerFilmes(),

        CustomTitle("Categorias"),
        CategoriaFilmes(),

        CustomTitle("Melhores Avaliados"),
        ItensFilmeHorizontal(
          category: MAIS_VOTADOS,
        ),

        CustomTitle("Populares"),
        ItensFilmeHorizontal(
          category: POPULARES,
        ),

        CustomTitle("Maior receita"),
        ItensFilmeHorizontal(
          category: RECEITA,
        ),
      ],
    );
  }
}
