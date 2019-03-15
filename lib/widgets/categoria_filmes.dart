
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:closeup/bloc/generos_bloc.dart';
import 'package:closeup/screens/genero_list_screen.dart';
import 'package:closeup/tabs/home_tab.dart';
import 'package:closeup/widgets/itens_filme_horizontal.dart';
import 'package:closeup/widgets/wait_load.dart';
import 'package:flutter/material.dart';


class CategoriaFilmes extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    BlocProvider.of<GenerosBloc>(context).getGeneros();


    return StreamBuilder(
      builder: (context, snapshot){

        if(snapshot.hasData){
          return
            SizedBox(
              height: 75.0,
              child: GridView(
                  children: snapshot.data.map((genero) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GeneroListScreen( category: HomeTab.FILMES_GENERO, genero: genero,)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                                width: 3.0,
                                color: Theme.of(context).cardColor)),
                        alignment: Alignment.center,
                        width: 50.0,
                        child: Text(genero.nome),
                      ),
                    );
                  }).toList().cast<Widget>(),
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5)),
            );


        }else{
         return WaitLoad();
        }

      },

      stream: BlocProvider.of<GenerosBloc>(context).outGeneros,

    );
  }
}
