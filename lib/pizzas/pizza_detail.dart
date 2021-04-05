import 'package:flutter/material.dart';
import 'package:my_app/injectable_init.dart';
import 'package:my_app/layout/layout.dart';
import 'package:my_app/pizzas/pizzas.service.dart';

class PizzaDetail extends StatefulWidget {
  PizzaDetail({Key? key, String? title, required this.id}) : super(key: key);

  final String id;

  @override
  _PizzaDetailState createState() => _PizzaDetailState();
}

class _PizzaDetailState extends State<PizzaDetail> {
  @override
  Widget build(BuildContext context) {
    final pizzasService = getIt<PizzasService>();

    final Venue pizza = pizzasService.getPizzaDetail(widget.id).value;

    print(pizzasService.getPizzaDetail(widget.id).value.address);
    print(pizzasService.getPizzaDetail(widget.id).value.city);
    print(pizzasService.getPizzaDetail(widget.id).value.country);
    print(pizzasService.getPizzaDetail(widget.id).value.state);
    print(pizzasService.getPizzaDetail(widget.id).value.name);

    return Layout(
        title: pizza.name,
        child: Container(
            child: Column(
              children: [
                Container(
                    child: Text(
                        "address: ${pizza.state} ${pizza.city} ${pizza.address}", style: TextStyle(fontSize: 20),),
                    padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 1.0)),
              ],
            ),
            width: double.infinity));
  }
}
