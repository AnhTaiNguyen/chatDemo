import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectIndex = 0;
  final List<String> catogires = ['Messages', 'Online', 'Group', 'Request'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      color: Colors.black26,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: catogires.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectIndex = index;
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 50.0,
                  vertical: 20.0,
                ),
                child: Text(catogires[index],
                    style: TextStyle(
                        color: index == selectIndex
                            ? Colors.white
                            : Colors.white60,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5)),
              ),
            );
          }),
    );
  }
}
