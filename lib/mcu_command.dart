// Copyright 2021 Pepe Tiebosch (Jellepepe). All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kswcardata/kswcardata.dart';

enum McuCommand {
  SWITCH_TO_OEM,
  TURN_OFF_SCREEN,
  NOTHING
}

extension McuCommandExtension on McuCommand {

  int get command {switch(this) {
    case McuCommand.SWITCH_TO_OEM: return 1;
    case McuCommand.TURN_OFF_SCREEN: return 1;
    case McuCommand.NOTHING: return 0;
  }}
  int get subCommand {switch(this) {
    case McuCommand.SWITCH_TO_OEM: return 601;
    case McuCommand.TURN_OFF_SCREEN: return 113;
    case McuCommand.NOTHING: return 0;
  }}
  IconData get icon {switch(this) {
    case McuCommand.SWITCH_TO_OEM: return Icons.directions_car;
    case McuCommand.TURN_OFF_SCREEN: return Icons.cancel_presentation;
    case McuCommand.NOTHING: return Icons.close;
  }}

  String get commandJson => '{"command":'+this.command.toString()+',"subCommand":'+this.subCommand.toString()+'}';

  Future<bool> launch() async {
    if(this != McuCommand.NOTHING) 
      return KswCarData.sendMcuCommand(this);
    return true;
  }
}

McuCommand mcuCommandFromString(String command) {
  return McuCommand.values.firstWhere((elem) => elem.toString() == ('McuCommand.'+command), orElse: () => McuCommand.NOTHING);
}