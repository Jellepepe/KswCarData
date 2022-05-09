// Copyright 2021 Pepe Tiebosch (Jellepepe). All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kswcardata/kswcardata.dart';

class SoundRestorer {
  static final SoundRestorer _instance = SoundRestorer._internal();

  int systemMode = 0;
  Function(bool)? callback;
  StreamSubscription? systemModeSubscription;

  static Future<bool> restore() => McuCommand.SOUND_RESTORE.launch();

  factory SoundRestorer({void Function(bool)? restoreCallback}) {
    if(restoreCallback != null) {
      _instance.callback = restoreCallback;
    }
    return _instance;
  }

  void enable() {
    if(systemModeSubscription == null) {
      systemModeSubscription = KswCarData.carDataStream.listen((carData) {
        if(carData.systemMode != null && systemMode != carData.systemMode) {
          systemMode = carData.systemMode!;
          if(systemMode == 1) {
            restore().then((success) => callback != null ? callback!(success) : {});
          }
        }
      });
      debugPrint("Soundrestorer Service Enabled!");
    }
  }

  void disable() {
    if(systemModeSubscription != null) {
      systemModeSubscription?.cancel();
      systemModeSubscription = null;
      debugPrint("Soundrestorer Service Disabled!");
    }
  }
 
  SoundRestorer._internal();
}