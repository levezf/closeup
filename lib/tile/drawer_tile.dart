import 'package:flutter/material.dart';


class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  DrawerTile(this.icon, this.text, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(right: 10.0),
        child: InkWell(
//          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          onTap: (){
            Navigator.of(context).pop();
            pageController.jumpToPage(page);
          },
          child: Container(
            decoration: BoxDecoration(color: pageController.page.round() == page?
                Theme.of(context).primaryColorLight: Colors.transparent,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50.0), topRight: Radius.circular(50.0))
            ),
            padding: EdgeInsets.only(left: 16.0),
            height: 55.0,
            child: Row(
              children: <Widget>[

                Icon(icon,
                  size: 32.0,
                  color: pageController.page.round() == page?
                  Theme.of(context).primaryColor: Colors.grey[700],),

                SizedBox(width: 32.0,),

                Text(text, style: TextStyle(
                    fontSize: 16.0,
                    color: pageController.page.round() == page?
                    Theme.of(context).primaryColor: Colors.grey[700]
                ),)
              ],
            ),
          ),
        ),
      )
    );
  }
}
