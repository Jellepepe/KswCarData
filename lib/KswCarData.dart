// Copyright 2021 Pepe Tiebosch (Jellepepe). All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kswcardata/mcu_command.dart';

export 'package:kswcardata/mcu_command.dart';

/// Plugin for fetching the app logs
class KswCarData {
  static const _methodChannel = MethodChannel('dev.byme.kswcardata');

  static const _carDataChannel = EventChannel('dev.byme.kswcardata/carStream');

  static final Stream<dynamic> _rawCarDataStream = _carDataChannel.receiveBroadcastStream(1);

  static Stream<dynamic> get rawCarDataStream {
    return _rawCarDataStream;
  }

  static Stream<CarData> get carDataStream {
    return _rawCarDataStream.map((rawCarData) {
      try {
        return CarData.fromJson(jsonDecode(rawCarData));
      } catch (e) {
        return CarData.failed('INVALID', "Failed to get car status: '$e'.");
      }
    });
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
    try {
      return (await _methodChannel.invokeMethod('sendCommand', {'commandJson': command.commandJson}) ?? false);
    } catch (e) {
      debugPrint("Failed to send MCU command: '${e.toString()}'.");
      return false;
    }
  }

  static Future<bool> customMcuCommand(int command, int subCommand, {String? arg}) async {
    try {
      String mcuCommand = '{"command":$command,"subCommand":$subCommand}';
      return (await _methodChannel.invokeMethod('sendCommand', {'commandJson': mcuCommand}) ?? false);
    } catch (e) {
      debugPrint("Failed to send MCU command: '${e.toString()}'.");
      return false;
    }
  }
}

enum CarDataState { VALID, INVALID, UNAVAILABLE, EMPTY, UNKNOWN }

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
  int? systemMode;
  bool btStatus = false;

  CarData.fromJson(dynamic json) {
    if (json == null) {
      error = 'Received null from native side.';
      state = CarDataState.INVALID;
    } else {
      dynamic carStatus = json['carData'];
      error = '';
      state = CarDataState.VALID;
      try {
        temperature = carStatus['airTemperature'] as double?;
        averageSpeed = carStatus['averSpeed'] as double?;
        cardoor = carStatus['carDoor'] as int?;
        distanceUnit = carStatus['distanceUnitType'] as int?;
        rpm = carStatus['engineTurnS'] as int?;
        handbrake = carStatus['handbrake'] as bool;
        range = carStatus['mileage'] as int?;
        fuel = carStatus['oilSum'] as int?;
        fuelUnit = carStatus['oilUnitType'] as int?;
        consumption = carStatus['oilWear'] as double?;
        seatbelt = carStatus['safetyBelt'] as bool;
        speed = carStatus['speed'] as int?;
        tempUnit = carStatus['temperatureUnitType'] as int?;
        mcuVersion = json['mcuVerison'] as String?;
        systemMode = json['systemMode'] as int?;
        btStatus = (json['bluetooth'] as int?) == 1;
      } catch (e) {
        error = 'Incomplete carData, error was:\n$e';
        state = CarDataState.INVALID;
      }
    }
    //print("Parsed CarData from Json: " + this.toString());
  }

  CarData.failed(String code, this.error) {
    switch (code) {
      case 'UNAVAILABLE':
        state = CarDataState.UNAVAILABLE;
        break;
      case 'INVALID':
        state = CarDataState.INVALID;
        break;
      case 'EMPTY':
        state = CarDataState.EMPTY;
        break;
      default:
        state = CarDataState.UNKNOWN;
    }
  }

  @override
  String toString() {
    if (state != CarDataState.VALID) {
      return "No car data available. State: ${state.toString().split('.').last} Error:\n$error";
    } else {
      return 'Car Data:\nOutside Temperature: $temperature\nAverage Speed: $averageSpeed\nOpen Car Doors: ${isOpen(BONNET) ? 'Bonnet ' : ''}${isOpen(FRONT_LEFT) ? 'Front Left ' : ''}${isOpen(FRONT_RIGHT) ? 'Front Right ' : ''}${isOpen(REAR_LEFT) ? 'Rear Left ' : ''}${isOpen(REAR_RIGHT) ? 'Rear Right ' : ''}${isOpen(BOOT) ? 'Boot ' : ''}\nDistance Unit: $distanceUnit\nRPM: $rpm\nHandbrake on: $handbrake\nRange: $range\nFuel Tank Contents: $fuel\nFuel Unit: $fuelUnit\nFuel Consumption: $consumption\nSeatbelt on: $seatbelt\nSpeed: $speed\nTemperature Unit: $tempUnit\nMCU Version: $mcuVersion\nBluetooth status: $btStatus\n';
    }
  }
}
