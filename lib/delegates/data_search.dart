

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/bloc/filmes_bloc.dart';
import 'package:closeup/database/api.dart';
import 'package:closeup/widgets/wait_load.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String>{

  static const int SUGESTAO_SEARCH = 5;


  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_)=>close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Api api = Api();
    if(query.isEmpty){
      return Container();
    }else {
      return FutureBuilder<List>(
        future: api.search(SUGESTAO_SEARCH, query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: WaitLoad(),
            );
          } else {
            return ListView(
                children: snapshot.data.map((s){
                  return ListTile(
                    title: Text(s),
                    leading: Icon(Icons.play_arrow),
                    onTap: () {
                      close(context, s);
                    },
                  );
                }).toList(),
          );
          }
        },
      );
    }
  }
}