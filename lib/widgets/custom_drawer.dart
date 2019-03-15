import 'package:closeup/tile/drawer_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(217, 217, 217, 217), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            children: <Widget>[
              SizedBox(height: 20.0,),

              Container(
                margin: EdgeInsets.only(left: 16.0),
                child:  Text("Close-Up", textAlign: TextAlign.start, style: TextStyle(

                    color: Theme.of(context).primaryColor,
                    fontSize: 22.0,
                  fontWeight: FontWeight.bold
                ),),
              ),

              SizedBox(height: 20.0,),
              Divider(height: 1.0, color: Colors.black26),
              SizedBox(height: 20.0,),

              DrawerTile(Icons.rss_feed, "Feed", pageController, 0),
              DrawerTile(Icons.search, "Buscar", pageController, 1),
              DrawerTile(Icons.favorite, "Favoritos", pageController, 2),
            ],
          )
        ],
      ),
    );
  }
}
