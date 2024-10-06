import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  /* no http calls can be when testing so mocks will need to be created, not quite
   //sure how to do it yet, but this test is semi-strucutured
  group('SearchPage', () {
    testWidgets('should display search results', (WidgetTester tester) async {
      final mockClient = MockClient();
      final searchResponse = '{"results": [{"id": 1, "name": "foo"}, {"id": 2, "name": "bar"}]}';

      // Use Mockito to return a successful response when mockClient.get() is called
      when(mockClient.get('https://my-api.com/search?q=test'))
          .thenAnswer((_) async => http.Response(searchResponse, 200));

      // Build the widget
      await tester.pumpWidget(SearchPage());

      // Tap the search button
      await tester.tap(find.byKey(Key('searchButton')));
      await tester.pumpAndSettle();

      // Expect the results to be displayed
      expect(find.text('foo'), findsOneWidget);
      expect(find.text('bar'), findsOneWidget);
    });
  });

   */
}
