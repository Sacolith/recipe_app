import 'package:flutter/material.dart';
import 'package:recipe_app/design/colors.dart';

bool pc(BuildContext context){
  return MediaQuery.of(context).size.width>960.0;
}

bool tablet(BuildContext context){
  return MediaQuery.of(context).size.width> 640.0;
}

class CustomScafDest{
  final String title;
  final IconData icon;

  const CustomScafDest({
    required this.title,
    required this.icon
  });
}

class CustomScaf extends StatefulWidget{
  final Widget? title;

  final List<Widget> actions;
  final Widget body;
  final int pageNum;
  final List<CustomScafDest> dest;
  final ValueChanged<int>? onPageChanged;

  const CustomScaf({ required this.title,required this.pageNum,
    required this.actions,required this.body,required this.dest,required this.onPageChanged,
    super.key
  });

  @override
  State<CustomScaf> createState()=> _CustomScafState();
}

class _CustomScafState extends State<CustomScaf>{

  @override
  Widget build(BuildContext context){
    //if the media query detects a screen size pc this will be displayed
    if(pc(context)){
     return Row(
      children: [
        Drawer(
          width: 250,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(2),
                  bottomRight: Radius.circular(2))
                  
                  ),
                  backgroundColor: Colors.grey,
          surfaceTintColor: Cols.bright_red,
          child: Column(
            children: [
              DrawerHeader(child: Center(
                child: widget.title ),
                
                ),
                for (var t in widget.dest)
                ListTile(
                  leading: Icon(t.icon),
                  title: Text(t.title),
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  selected: 
                  widget.dest.indexOf(t)== widget.pageNum,
                  onTap: ()=> _tapDest(t),
                )
            ],
          ),
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
          color: Colors.red[300],
        ),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              actions: widget.actions,
            ),
            body: widget.body,
            ) 
        )
      ],
     );
    }

    //if the media media query detects the screen size table this will be displayed 
    if(tablet(context)){
     return Scaffold(
      appBar: AppBar(
        title: widget.title,
        actions: widget.actions),
        body: Row(
          children: [
          NavigationRail(
                backgroundColor: Colors.grey,
                destinations: [
                  ...widget.dest.map(
                    (t) => NavigationRailDestination(
                      indicatorColor: Colors.blue,
                      icon: Icon(
                        t.icon,
                        color: const Color.fromARGB(255, 0, 204, 119),
                      ),
                      label: Text(t.title),
                    ),
                  )
                ],
                selectedIndex: widget.pageNum,
                onDestinationSelected: widget.onPageChanged ?? (_) {},
              ),
            
           const VerticalDivider(
            width: 1,
            thickness: 1,
            color: Colors.black,
           ),
           Expanded(
            child: widget.body)
        ],
        ),
        );
    }

    //any other screen size will display the following (mobile, etc)
    return Scaffold(
     body: widget.body,
     appBar: AppBar(
      title: widget.title,
      actions: widget.actions,
     ),
     bottomNavigationBar: BottomNavigationBar(
      items: [
        ...widget.dest.map(
          (t)=> BottomNavigationBarItem(icon: Icon(t.icon),
          label: t.title,backgroundColor: Colors.black)
        ),
      ],
      currentIndex: widget.pageNum,
      onTap: widget.onPageChanged,
     ),
    );
  }

  void _tapDest(CustomScafDest destin){
    var index= widget.dest.indexOf(destin);
    if (index != widget.pageNum){
      widget.onPageChanged!(index);
    }
  }
}