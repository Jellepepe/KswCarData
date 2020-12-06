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

  static Stream<dynamic> _carDataStream;

  static Stream<dynamic> get carDataStream {
    _carDataStream = 
      _carDataChannel.receiveBroadcastStream(1);
    print(_carDataStream);

    return _carDataStream;
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
    debugPrint(carStatus.toString());
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
  int mileage;
  double gas; 
  int gasUnit;
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
    this.mileage       = int.parse(carStatus[6]);
    this.gas           = double.parse(carStatus[7]);
    this.gasUnit       = int.parse(carStatus[8]);
    this.seatbelt      = carStatus[9].toLowerCase() == 'true';
    this.speed         = double.parse(carStatus[10]);
    this.tempUnit      = int.parse(carStatus[11]);
    this.mcuVersion    = carStatus[12];
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
        + "Temperature: " + this.temperature.toString() + '\n'
        + "Average Speed: " + this.averageSpeed.toString() + '\n'
        + "Car door value: " + this.cardoor.toString() + '\n'
        + "Distance Unit: " + this.distanceUnit.toString() + '\n'
        + "RPM: " + this.rpm.toString() + '\n'
        + "Handbrake status: " + this.handbrake.toString() + '\n'
        + "Mileage: " + this.mileage.toString() + '\n'
        + "Gas: " + this.gas.toString() + '\n'
        + "Gas Unit: " + this.gasUnit.toString() + '\n'
        + "Seatbelt status: " + this.seatbelt.toString() + '\n'
        + "Speed: " + this.speed.toString() + '\n'
        + "Temperature Unit: " + this.tempUnit.toString() + '\n'
        + "MCU Version: " + this.mcuVersion.toString() + '\n';
    }
  }
}
