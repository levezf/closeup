import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/bloc/favoritos_bloc.dart';
import 'package:closeup/models/filme.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailsFilmScreen extends StatelessWidget {
  final Filme filme;

  DetailsFilmScreen(this.filme);

  @override
  Widget build(BuildContext context) {
    Widget _buildLine(
        String title, String result, bool linhaMaisClara) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Text(title),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Text(
                result,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
        color: (linhaMaisClara) ? Colors.black12 : Colors.black26,
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(filme.titulo),

        actions: <Widget>[

          StreamBuilder<Map<String, Filme>>(
              stream:BlocProvider.of<FavoritosBloc>(context).outFav,
              builder: (context, snapshot){

                if(snapshot.hasData){
                  return  IconButton(
                    icon: Icon(snapshot.data.containsKey(filme.id)?
                    Icons.star : Icons.star_border),
                    onPressed: () {
                      BlocProvider.of<FavoritosBloc>(context).toggleFavorite(filme);
                    },
                  );
                }else{
                  CircularProgressIndicator();
                }
              })

        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[


          Card(
            child: (filme.urlBackdrop!=null)?FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: filme.urlBackdrop,
            fit: BoxFit.cover,
            height: 200,):Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              height: 70.0,
              child: Text("Não há imagem disponível"),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),


          Card(
              child: ExpansionTile(
                title: Text("Sinopse",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)
                ),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(filme.descricao, style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300
                    ),),
                  )
                ],
              )),
          SizedBox(
            height: 8.0,
          ),



          Card(
              child: ExpansionTile(
            title: Text("Informações básicas",
            textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)
            ),
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    _buildLine(
                        "Titulo Original:", filme.tituloOriginal, false),
                    _buildLine(
                        "Linguagem Original:", filme.linguagemOriginal, true),
                    _buildLine(
                        "Data de Lançamento:", filme.dataLancamento, false),
                  ],
                ),
              )
            ],
          )),
          SizedBox(
            height: 8.0,
          ),

          Card(
              child: ExpansionTile(
                title: Text("Estatísticas",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)
                ),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        _buildLine(
                            "Voto médio:", filme.votoMedio.toString(), false),
                        _buildLine(
                            "Quantidade de votos:", filme.qtdadeVotos.toString(), true),
                        _buildLine(
                            "Popularidade:", filme.popularidade.toString(), false),
                      ],
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 8.0,
          )

        ],
      ),
    );
  }
}
