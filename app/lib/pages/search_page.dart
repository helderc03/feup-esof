import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../reusableWidgets/media_model.dart';
import 'movie_page.dart';


TextEditingController _textEditingController = TextEditingController();

void clearTextInput() {
  _textEditingController.clear();
}

class SearchPage extends StatefulWidget {
  final String email;
  final String username;
  final String password;
  final MediaModel? mediaModel;

  SearchPage({
    Key? key,
    required this.email,
    required this.username,
    required this.password,
    this.mediaModel
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  void initState() {
    super.initState();
    clearTextInput(); // Call the clearTextInput() function here
  }

  Future<List<MediaModel>> searchMedia(String query) async {
    final url =
        'https://api.themoviedb.org/3/search/multi?api_key=51b20269b73105d2fd84257214e53cc3&query=${query}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List<dynamic>;
      return results
          .map((result) =>
          MediaModel(
              result['title'] != null ? result['title'] : result['name'],
              result['media_type'],
              result['release_date'] != "" ? (result['release_date'] != null ? result['release_date'] : (result['first_air_date'] != null ? result['first_air_date'] : "No data")) : "No data",
              result['vote_average'] != null ? double.parse(result['vote_average'].toStringAsFixed(1)) : 0.0,
              result['poster_path'] != null ? 'https://image.tmdb.org/t/p/w500${result['poster_path']}' : 'null',
              result['overview'],
              result['id']))
          .toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }

  List<MediaModel> displayList = [];
  String foundPlatform = "";

  void updateList(String value) {
    if (value.isEmpty) {
      setState(() {
        displayList = [];
      });
    } else {
      searchMedia(value).then((results) {
        setState(() {
          displayList = results;
        });
      }).catchError((error) {
        print(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search for a Movie or a Series",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            KeyedSubtree(
              key: Key("searchBar"),
              child: TextField(
                controller: _textEditingController,
                onChanged: (value) async {
                  await Future.delayed(const Duration(seconds: 1));
                  updateList(value);
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff302360),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "example: Mad men",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.search, size: 30.0),
                  prefixIconColor: Colors.white,
                  suffixIcon: const IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: clearTextInput,
                  ),
                  suffixIconColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: displayList.isEmpty
                  ? const Center(
                child: Text(
                  "No results found :(",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  final movie = displayList[index];
                  return GestureDetector(
                    onTap: () async {
                      String utellyApiPath = '' +
                            movie.id.toString() +
                          '&source=tmdb&country=us';
                      var url = Uri.parse(utellyApiPath);
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
                        locations = data['collection']['locations'];
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
                      print(foundPlatform);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MediaPage(
                                email: widget.email,
                                username: widget.username,
                                password: widget.password,
                                platform: foundPlatform,
                                mediaModel: displayList[index],
                              ),
                        ),
                      );
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      title: Text(
                        movie.mediaTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        movie.mediaReleaseYear ?? "",
                        style: const TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                      trailing: Text(
                        '${movie.rating}',
                        style: const TextStyle(color: Colors.amber,
                            fontSize: 24.0),
                      ),
                      leading: movie.poster != "null"
                          ? Image.network(movie.poster)
                          : Image.asset('assets/no-image.png'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget drawMovieInfoLine(BuildContext context, MediaModel movie) {
    return ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        title: Text(
          movie.mediaTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          movie.mediaReleaseYear ?? "",
          style: const TextStyle(
            color: Colors.white60,
          ),
        ),
        trailing: Text(
          '${movie.rating}',
          style: const TextStyle(color: Colors.amber, fontSize: 24.0),
        ),
        leading: movie.poster != "null"
            ? Image.network(movie.poster)
            : Image.asset('assets/no-image.png')
    );
  }
}