import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/bloc/filmes_bloc.dart';
import 'package:closeup/tile/home_filme_tile.dart';
import 'package:closeup/widgets/wait_load.dart';
import 'package:flutter/material.dart';

class ItensFilmeHorizontal extends StatelessWidget {


  final int category;

  ItensFilmeHorizontal({this.category});

  @override
  Widget build(BuildContext context) {



    return StreamBuilder(
        stream: (BlocProvider.of<FilmesBloc>(context).outFilmes(category)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            List<Widget> childrens = snapshot.data
                .map((filme) {
                  return  HomeFilmeTile(filme);
                })
                .toList()
                .cast<Widget>();

            childrens.add(
              Container(
                width: 160.0,
                child: GestureDetector(
                  child: Card(
                    child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 70.0,
                      ),
                      Text(
                        "Ver mais...",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      )
                    ],

                  ),
                ),
                  onTap: () {
                    BlocProvider.of<FilmesBloc>(context).nextFilmes(category);
                  },
                ),
            ));

            return Container(
              height: 300,
              child:ListView(
                children: childrens /*snapshot.data
                    .map((filme) {
                      return HomeFilmeTile(filme);
                    })
                    .toList()
                    .cast<Widget>()*/,
                padding: EdgeInsets.symmetric(vertical: 4.0),
                scrollDirection: Axis.horizontal,
              ),
            );
          } else {
            BlocProvider.of<FilmesBloc>(context).discover(category);
            return WaitLoad();
          }
        });
  }
}
