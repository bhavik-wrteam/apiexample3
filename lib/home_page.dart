
import 'dart:convert';

import 'package:apiexample3/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'fashion_subcatagory.dart';
import 'methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Datum> productList=[];



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildFutureList(),
        ),
      ),
    );
  }

  FutureBuilder<List<Datum>> buildFutureList() {



    return FutureBuilder(
      future: getProductData(),
      builder: (context, snapshot) {
        final Size size = MediaQuery.of(context).size;
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('snapshot = $snapshot');
          return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ));
        }

        if (snapshot.hasData) {
          print('snapshot = $snapshot');
          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if(productList[index].children.isNotEmpty){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => FashionSubCategory(index,productList)),
                      );
                    }
                    else{
                       const SnackBar snackBar = SnackBar(
                        content: Text("No Sub Categories exist"),
                        duration: Duration(seconds: 3),
                      );
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10)),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            productList[index].image,
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
                                "name : ${productList[index].name}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "id : ${productList[index].id}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "clicks : ${productList[index].clicks}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ));
        }
      },
    );
  }


  Future<List<Datum>> getProductData() async {
    final response = await post(
        Uri.parse('https://eshopweb.store/app/v1/api/get_categories'),
        headers: headers);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print("DAta fetched successfully");
      print(data);

      String message = data['message'];
      print(message);
      productList =
          (data['data'] as List).map((e) => Datum.fromJson(e)).toList();

      print("products returned successfully");
      return productList;
    } else {
      print("returned empty list");
      return productList;
    }
  }

  Map<String, String> get headers => {
    "Authorization":
    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2OTEwMzY4NDEsImlzcyI6ImVzaG9wIiwiZXhwIjoxNjkxMjUyODQxfQ.Bs_tZSIMRjQgwlin9J8eseR-bmT1pD15LyeKQHS2mGk',
  };







}
