import 'package:flutter/material.dart';

class DisplayFilter extends StatelessWidget {
  final String filterName;
  final int buttonPressedIndex;
  final int filterButton;


  const DisplayFilter(
      {Key? key, required this.filterName, required this.buttonPressedIndex, required this.filterButton})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: buttonPressedIndex == filterButton
            ? Colors.white
            : Colors.transparent,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        filterName,
        style: TextStyle(
          color: buttonPressedIndex == filterButton
              ? Color.fromRGBO(6, 10, 43, 1)
              : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}