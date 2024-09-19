import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final selectedIndex;

  const CircleContainer({super.key, required this.color, required this.onTap, this.selectedIndex});

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.08,
        height: screenHeight * 0.08,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border:Border.all(color: Colors.black,width: 2),
        ),
      ),
    );
  }
}