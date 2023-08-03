import 'package:apiexample3/product_model.dart';
import 'package:flutter/material.dart';
import 'methods.dart';

class FashionSubCategory extends StatelessWidget {
  int index;
  List<Datum> list = [];
  FashionSubCategory(this.index, this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildFutureList(),
      ),
    );
  }
}
