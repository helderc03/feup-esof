  import 'dart:convert';
  import 'dart:ui';
  import 'package:flutter/material.dart';
  import 'package:flutter/physics.dart';
  import 'package:project/reusableWidgets/display_filter.dart';
  import 'package:project/reusableWidgets/display_main_movie/display_movie_rating.dart';
  import 'package:project/reusableWidgets/display_main_movie/display_movie_release.dart';
  import 'package:project/reusableWidgets/display_main_movie/display_movie_title.dart';
  import 'package:project/reusableWidgets/media_model.dart';
  import 'package:project/reusableWidgets/display_side_movie.dart';
  import 'package:tmdb_api/tmdb_api.dart';
  import 'package:http/http.dart' as http;
  import 'package:project/reusableWidgets/display_main_movie/display_poster.dart';
  import '../reusableWidgets/custom_nav_bar.dart';
  import 'movie_page.dart';

  class MyHomePage extends StatefulWidget {
    final String email;
    final String username;
    final String password;

    const MyHomePage(
        {Key? key,
          required this.email,
          required this.username,
          required this.password})
        : super(key: key);

    @override
    State<MyHomePage> createState() => MyHomePageState();
  }



  class MyHomePageState extends State<MyHomePage> {
    List<dynamic> displayMovies = [];
    final String apikey = '51b20269b73105d2fd84257214e53cc3';
    final readAcessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MWIyMDI2OWI3MzEwNWQyZmQ4NDI1NzIxNGU1M2NjMyIsInN1YiI6IjY0MjdmZGU4OWNjNjdiMDViZjZlZWZmMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rXi6vsFhTtCqdUNv2UPukvqW5_D3wUbnTlamH8UzhA4';
    int page_number = 1;
    int _currentIndex = 0;
    String methodName = 'getTopRatedMovies';
    int _buttonPressedIndex = 1;
    List<String> platforms = [];
    String   foundPlatform = "";
    Future<String> getMediaType(String mediaName) async {
      final url =
          'https://api.themoviedb.org/3/search/multi?api_key=51b20269b73105d2fd84257214e53cc3&query=${mediaName}';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data["results"][0];
        return results['media_type'];
      }
      return "";
    }

    String result = "";

    String updateString(String value) {
      if (value == "") {
        setState(() {
          result = "";
        });
      } else {
        getMediaType(value).then((results) {
          setState(() {
            result = results;
          });
        }).catchError((error) {
          print(error);
        });
      }
      return result;
    }

    void topRatedMoviesButton() {
      _currentIndex = 0;
      displayMovies.clear();
      page_number = 1;
      methodName = 'getTopRatedMovies';
      loadMovies(methodName);
    }

    void popularButton() {
      _currentIndex = 0;
      displayMovies.clear();
      page_number = 1;
      methodName = 'getPopular';
      loadMovies(methodName);
    }

    void topRatedSeriesButton() {
      _currentIndex = 0;
      displayMovies.clear();
      page_number = 1;
      methodName = 'getTopRatedSeries';
      loadMovies(methodName);
    }

    void _incrementIndex() {
      setState(() {
        if (_currentIndex == displayMovies.length - 2) {
          loadMovies(methodName);
        }
        _currentIndex = (_currentIndex + 1) % displayMovies.length;
      });
    }

    String getLeftMoviePosterPath() {
      return _currentIndex - 1 < 0
          ? displayMovies.isEmpty
          ? ''
          : 'https://image.tmdb.org/t/p/w500' +
          displayMovies[displayMovies.length - 1]['poster_path']
          : 'https://image.tmdb.org/t/p/w500' +
          displayMovies[_currentIndex - 1]['poster_path'];
    }

    String getRightMoviePosterPath() {
      return displayMovies.isEmpty || _currentIndex + 1 >= displayMovies.length
          ? ''
          : 'https://image.tmdb.org/t/p/w500' +
          displayMovies[_currentIndex + 1]['poster_path'];
    }

    String getMovieTitle() {
      return methodName == 'getTopRatedSeries'
          ? displayMovies[_currentIndex]['name']
          : displayMovies[_currentIndex]['title'];
    }

    String getMovieReleaseDate() {
      return (displayMovies[_currentIndex].containsKey('release_date') ||
          displayMovies[_currentIndex].containsKey('first_air_date'))
          ? (methodName == 'getTopRatedSeries'
          ? displayMovies[_currentIndex]['first_air_date']
          .toString()
          .substring(0, 4)
          : displayMovies[_currentIndex]['release_date']
          .toString()
          .substring(0, 4))
          : '';
    }

    String getMovieRating(){
      return displayMovies[_currentIndex]
          .containsKey('vote_average')
          ? displayMovies[_currentIndex]
      ['vote_average']
          .toString()
          : '';
    }

    void _decrementIndex() {
      setState(() {
        _currentIndex = (_currentIndex - 1) % displayMovies.length;
      });
    }

    @override
    void initState() {
      loadMovies(methodName);
      super.initState();
    }

    loadMovies(String methodName) async {
      try {
        TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readAcessToken),
            logConfig: ConfigLogger(
              showLogs: true,
              showErrorLogs: true,
            ));
        switch (methodName) {
          case 'getTopRatedMovies':
            Map movieResults =
            await tmdbWithCustomLogs.v3.movies.getTopRated(page: page_number);
            page_number = page_number + 1;
            setState(() {
              displayMovies.addAll(movieResults['results']);
            });
            break;
          case 'getPopular':
            Map movieResults =
            await tmdbWithCustomLogs.v3.movies.getPopular(page: page_number);
            page_number = page_number + 1;
            setState(() {
              displayMovies.addAll(movieResults['results']);
            });
            break;
          case 'getTopRatedSeries':
            Map movieResults =
            await tmdbWithCustomLogs.v3.tv.getTopRated(page: page_number);
            page_number = page_number + 1;
            setState(() {
              displayMovies.addAll(movieResults['results']);
            });
            break;

          default:
            print('Invalid method name: $methodName');
            break;
        }
      } catch (e) {
        print('Error occurred while loading movies: $e');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
          bottomNavigationBar: CustomNavBar(
            email: widget.email,
            username: widget.username,
            password: widget.password,
          ),
          body: displayMovies.isEmpty
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                      key: Key("movieFilter1"),
                      onTap: () {
                        setState(() {
                          _buttonPressedIndex = 1;
                          topRatedMoviesButton();
                        });
                      },
                      child: DisplayFilter(filterName: "Top Rated Movies", buttonPressedIndex: _buttonPressedIndex, filterButton: 1)),

                  GestureDetector(
                      key: Key("movieFilter2"),
                      onTap: () {
                        setState(() {
                          _buttonPressedIndex = 2;
                          popularButton();
                        });
                      },
                      child: DisplayFilter(filterName: "Popular", buttonPressedIndex: _buttonPressedIndex, filterButton: 2,)
                  ),
                  GestureDetector(
                      key: Key("movieFilter3"),
                      onTap: () {
                        setState(() {
                          _buttonPressedIndex = 3;
                          topRatedSeriesButton();
                        });
                      },
                      child: DisplayFilter(filterName: "Top Rated Series", buttonPressedIndex: _buttonPressedIndex, filterButton: 3)),

                ],
              ),
              Stack(
                children: <Widget>[
                  DisplaySideMovie(
                      moviePath: getLeftMoviePosterPath(), position: true),
                  DisplaySideMovie(
                      moviePath: getRightMoviePosterPath(),
                      position: false),
                  Center(
                    child: GestureDetector(
                      onHorizontalDragEnd: (DragEndDetails details) {
                        if (details.primaryVelocity! > 0) {
                          _decrementIndex();
                        } else if (details.primaryVelocity! < 0) {
                          _incrementIndex();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.08),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                                key: Key("moviePoster"),
                                onTap: () async {
                                  var url = Uri.parse('' +
                                       displayMovies[_currentIndex]['id'].toString() +
                                      '&source=tmdb&country=us');
                                  var headers = {
                                    "X-RapidAPI-Key": "" ,
                                    "X-RapidAPI-Host": "",
                                    "content-type": ""
                                  };
                                  var data, locations = [];
                                  try {
                                    var response = await http.get(url, headers: headers);
                                    if (response.statusCode < 200 || response.statusCode > 299) {print("error");}
                                    data = jsonDecode(response.body);
                                    if (data['collection'] != null && data['collection']['locations'] != null) locations = data['collection']['locations'];
                                  } catch (e) {
                                    print('Error making HTTP request: $e');
                                    locations = [];
                                  }

                                  for (int i = 0; i < locations.length; i++){
                                    final String platform = locations[i]['display_name'];
                                    switch(platform){
                                      case "Netflix":
                                        {
                                          foundPlatform = "netflix.png";
                                          break;
                                        }
                                      case "Disney+":
                                        {
                                          foundPlatform = "disney.jpg";
                                          break;
                                        }
                                      case "Amazon Prime Video":
                                        {
                                          foundPlatform = "amazon-prime.png";
                                          break;
                                        }
                                      case "AppleTV+":
                                        {
                                          foundPlatform = "appletv.png";
                                          break;
                                        }
                                    }
                                  }

                                  Navigator.push( context, MaterialPageRoute (
                                      builder: (context)  => MediaPage(
                                        key: Key("moviePage"),
                                        email: widget.email,
                                        username: widget.username,
                                        password: widget.password,
                                        platform: foundPlatform,
                                        mediaModel: MediaModel(
                                            methodName == 'getTopRatedSeries'
                                                ? displayMovies[
                                            _currentIndex]
                                            ['name']
                                                : displayMovies[
                                            _currentIndex]
                                            ['title'],
                                            updateString(methodName == 'getTopRatedSeries'
                                                ? displayMovies[
                                            _currentIndex]
                                            ['name']
                                                : displayMovies[
                                            _currentIndex]
                                            ['title']),
                                            methodName ==
                                                'getTopRatedSeries'
                                                ? displayMovies[
                                            _currentIndex]
                                            ['first_air_date']
                                                : displayMovies[
                                            _currentIndex]
                                            ['release_date'],
                                            displayMovies[_currentIndex]
                                            ['vote_average'].toDouble(),
                                            'https://image.tmdb.org/t/p/w500' +
                                                displayMovies[
                                                _currentIndex]
                                                ['poster_path'],
                                            displayMovies[_currentIndex]
                                            ['overview'],
                                            displayMovies[_currentIndex]
                                            ['id']),
                                      )),
                                  );
                                },
                                child: DisplayMoviePoster(moviePath: displayMovies[_currentIndex]['poster_path'])),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DisplayMovieTitle(key:Key("movieTitleBox"),movieTitle: getMovieTitle()),
                                DisplayMovieRelease(movieRelease: getMovieReleaseDate()),
                              ],
                            ),
                            DisplayMovieRating(movieRating: getMovieRating()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ));
    }
  }