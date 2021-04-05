import 'package:injectable/injectable.dart';

@singleton
class Config {
  final String? clientId = "R4LHUWCGL0QT11C01JB2J0Z4VCVIUQEUVYHE4GSB0SQDAUCB";
  final String? clientSecret =
      "XWCJBW4YAPKN5NSMU44Z2AOED3WJJNZXH0BTA3WWV1AUSOFP";

  final String? apiUrl = "https://api.foursquare.com/v2";
}
