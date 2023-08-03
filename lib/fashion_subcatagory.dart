import 'dart:convert';

import 'package:apiexample3/product_model.dart';
import 'package:flutter/material.dart';
import 'methods.dart';
import 'package:http/http.dart';

class FashionSubCategory extends StatelessWidget {
  int index;
  List<Datum> list;

  FashionSubCategory(this.index, this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    print(list[index].children.length);
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: list[index].children.length,
            itemBuilder: (context, listViewIndex) {
              Size size = MediaQuery.of(context).size;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      list[index].children[listViewIndex].image,
                      height: size.height * 0.4,
                      width: size.width * 0.4,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "name : ${list[index].children[listViewIndex].name}",
                          style: textStyle(),
                        ),
                        Text(
                          "ID : ${list[index].children[listViewIndex].id}",
                          style: textStyle(),
                        ),
                        Text(
                          "Counts : ${list[index].children[listViewIndex].clicks}"
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

}
