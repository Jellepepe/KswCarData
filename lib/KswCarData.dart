// Copyright 2021 Pepe Tiebosch (Jellepepe). All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

/// Plugin for fetching the app logs
class KswCarData {
  static const _methodChannel = const MethodChannel('dev.wits.kswcardata');

  static const _carDataChannel = const EventChannel('dev.wits.kswcardata/carStream');

  static Stream<dynamic> _rawCarDataStream;

  static Stream<dynamic> get rawCarDataStream {
    if(_rawCarDataStream == null) {
      _rawCarDataStream = _carDataChannel.receiveBroadcastStream(1);
    }
    return _rawCarDataStream;
  }

  static Stream<CarData> get carDataStream {
    if(_rawCarDataStream == null) {
      _rawCarDataStream = _carDataChannel.receiveBroadcastStream(1);
    }
    return _rawCarDataStream.map((cardata) => CarData.fromJson(jsonDecode(cardata)));
  }

  static Stream<int> get speedStream {
    return carDataStream.map((cardata) => cardata.speed);
  }

  static Stream<int> get rpmStream {
    return carDataStream.map((cardata) => cardata.rpm);
  }

  static Future<CarData> getCarData() async {
    String carStatus;
    try {
      carStatus = await _methodChannel.invokeMethod('getCarData');
      return CarData.fromJson(carStatus);
    } on PlatformException catch (e) {
      carStatus = "Failed to get car status: '${e.message}'.";
      return CarData.failed(carStatus);
    }
  }

  static Future<CarData> testCarData() async {
    String carStatus;
    try {
      carStatus = await _methodChannel.invokeMethod('testCarData');
      return CarData.fromJson(carStatus);
    } on PlatformException catch (e) {
      carStatus = "Failed to get car status: '${e.message}'.";
      return CarData.failed(carStatus);
    }
  }
}

class CarData {
  static const int BONNET = 8;
  static const int BOOT = 4;
  static const int FRONT_LEFT = 16;
  static const int FRONT_RIGHT = 32;
  static const int REAR_LEFT = 64;
  static const int REAR_RIGHT = 128;

  bool isOpen(int door) => (cardoor & door) != 0; 

  String error = 'Empty';
  double temperature;
  double averageSpeed;
  int cardoor;
  int distanceUnit;
  int rpm;
  bool handbrake; 
  int range;
  int fuel; 
  int fuelUnit;
  double consumption;
  bool seatbelt;
  int speed;
  int tempUnit;
  String mcuVersion;
  bool btStatus;

  CarData(List<String> carStatus) {
    this.error = "";
    this.temperature   = double.parse(carStatus[0]);
    this.averageSpeed  = double.parse(carStatus[1]);
    this.cardoor       = int.parse(carStatus[2]);
    this.distanceUnit  = int.parse(carStatus[3]);
    this.rpm           = int.parse(carStatus[4]);
    this.handbrake     = carStatus[5].toLowerCase() == 'true';
    this.range         = int.parse(carStatus[6]);
    this.fuel          = int.parse(carStatus[7]);
    this.fuelUnit      = int.parse(carStatus[8]);
    this.consumption   = double.parse(carStatus[9]);
    this.seatbelt      = carStatus[10].toLowerCase() == 'true';
    this.speed         = int.parse(carStatus[11]);
    this.tempUnit      = int.parse(carStatus[12]);
    this.mcuVersion    = carStatus[13];
    this.btStatus      = int.parse(carStatus[14]) == 1;
  }

  CarData.fromJson(dynamic json) {
    dynamic carStatus = json['carData'];
    this.error = "";
    this.temperature   = carStatus['airTemperature'] as double;
    this.averageSpeed  = carStatus['averSpeed'] as double;
    this.cardoor       = carStatus['carDoor'] as int;
    this.distanceUnit  = carStatus['distanceUnitType'] as int;
    this.rpm           = carStatus['engineTurnS'] as int;
    this.handbrake     = carStatus['handbrake']as bool;
    this.range         = carStatus['mileage'] as int;
    this.fuel          = carStatus['oilSum'] as int;
    this.fuelUnit      = carStatus['oilUnitType'] as int;
    this.consumption   = carStatus['oilWear'] as double;
    this.seatbelt      = carStatus['safetyBelt'] as bool;
    this.speed         = carStatus['speed'] as int;
    this.tempUnit      = carStatus['temperatureUnitType'] as int;
    this.mcuVersion    = json['mcuVerison'] as String;
    this.btStatus      = json['bluetooth'] as int == 1;
    assert(() {
      print("Parsed CarData from Json: " + this.toString());
      return true;
    }());
  }

  CarData.failed(String error) {
    this.error = error;
  }

  bool failed() {
    return error.length > 0;
  }

  @override
  String toString() {
    if(failed()) {
      return "No car data available. Error:\n" + error;
    } else {
      return "Car Data:\n"
        + "Outside Temperature: " + this.temperature.toString() + '\n'
        + "Average Speed: " + this.averageSpeed.toString() + '\n'
        + "Open Car Doors: "
        + (isOpen(BONNET) ? 'Bonnet ' : '')
        + (isOpen(FRONT_LEFT) ? 'Front Left ' : '')
        + (isOpen(FRONT_RIGHT) ? 'Front Right ' : '')
        + (isOpen(REAR_LEFT) ? 'Rear Left ' : '')
        + (isOpen(REAR_RIGHT) ? 'Rear Right ' : '')
        + (isOpen(BOOT) ? 'Boot ' : '')
        + '\n'
        + "Distance Unit: " + this.distanceUnit.toString() + '\n'
        + "RPM: " + this.rpm.toString() + '\n'
        + "Handbrake on: " + this.handbrake.toString() + '\n'
        + "Range: " + this.range.toString() + '\n'
        + "Fuel Tank Contents: " + this.fuel.toString() + '\n'
        + "Fuel Unit: " + this.fuelUnit.toString() + '\n'
        + "Fuel Consumption: " + this.consumption.toString() + '\n'
        + "Seatbelt on: " + this.seatbelt.toString() + '\n'
        + "Speed: " + this.speed.toString() + '\n'
        + "Temperature Unit: " + this.tempUnit.toString() + '\n'
        + "MCU Version: " + this.mcuVersion.toString() + '\n'
        + "Bluetooth status: " + this.btStatus.toString() +'\n';
    }
  }
}
