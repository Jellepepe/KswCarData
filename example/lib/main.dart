// Copyright 2021 Pepe Tiebosch (Jellepepe). All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kswcardata/kswcardata.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CarData _carStatus = CarData.failed('EMPTY', 'CarStatus NotInitialised');
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
    int? command;
    int? subCommand;

    return MaterialApp(
      theme: ThemeData()..textTheme.apply(bodyColor: Colors.grey),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('KswCarData Plugin example app'),
          toolbarHeight: 40,
        ),
        body: Builder(
          builder: (context) => Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      color: Colors.white,
                      iconSize: 64,
                      icon: const Icon(Icons.cancel_presentation),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Turning off Screen'),
                          ),
                        );
                        KswCarData.sendMcuCommand(McuCommand.TURN_OFF_SCREEN).then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Successfully sent command: $value'),
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      color: Colors.white,
                      iconSize: 64,
                      icon: const Icon(Icons.directions_car),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Switching to OEM'),
                          ),
                        );
                        KswCarData.sendMcuCommand(McuCommand.SWITCH_TO_OEM).then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Successfully sent command: $value'),
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      color: Colors.white,
                      iconSize: 64,
                      icon: const Icon(Icons.warning),
                      onPressed: () {
                        _testCarStatus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fetching Test Data'),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      color: Colors.white,
                      iconSize: 64,
                      icon: const Icon(Icons.sync_problem),
                      onPressed: () {
                        _getCarStatus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fetching Data Manually'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: StreamBuilder(
                          stream: KswCarData.speedStream,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                'Speed: ${snapshot.data}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                ),
                              );
                            }
                            return const Text(
                              'Speed: Unknown',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: StreamBuilder(
                          stream: KswCarData.rpmStream,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                'RPM: ${snapshot.data}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                ),
                              );
                            }
                            return const Text(
                              'RPM: Unknown',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                              ),
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(top: 7, left: 20),
                        child: TextField(
                          maxLength: 1,
                          onChanged: (value) => command = int.tryParse(value),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            labelText: 'Command',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(top: 7, left: 20),
                        child: TextField(
                          maxLength: 3,
                          onChanged: (value) => subCommand = int.tryParse(value),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            labelText: 'subCommand',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 50,
                        alignment: Alignment.topCenter,
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 40,
                        ),
                        padding: const EdgeInsets.fromLTRB(8, 8, 30, 8),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (command != null && subCommand != null) {
                            KswCarData.customMcuCommand(command!, subCommand!).then(
                              (value) => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Successfully sent command: $value'),
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Incomplete MCU command'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: StreamBuilder(
                            stream: KswCarData.rawCarDataStream,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  'Raw Car Data Json:\n${snapshot.data}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                );
                              }
                              return const Text(
                                'No data',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: StreamBuilder(
                            stream: KswCarData.carDataStream,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                );
                              }
                              return Text(
                                _carStatus.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
