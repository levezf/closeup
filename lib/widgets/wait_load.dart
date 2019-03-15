import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class WaitLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: Center(
        child: FlareActor("assets/filmes_loading.flr", animation: "loading",fit: BoxFit.scaleDown,),
      ),
    );
  }
}
