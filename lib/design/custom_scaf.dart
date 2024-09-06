import 'package:flutter/material.dart';

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
          child: Column(
            children: [
              DrawerHeader(child: Center(
                child: widget.title ),
                ),
                for (var t in widget.dest)
                ListTile(
                  leading: Icon(t.icon),
                  title: Text(t.title),
                  selected: 
                  widget.dest.indexOf(t)== widget.pageNum,
                  onTap: ()=> _tapDest(t),
                )
            ],
          ),
        ),
        VerticalDivider(
          width: 2,
          thickness: 2,
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
        body: Row(children: [
          NavigationRail(destinations: [
            ...widget.dest.map(
              (t)=> NavigationRailDestination(
                icon: Icon(t.icon), 
              label: Text(t.title)),
            )
          ],
           selectedIndex: widget.pageNum,
           onDestinationSelected: widget.onPageChanged ?? (_) {},
           ),
           VerticalDivider(
            width: 2,
            thickness: 2,
            color: Colors.red[300],
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
          label: t.title)
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