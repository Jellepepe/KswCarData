// Copyright 2021 Pepe Tiebosch (Jellepepe). All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:kswcardata/kswcardata.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CarData _carStatus = CarData.failed("Empty");
  final random = Random();

  @override
  void initState() {
    _getCarStatus();
    super.initState();
  }

  Future<void> _getCarStatus() async {
    final CarData carStatus = await KswCarData.getCarData();
    setState(() {
      _carStatus = carStatus;
    });
  }

  Future<void> _testCarStatus() async {
    final CarData carStatus = await KswCarData.testCarData();
    setState(() {
      _carStatus = carStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('KswCarData CarData Plugin example app'),
        ),
        body: Builder(builder: (context) => 
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      color: Colors.white,
                      iconSize: 64,
                      icon: Icon(Icons.warning),
                      onPressed: () {
                        _testCarStatus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Fetching Test Data"),
                          )
                        );
                      }
                    ),
                    IconButton(
                      color: Colors.white,
                      iconSize: 64,
                      icon: Icon(Icons.sync_problem),
                      onPressed: () {
                        _getCarStatus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Fetching Data Manually"),
                          )
                        );
                      }
                    )
                  ]
                )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: StreamBuilder(
                        stream: KswCarData.speedStream,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if(snapshot.hasData) {
                            return Text(
                              'Speed: ' + snapshot.data.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                              ),
                            );
                          }
                          return Text(
                            'Speed: Unknown',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32
                            ),
                          );
                        }
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: StreamBuilder(
                        stream: KswCarData.rpmStream,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if(snapshot.hasData) {
                            return Text(
                              'RPM: ' + snapshot.data.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                              ),
                            );
                          }
                          return Text(
                            'RPM: Unknown',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32
                            ),
                          );
                        }
                      )
                    ),
                    ]
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: StreamBuilder(
                            stream: KswCarData.rawCarDataStream,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData) {
                                return Text(
                                  "Raw Car Data Json:\n" + snapshot.data.toString(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                );
                              }
                              return Text(
                                'No data',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              );
                            }
                          )
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: StreamBuilder(
                            stream: KswCarData.carDataStream,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                );
                              }
                              return Text(
                                _carStatus.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              );
                            }
                          )
                        ),
                      ),
                    ],
                  )
                ],
              )
            ]
          ),
        )
      ),
    );
  }

}
