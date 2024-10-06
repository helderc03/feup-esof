import 'package:flutter/material.dart';

class DisplayMovieRating extends StatelessWidget {
  final String movieRating;

  const DisplayMovieRating(
      {Key? key, required this.movieRating})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height *
              0.0001),
      child: Text(
        movieRating,
        style: TextStyle(
          color: Colors.amber,
          fontSize:
          MediaQuery.of(context).size.height *
              0.03,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}
