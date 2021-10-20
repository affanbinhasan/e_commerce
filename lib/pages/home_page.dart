import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:carousel_slider/carousel_slider.dart';
//import 'package:fuzzy/fuzzy.dart';
//import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends StatelessWidget {
  final String apiUrl = "https://nogozo.com/api/romance-novels/?format=json";

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  String _name(dynamic user) {
    return user['name'];
  }

  String _location(dynamic user) {
    return "MRP : Rs " + user['mrp'];
  }

  String _age(Map<dynamic, dynamic> user) {
    return "Rent for : Rs. " + user['one_week_rent_price'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 100,
          backgroundColor: Color.fromARGB(175, 0, 210, 200),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                child: Image(
                  image: AssetImage('assets/images/amazon_logo.png'),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        print("microphone");
                      },
                      icon: Icon(Icons.mic),
                    ),
                    IconButton(
                      onPressed: () {
                        print("basket");
                      },
                      icon: Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
              ),
            ],
          )),
      drawer: Drawer(),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                bottom: 10,
                right: 10,
                left: 10,
              ),
              color: Color.fromARGB(175, 0, 210, 200),
              child: Container(
                height: 50,
                padding: EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: "What are you looking for ?",
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.search,
                          color: Color(0xFF018197),
                        ),
                      ),
                    )),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Color(0xFF018197),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Container(
                height: 105,
                decoration: BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                    image: AssetImage('assets/images/carousel_task.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.circular(7),
                image: DecorationImage(
                  image: AssetImage('assets/images/fliter_button.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: FutureBuilder<List<dynamic>>(
                  future: fetchUsers(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print(_age(snapshot.data[0]));
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(8),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            snapshot.data[index]['image'])),
                                    title: Text(_name(snapshot.data[index])),
                                    subtitle:
                                        Text(_location(snapshot.data[index])),
                                    trailing: Text(_age(snapshot.data[index])),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
