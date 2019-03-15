import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/bloc/favoritos_bloc.dart';
import 'package:closeup/models/filme.dart';
import 'package:closeup/screens/details_film_screen.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FilmeListTile extends StatelessWidget {
  final Filme filme;

  FilmeListTile(this.filme);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailsFilmScreen(filme)));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ((filme.urlPoster != null)
                ? FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: filme.urlPoster,
                    fit: BoxFit.cover,
                    width: 80,
                    height: 100,
                  )
                : Image.asset("images/film.png", fit: BoxFit.scaleDown, width: 80,height: 100,)),
            SizedBox(
              width: 16.0,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    filme.titulo,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    filme.dataLancamento,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 0,
                child: StreamBuilder<Map<String, Filme>>(
                    initialData: {},
                    stream: BlocProvider.of<FavoritosBloc>(context).outFav,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IconButton(
                          icon: Icon(snapshot.data.containsKey(filme.id)
                              ? Icons.star
                              : Icons.star_border),
                          onPressed: () {
                            BlocProvider.of<FavoritosBloc>(context)
                                .toggleFavorite(filme);
                          },
                        );
                      } else {
                        CircularProgressIndicator();
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
