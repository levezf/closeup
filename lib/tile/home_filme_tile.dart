import 'package:closeup/models/filme.dart';
import 'package:closeup/screens/details_film_screen.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeFilmeTile extends StatelessWidget {
  final Filme filme;

  HomeFilmeTile(this.filme);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsFilmScreen(filme)));
      },
      child: Container(
          width: 160,
          child: Card(
            child: Column(
              children: <Widget>[
                AspectRatio(
                  child: filme.urlPoster!=null?FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image:filme.urlPoster, fit: BoxFit.scaleDown):
                  Image.asset("images/film.png", fit: BoxFit.scaleDown, color: Colors.black,),
                  aspectRatio: 0.7,
                ),

              Expanded(
                child:   Padding(

                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                    child:  Text(
                      filme.titulo,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    )
                ),
              )

              ],
            ),
          )),
    );
  }
}
