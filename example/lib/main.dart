import 'dart:math';

import 'package:KswCarData/KswCarData.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CarData _carData = new CarData.failed('Not loaded yet.');
  bool _runningStatus = false;
  final random = Random();

  @override
  void initState() {
    _getRunningStatus();
    super.initState();
  }

  Future<void> _getCarData() async {
    final CarData carStatus = await KswCarData.getCarData();
    setState(() {
      _carData = carStatus;
    });
  }

  Future<void> _getRunningStatus() async {
    final CarData carStatus = await KswCarData.getCarData();
    final bool runningStatus = await KswCarData.getRecordingStatus();
    setState(() {
      _runningStatus = runningStatus;
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
                        debugPrint('IPowerManagerAppService: sendStatus Msg: {\"jsonArg\":\"{\"acData\":{\"AC_Switch\":false,\"autoSwitch\":false,\"backMistSwitch\":false,\"frontMistSwitch\":false,\"isOpen\":false,\"leftTmp\":0.0,\"loop\":0,\"mode\":0,\"rightTmp\":0.0,\"speed\":0.0,\"sync\":false},\"benzData\":{\"airBagSystem\":false,\"airMaticStatus\":0,\"auxiliaryRadar\":false,\"highChassisSwitch\":false,\"light1\":0,\"light2\":0,\"pressButton\":0},\"carData\":{\"airTemperature\":22.0,\"averSpeed\":0.0,\"carDoor\":192,\"distanceUnitType\":0,\"engineTurnS\":'
                          + random.nextInt(7000).toString()
                          + ',\"handbrake\":false,\"mileage\":309,\"oilSum\":27,\"oilUnitType\":0,\"oilWear\":0.0,\"safetyBelt\":true,\"speed\":150,\"temperatureUnitType\":0},\"mcuVerison\":\"615065dALS-ID5-X1-GT-190508-B18\\u0000\\u0000\\u0000\\u0000\\u0000\\u0000\\u0000\\u0000\\u0000\",\"systemMode\":1}\",\"type\":5}');
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sending test logcat"),
                          )
                        );
                      }
                    ),
                    /*IconButton(
                      color: Colors.white,
                      iconSize: 64,
                      icon: Icon(Icons.directions_car),
                      onPressed: () {
                        _getCarData();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Fetching Car Data"),
                          )
                        );
                      }
                    ),*/
                    IconButton(
                      color: Colors.white,
                      iconSize: 64,
                      icon: Icon(Icons.sync_problem),
                      onPressed: () {
                        _getRunningStatus();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Starting Service"),
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
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 20),
                    child: Text(
                      'KswCarData Service running: ' + _runningStatus.toString(), 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32
                        ),
                      textAlign: TextAlign.left,
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: StreamBuilder(
                      stream: KswCarData.carDataStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        print(snapshot);
                        if(snapshot.hasData) {
                          return Text(
                            CarData(List<String>.from(snapshot.data)).toString(),
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
