import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import 'restaurant_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  var listRestaurantTest = {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
    "pictureId": "14",
    "city": "Medan",
    "rating": 4.2
  };

  const jsonResponse = {
    "error": false,
    "message": "success",
    "count": 20,
    "restaurants": [
      {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2
      },
      {
        "id": "s1knt6za9kkfw1e867",
        "name": "Kafe Kita",
        "description":
            "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
        "pictureId": "25",
        "city": "Gorontalo",
        "rating": 4
      }
    ]
  };

  final client = MockApiService();
  test('Verify JSON Parsing, Check the id & name of list restaurant from API',
      () async {
    // stub
    when(client.getListRestaurant()).thenAnswer(
        (_) async => Future.value(ListRestaurant.fromJson(jsonResponse)));
    // arrange
    RestaurantProvider restaurantProvider =
        RestaurantProvider(apiService: client);
    await restaurantProvider.fecthListRestaurant();
    //act
    var testFromApiResultId = restaurantProvider.list.restaurants[0].id ==
        Restaurant.fromJson(listRestaurantTest).id;
    var testFromApiResultName = restaurantProvider.list.restaurants[0].name ==
        Restaurant.fromJson(listRestaurantTest).name;
    // assert
    expect(testFromApiResultId, true);
    expect(testFromApiResultName, true);
  });
}
