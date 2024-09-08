import 'package:flutter/material.dart';
import 'package:recipe_app/design/custom_scaf.dart';
import 'package:recipe_app/screens/home_screen.dart';
import 'package:recipe_app/screens/search.dart';

//I used the flutter sample as reference for this code https://flutter.github.io/samples/web_dashboard.html
class HomepageSetup extends StatefulWidget{
const HomepageSetup({super.key});

@override
State<HomepageSetup> createState()=> _HomeState();
}

class _HomeState extends State<HomepageSetup>{
  int page=0;
  @override 
  Widget build(BuildContext context){
    return CustomScaf(
      title: const Text('Recipe app',
      style: TextStyle(color: Color.fromARGB(255, 146, 39, 39)),),
     pageNum: page,
      actions: const [
        Row(
          children: [
           Padding(padding: 
            EdgeInsets.all(8.0),
            ),
            
          ],
        )
      ],
      
        dest: const [
CustomScafDest(title: 'Home', icon: Icons.home),
CustomScafDest(title: 'Search', icon: Icons.search),
CustomScafDest(title: 'Meal Plan', icon: Icons.free_breakfast),
CustomScafDest(title: 'Favorites', icon: Icons.favorite_border),

        ],
        body: pageChanger(page)!,
         onPageChanged: (newpage){
          setState(() {
            page=newpage;
          });
         }
         );
  }

  static Widget? pageChanger(int index){
    if(index==0){
     return const HomeScreen();
    }
    if(index==1){
      return const Search();
    }
    if(index==2){
      return const Column();
    }
    if(index==3){
     return const Column();
    }
    return null;
  }
}