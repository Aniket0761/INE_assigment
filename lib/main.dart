import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController search = TextEditingController();
  List searchedResults = [];
  List allCustomers = [];

  void initState() {
    allCustomers = [];
    getOrderDetails().then((value) {
      print(searchedResults.length);
      // print(orders[0]);
    });

    print(allCustomers);
    super.initState();
  }

  Future getOrderDetails() async {
    String url =
        "https://dmtwdst0cl.execute-api.us-east-1.amazonaws.com/production/customer";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);
    // print(responseData);
    for (var element in responseData) {
      allCustomers.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Search Customers",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: search,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15.0),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(width: 0.8)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                width: 0.8,
                                color: Theme.of(context).primaryColor)),
                        hintText: "Search Here",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'First Name or Last Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 30,
                                width: 20,
                                child: VerticalDivider(
                                  width: 10,
                                  thickness: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            if (search.text == '') {
                              setState(() {
                                searchedResults = [];
                              });
                            } else {
                              setState(() {
                                searchedResults = [];
                              });

                              for (var item in allCustomers) {
                                if (item['firstName']
                                        .toString()
                                        .toLowerCase()
                                        .startsWith(
                                            search.text.substring(0, 1)) &&
                                    item['firstName']
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase())) {
                                  setState(() {
                                    searchedResults.add(item);
                                  });
                                }
                              }
                              for (var item in allCustomers) {
                                if (!searchedResults.contains(item)) {
                                  if (item['firstName']
                                      .toLowerCase()
                                      .contains(search.text.toLowerCase())) {
                                    setState(() {
                                      searchedResults.add(item);
                                    });
                                  }
                                }
                              }
                              for (var item in allCustomers) {
                                if (item['lastName']
                                        .toString()
                                        .toLowerCase()
                                        .startsWith(
                                            search.text.substring(0, 1)) &&
                                    item['lastName']
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase())) {
                                  setState(() {
                                    searchedResults.add(item);
                                  });
                                }
                              }
                              for (var item in allCustomers) {
                                if (!searchedResults.contains(item)) {
                                  if (item['lastName']
                                      .toLowerCase()
                                      .contains(search.text.toLowerCase())) {
                                    setState(() {
                                      searchedResults.add(item);
                                    });
                                  }
                                }
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                )
              ],
            ),
            Container(
              width: 500,
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchedResults.length,
                  itemBuilder: ((context, index) => Card(
                        child: Container(
                          height: 120,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'First Name: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(searchedResults[index]['firstName']
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Last Name: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(searchedResults[index]['lastName']
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Age: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(searchedResults[index]['age']
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Phone Number: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(searchedResults[index]['phoneNumber']
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Address: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(searchedResults[index]['address']
                                        .toString()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
