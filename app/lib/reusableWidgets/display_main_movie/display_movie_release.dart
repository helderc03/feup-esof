import 'package:flutter/material.dart';

class DisplayMovieRelease extends StatelessWidget {
  final String movieRelease;

  const DisplayMovieRelease(
      {Key? key, required this.movieRelease})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        margin: EdgeInsets.only(
            left: 15,
            top: MediaQuery.of(context)
                .size
                .height *
                0.008),
        child: Text(
          movieRelease,
          style: TextStyle(
            color: Colors.white70,
            fontSize: MediaQuery.of(context)
                .size
                .height *
                0.02,
          ),
        ),
      ),
    );
  }

}
