import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/bloc/filmes_bloc.dart';
import 'package:closeup/delegates/data_search.dart';
import 'package:closeup/tabs/favoritos_tab.dart';
import 'package:closeup/tabs/home_tab.dart';
import 'package:closeup/tabs/search_tab.dart';
import 'package:closeup/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  String result;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Close-Up"),
            centerTitle: true,
          ),
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text("Pesquisar"),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  String result =
                  await showSearch(context: context, delegate: DataSearch());
                  if (result != null) {
                    this.result=result;
                    BlocProvider.of<FilmesBloc>(context).search(SearchTab.QUERY_SEARCH, result);
                  }
                },
              ),
            ],
          ),
          body: SearchTab(),
          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text("Favoritos"),
            centerTitle: true,
          ),
          body: FavoritosTab(),
          drawer: CustomDrawer(_pageController),
        ),

        /*  Scaffold(

            body: HomeTab(),
            drawer: CustomDrawer(_pageController),

          ),
          Scaffold(
            appBar: AppBar(
              title: Text("Produtos"),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            body: ProductsTab(),
            floatingActionButton: CartButton(),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("Lojas"),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            body: PlacesTab(),
          ),        Scaffold(
            appBar: AppBar(
              title: Text("Meus Pedidos"),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            body: OrdersTab(),
          ),*/
      ],
    );
  }
}
