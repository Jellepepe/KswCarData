// Copyright 2021 Pepe Tiebosch (Jellepepe). All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kswcardata/mcu_command.dart';

export 'package:kswcardata/mcu_command.dart';

/// Plugin for fetching the app logs
class KswCarData {
  static const _methodChannel = const MethodChannel('dev.byme.kswcardata');

  static const _carDataChannel = const EventChannel('dev.byme.kswcardata/carStream');

  static Stream<dynamic> _rawCarDataStream = _carDataChannel.receiveBroadcastStream(1);

  static Stream<dynamic> get rawCarDataStream {
    return _rawCarDataStream;
  }

  static Stream<CarData> get carDataStream {
    return _rawCarDataStream.map((cardata) {
      try{
        return CarData.fromJson(jsonDecode(cardata));
      } catch(e) {
        return CarData.failed('INVALID', "Failed to get car status: '$e'.");
      }});
  }

  static Stream<int?> get speedStream {
    return carDataStream.map((cardata) => cardata.speed);
  }

  static Stream<int?> get rpmStream {
    return carDataStream.map((cardata) => cardata.rpm);
  }

  static Future<CarData> getCarData() async {
    try {
      return CarData.fromJson(jsonDecode(await _methodChannel.invokeMethod('getCarData')));
    } on PlatformException catch (e) {
      return CarData.failed(e.code, e.message ?? '');
    } catch (e) {
      return CarData.failed('INVALID', "Failed to get car status: '$e'.");
    }
  }

  static Future<CarData> testCarData() async {
    try {
      return CarData.fromJson(await _methodChannel.invokeMethod('testCarData'));
    } on PlatformException catch (e) {
      return CarData.failed(e.code, e.message ?? '');
    } catch (e) {
      return CarData.failed('INVALID', "Failed to get car status: '$e'.");
    }
  }

  static Future<bool> sendMcuCommand(McuCommand command) async {
    try{
      return (await _methodChannel.invokeMethod('sendCommand', {'commandJson':command.commandJson}) ?? false);
    } catch (e) {
      print("Failed to send MCU command: '${e.toString()}'.");
      return false;
    }
  }

  static Future<bool> customMcuCommand(int command, int subCommand, {String? arg}) async {
    try{
      String mcuCommand = '{"command":'+command.toString()+',"subCommand":'+subCommand.toString()+'}';
      return (await _methodChannel.invokeMethod('sendCommand', {'commandJson':mcuCommand}) ?? false);
    } catch (e) {
      print("Failed to send MCU command: '${e.toString()}'.");
      return false;
    }
  }

}

enum CarDataState {
  VALID,
  INVALID,
  UNAVAILABLE,
  EMPTY,
  UNKNOWN
}

class CarData {
  static const int BONNET = 8;
  static const int BOOT = 4;
  static const int FRONT_LEFT = 16;
  static const int FRONT_RIGHT = 32;
  static const int REAR_LEFT = 64;
  static const int REAR_RIGHT = 128;

  bool isOpen(int door) => (cardoor! & door) != 0; 

  String error = 'Empty';
  CarDataState state = CarDataState.EMPTY;
  double? temperature;
  double? averageSpeed;
  int? cardoor;
  int? distanceUnit;
  int? rpm;
  bool handbrake = false; 
  int? range;
  int? fuel; 
  int? fuelUnit;
  double? consumption;
  bool seatbelt = true;
  int? speed;
  int? tempUnit;
  String? mcuVersion;
  bool btStatus = false;

  CarData.fromJson(dynamic json) {
    if(json == null) {
      this.error = "Received null from native side.";
      this.state = CarDataState.INVALID;
    } else {
      dynamic carStatus = json['carData'];
      this.error = "";
      this.state = CarDataState.VALID;
      try {
        this.temperature   = carStatus['airTemperature'] as double?;
        this.averageSpeed  = carStatus['averSpeed'] as double?;
        this.cardoor       = carStatus['carDoor'] as int?;
        this.distanceUnit  = carStatus['distanceUnitType'] as int?;
        this.rpm           = carStatus['engineTurnS'] as int?;
        this.handbrake     = carStatus['handbrake'] as bool;
        this.range         = carStatus['mileage'] as int?;
        this.fuel          = carStatus['oilSum'] as int?;
        this.fuelUnit      = carStatus['oilUnitType'] as int?;
        this.consumption   = carStatus['oilWear'] as double?;
        this.seatbelt      = carStatus['safetyBelt'] as bool;
        this.speed         = carStatus['speed'] as int?;
        this.tempUnit      = carStatus['temperatureUnitType'] as int?;
        this.mcuVersion    = json['mcuVerison'] as String?;
        this.btStatus      = (json['bluetooth'] as int?) == 1;
      } catch(e) {
        this.error = "Incomplete carData, error was:\n" + e.toString();
        this.state = CarDataState.INVALID;
      }
    }
    assert(() {
      print("Parsed CarData from Json: " + this.toString());
      return true;
    }());
  }

  CarData.failed(String code, String error) {
    this.error = error;
    switch (code) {
      case 'UNAVAILABLE':
        this.state = CarDataState.UNAVAILABLE;
        break;
      case 'INVALID':
        this.state = CarDataState.INVALID;
        break;
      case 'EMPTY':
        this.state = CarDataState.EMPTY;
        break;
      default:
        this.state = CarDataState.UNKNOWN;
    }
  }

  @override
  String toString() {
    if(state != CarDataState.VALID) {
      return "No car data available. State: ${state.toString().split('.').last} Error:\n" + error;
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
