
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/bloc/filmes_bloc.dart';
import 'package:closeup/models/genero.dart';
import 'package:closeup/tile/filme_list_tile.dart';
import 'package:closeup/widgets/wait_load.dart';
import 'package:flutter/material.dart';

class GeneroListScreen extends StatelessWidget {


  final int category;
  final Genero genero;

  GeneroListScreen({
    @required this.category,
    @required this.genero});

  @override
  Widget build(BuildContext context) {

    Widget _loadMore() {



      return Container(
          margin: EdgeInsets.all(8.0),
          child: FlatButton(onPressed: (){
            BlocProvider.of<FilmesBloc>(context).nextFilmes(category, genero: genero.id);
          }, child: Text("Carregar mais...")));
    }


    BlocProvider.of<FilmesBloc>(context).discoverForGenres(category, genero.id);

    return Scaffold(

      appBar: AppBar(
        title: Text(genero.nome),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: BlocProvider.of<FilmesBloc>(context).outFilmes(category),
        builder: (context, snapshot){

          if(snapshot.hasData){

            List<Widget> childrens= snapshot.data.map((filme){
              return FilmeListTile(filme);
            }).toList().cast<Widget>();

            childrens.add( _loadMore() );

            return ListView(
              children: childrens,
            );

          }else{
            return Center(
              child: WaitLoad(),
            );
          }
        },
      ),
    );
  }

}
