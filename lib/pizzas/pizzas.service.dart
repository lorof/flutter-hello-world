import 'package:injectable/injectable.dart';
import 'package:my_app/common/determine_geoposition.dart';
import 'package:my_app/common/http_client.dart';
import 'package:my_app/injectable_init.dart';

class Venue {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String country;

  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
  });

  factory Venue.fromResponse(Map<String, dynamic> json) {
    var venue = json['venue'];
    var location = venue['location'];

    return Venue(
        id: venue['id'],
        name: venue['name'],
        address: location['address'],
        city: location['city'],
        state: location['state'],
        country: location['country']);
  }
}

@singleton
class PizzasService {
  HttpClient _httpClient = getIt<HttpClient>();

  Map<String, Venue> _map1 = {};

  Future getPizzaList(String geoPosition) async {
    return await _httpClient.get('/venues/explore', queryParameters: {
      'v': 20180323,
      'limit': 5,
      'll': geoPosition,
      'query': 'pizza'
    }).then((response) {
      var items = response.data['response']['groups'][0]['items'];

      var list = items.map((item) => Venue.fromResponse(item)).toList();

      _map1 = Map.fromIterable(list, key: (e) => e.id, value: (e) => e);

      return list;
    });
  }

  MapEntry<String, Venue> getPizzaDetail(String id) {
    return _map1.entries.firstWhere((element) => element.key == id);
  }
}
