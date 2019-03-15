
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:closeup/bloc/filmes_bloc.dart';
import 'package:closeup/screens/details_film_screen.dart';
import 'package:closeup/widgets/wait_load.dart';
import 'package:flutter/material.dart';

class BannerFilmes extends StatelessWidget {

  static const int BANNER = 2;

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<FilmesBloc>(context).discover(BANNER);

    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
                  height: 300.0,
                  child: AspectRatio(
                    aspectRatio: 0.5,
                    child: Carousel(
                      images: snapshot.data.map((filme) {
                        return filme.urlBackdrop!=null ? NetworkImage(filme.urlBackdrop):
                        Image.asset("images/film.png");
                      }).toList(),
                      dotSize: 6.0,
                      dotSpacing: 15.0,
                      boxFit: BoxFit.scaleDown,
                      dotBgColor: Colors.transparent,
                      dotColor: Colors.white,
                      autoplay: true,
                      autoplayDuration: Duration(seconds: 15),
                    ),
                  ),

            );
          } else {
            return WaitLoad();
          }
        },
        stream: BlocProvider.of<FilmesBloc>(context).outFilmes(BANNER));
  }
}
