import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app/common/determine_geoposition.dart';
import 'package:my_app/injectable_init.dart';
import 'package:my_app/pizzas/pizza_detail.dart';
import 'package:my_app/pizzas/pizzas.service.dart';

class PizzaList extends StatefulWidget {
  PizzaList({Key? key}) : super(key: key);

  @override
  _PizzaListState createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  Position? userLocation;

  @override
  void initState() {
    super.initState();
    determineGeoPosition().then((position) {
      userLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pizzasService = getIt<PizzasService>();

    return FutureBuilder<dynamic>(
      future: pizzasService.getPizzaList("${userLocation?.latitude}, ${userLocation?.longitude}"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return _pizzasListView(data,
              (String id) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return PizzaDetail(id: id);
                    }),
                  ));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  ListView _pizzasListView(data, onTap) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          var item = data[index];

          return _tile(item.id, item.name, item.city, Icons.place, onTap);
        });
  }

  ListTile _tile(String id, String name, String city, IconData icon, onTap) =>
      ListTile(
        onTap: () => onTap(id),
        title: Text(name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(city),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );
}
