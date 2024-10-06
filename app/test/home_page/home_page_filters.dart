import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  final String apikey = '';
  final readAcessToken =
      '';
  TMDB tmdb = TMDB(ApiKeys(apikey, readAcessToken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ));

  group('Test API response for movies and TV shows', () {
    test('Test API response for top rated', () async {
      // Call the API method that retrieves the movies
      final movieResults = await tmdb.v3.movies.getTopRated(page: 1);

      // Verify that the response contains the fields we need
      expect(movieResults['results'][0].containsKey('title'), true);
      expect(movieResults['results'][0].containsKey('release_date'), true);
      expect(movieResults['results'][0].containsKey('vote_average'), true);
      expect(movieResults['results'][0].containsKey('poster_path'), true);

      expect(movieResults['results'][1].containsKey('title'), true);
      expect(movieResults['results'][1].containsKey('release_date'), true);
      expect(movieResults['results'][1].containsKey('vote_average'), true);
      expect(movieResults['results'][1].containsKey('poster_path'), true);

      expect(movieResults['results'][2].containsKey('title'), true);
      expect(movieResults['results'][2].containsKey('release_date'), true);
      expect(movieResults['results'][2].containsKey('vote_average'), true);
      expect(movieResults['results'][2].containsKey('poster_path'), true);
    });

    test('Test API response for popular ', () async {
      // Call the API method that retrieves the movies
      final movieResults = await tmdb.v3.movies.getPopular(page: 1);

      // Verify that the response contains the fields we need
      expect(movieResults['results'][0].containsKey('title'), true);
      expect(movieResults['results'][0].containsKey('release_date'), true);
      expect(movieResults['results'][0].containsKey('vote_average'), true);
      expect(movieResults['results'][0].containsKey('poster_path'), true);

      expect(movieResults['results'][1].containsKey('title'), true);
      expect(movieResults['results'][1].containsKey('release_date'), true);
      expect(movieResults['results'][1].containsKey('vote_average'), true);
      expect(movieResults['results'][1].containsKey('poster_path'), true);

      expect(movieResults['results'][2].containsKey('title'), true);
      expect(movieResults['results'][2].containsKey('release_date'), true);
      expect(movieResults['results'][2].containsKey('vote_average'), true);
      expect(movieResults['results'][2].containsKey('poster_path'), true);
    });

    test('Test API response for Top rated series ', () async {
      // Call the API method that retrieves the movies
      final movieResults = await tmdb.v3.tv.getTopRated(page: 1);

      // Verify that the response contains the fields we need
      expect(movieResults['results'][0].containsKey('original_name'), true);
      expect(movieResults['results'][0].containsKey('name'), true);
      expect(movieResults['results'][0].containsKey('first_air_date'), true);
      expect(movieResults['results'][0].containsKey('vote_average'), true);
      expect(movieResults['results'][0].containsKey('poster_path'), true);

      expect(movieResults['results'][1].containsKey('original_name'), true);
      expect(movieResults['results'][0].containsKey('name'), true);
      expect(movieResults['results'][1].containsKey('first_air_date'), true);
      expect(movieResults['results'][1].containsKey('vote_average'), true);
      expect(movieResults['results'][1].containsKey('poster_path'), true);

      expect(movieResults['results'][2].containsKey('original_name'), true);
      expect(movieResults['results'][0].containsKey('name'), true);
      expect(movieResults['results'][2].containsKey('first_air_date'), true);
      expect(movieResults['results'][2].containsKey('vote_average'), true);
      expect(movieResults['results'][2].containsKey('poster_path'), true);
    });
  });
}