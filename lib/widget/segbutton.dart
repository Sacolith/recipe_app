import 'package:flutter/material.dart';

class Segbutton extends StatefulWidget {
  final Searchtype selectedSearchType;
  final ValueChanged<Searchtype> onSelectionChanged;

  const Segbutton({
    super.key,
    required this.selectedSearchType,
    required this.onSelectionChanged,
  });

  @override
  State<Segbutton> createState() => SegbuttonState();
}

class SegbuttonState extends State<Segbutton> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          SegmentedButton<Searchtype>(
            style: SegmentedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.red,
              selectedForegroundColor: Colors.white,
              selectedBackgroundColor: Colors.green,
            ),
            segments: const <ButtonSegment<Searchtype>>[
              ButtonSegment<Searchtype>(
                value: Searchtype.recipes,
                label: Text('Recipes'),
                icon: Icon(Icons.receipt_outlined),
              ),
              ButtonSegment<Searchtype>(
                value: Searchtype.ingredients,
                label: Text('Ingredients'),
                icon: Icon(Icons.food_bank),
              ),
            ],
            selected: <Searchtype>{widget.selectedSearchType},
            onSelectionChanged: (Set<Searchtype> newSelection) {
              widget.onSelectionChanged(newSelection.first);
            },
          ),
        ],
      ),
    );
  }
}

enum Searchtype { ingredients, recipes }
