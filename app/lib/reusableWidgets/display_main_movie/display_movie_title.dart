import 'package:flutter/material.dart';

class DisplayMovieTitle extends StatelessWidget {
  final String movieTitle;

  const DisplayMovieTitle(
      {Key? key, required this.movieTitle})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return
      Flexible(
      fit: FlexFit.loose,
      child: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context)
                  .size
                  .height *
                  0.01),
          child:
          Text(
            key:Key("movieTitle"),
            movieTitle,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize:
              MediaQuery.of(context)
                  .size
                  .height *
                  0.03,
            ),
          )
      ),
    );
  }

}
