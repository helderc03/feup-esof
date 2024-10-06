import 'dart:ui';
import 'package:flutter/material.dart';


class DisplaySideMovie extends StatelessWidget {

  final String moviePath;
  final bool position;

  const DisplaySideMovie(
      {Key? key, required this.moviePath, required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.20,
      left: position ? 5 : null,
      right: position ? null : 5,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: moviePath == '' ? SizedBox.shrink() : Image.network(moviePath,
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
        ),
      ),
    );
  }
}
