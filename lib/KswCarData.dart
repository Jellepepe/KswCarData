// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Plugin for fetching the app logs
class KswCarData {
  /// [MethodChannel] used to communicate with the platform side.
  static const _methodChannel = const MethodChannel('dev.wits.kswcardata');

  static const _carDataChannel = const EventChannel('dev.wits.kswcardata/carStream');

  static Stream<dynamic> _rawCarDataStream;

  static Stream<CarData> get carDataStream {
    if(_rawCarDataStream == null) {
      _rawCarDataStream = _carDataChannel.receiveBroadcastStream(1);
    }
    return _rawCarDataStream.map((cardata) => CarData(List<String>.from(cardata)));
  }

  static Stream<double> get speedStream {
    return carDataStream.map((cardata) => cardata.speed);
  }

  static Stream<int> get rpmStream {
    return carDataStream.map((cardata) => cardata.rpm);
  }

  static Future<bool> getRecordingStatus() async {
    if (Platform.isIOS) {
      debugPrint('Logs can only be fetched from Android Devices presently.');
      return false;
    }
    bool recording = false;
    try {
      recording = await _methodChannel.invokeMethod('getRecordingStatus');
    } on PlatformException catch (e) {
      debugPrint("Failed to get logs: '${e.message}'.");
    }
    return recording;
  }

  static Future<CarData> getCarData() async {
    if (Platform.isIOS) {
      return CarData.failed('Logs can only be fetched from Android Devices presently.');
    }
    bool isRunning = await getRecordingStatus();
    if(!isRunning) {
      _methodChannel.invokeMethod('restartLogger');
      debugPrint('Now Running: ' + (await getRecordingStatus()).toString());
    }
    List<String> carStatus;
    try {
      carStatus = await _methodChannel.invokeListMethod('getCarData');
    } on PlatformException catch (e) {
      carStatus = ["Failed to get logs: '${e.message}'."];
    }
    if (carStatus.length >= 13) {
      return CarData(carStatus);
    } else if(carStatus.length >= 1) {
      return CarData.failed(carStatus[0]);
    } else {
      return CarData.failed('Empty Carstatus');
    }
  }
}

class CarData {
  String error = 'Empty';
  double temperature;
  double averageSpeed;
  String cardoor;
  int distanceUnit;
  int rpm;
  bool handbrake; 
  int range;
  double fuel; 
  int fuelUnit;
  double consumption;
  bool seatbelt;
  double speed;
  int tempUnit;
  String mcuVersion;

  CarData(List<String> carStatus) {
    this.error = "";
    this.temperature   = double.parse(carStatus[0]);
    this.averageSpeed  = double.parse(carStatus[1]);
    this.cardoor       = carStatus[2];
    this.distanceUnit  = int.parse(carStatus[3]);
    this.rpm           = int.parse(carStatus[4]);
    this.handbrake     = carStatus[5].toLowerCase() == 'true';
    this.range         = int.parse(carStatus[6]);
    this.fuel          = double.parse(carStatus[7]);
    this.fuelUnit      = int.parse(carStatus[8]);
    this.consumption   = double.parse(carStatus[9]);
    this.seatbelt      = carStatus[10].toLowerCase() == 'true';
    this.speed         = double.parse(carStatus[11]);
    this.tempUnit      = int.parse(carStatus[12]);
    this.mcuVersion    = carStatus[13];
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
        + "Car Door value: " + this.cardoor.toString() + '\n'
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
        + "MCU Version: " + this.mcuVersion.toString() + '\n';
    }
  }
}
