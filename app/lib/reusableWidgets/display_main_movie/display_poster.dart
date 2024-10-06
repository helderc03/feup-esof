import 'package:flutter/material.dart';


class DisplayMoviePoster extends StatelessWidget {
  final String moviePath;
  final bool? test;

  const DisplayMoviePoster(
      {Key? key, required this.moviePath, this.test = false})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width:
      MediaQuery.of(context).size.width * 0.7,
      height:
      MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: test == true
              ? AssetImage(moviePath) as ImageProvider
              : NetworkImage('https://image.tmdb.org/t/p/w500' + moviePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}