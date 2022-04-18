// Copyright 2021 Pepe Tiebosch (Jellepepe). All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:kswcardata/kswcardata.dart';

enum McuCommand {
  SWITCH_TO_OEM,
  TURN_OFF_SCREEN,
  HOME_BUTTON,
  REBOOT,
  OPEN_AUX,
  SOUND_RESTORE,
  NOTHING
}

extension McuCommandExtension on McuCommand {

  int get command {switch(this) {
    case McuCommand.SWITCH_TO_OEM: return 1;
    case McuCommand.TURN_OFF_SCREEN: return 1;
    case McuCommand.HOME_BUTTON: return 1;
    case McuCommand.REBOOT: return 1;
    case McuCommand.OPEN_AUX: return 1;
    case McuCommand.SOUND_RESTORE: return 1;
    case McuCommand.NOTHING: return 0;
  }}
  int get subCommand {switch(this) {
    case McuCommand.SWITCH_TO_OEM: return 601;
    case McuCommand.TURN_OFF_SCREEN: return 113;
    case McuCommand.HOME_BUTTON: return 114;
    case McuCommand.REBOOT: return 125;
    case McuCommand.OPEN_AUX: return 605;
    case McuCommand.SOUND_RESTORE: return 604;
    case McuCommand.NOTHING: return 0;
  }}
  String? get arg {switch(this) {
    case McuCommand.SWITCH_TO_OEM: return null;
    case McuCommand.TURN_OFF_SCREEN: return null;
    case McuCommand.HOME_BUTTON: return null;
    case McuCommand.REBOOT: return null;
    case McuCommand.OPEN_AUX: return null;
    case McuCommand.SOUND_RESTORE: return '13';
    case McuCommand.NOTHING: return null;
  }}
  IconData get icon {switch(this) {
    case McuCommand.SWITCH_TO_OEM: return Icons.directions_car;
    case McuCommand.TURN_OFF_SCREEN: return Icons.cancel_presentation;
    case McuCommand.HOME_BUTTON: return Icons.home;
    case McuCommand.REBOOT: return Icons.restart_alt;
    case McuCommand.OPEN_AUX: return Icons.settings_input_component;
    case McuCommand.SOUND_RESTORE: return Icons.volume_up;
    case McuCommand.NOTHING: return Icons.close;
  }}

  String get commandJson => this.arg != null 
    ? '{"command":'+this.command.toString()+',"subCommand":'+this.subCommand.toString()+'}'
    : '{"command":'+this.command.toString()+',"subCommand":'+this.subCommand.toString()+',"jsonArg":'+(this.arg??'')+'}';

  Future<bool> launch() async {
    if(this != McuCommand.NOTHING) 
      return KswCarData.sendMcuCommand(this);
    return true;
  }
}

McuCommand mcuCommandFromString(String command) {
  return McuCommand.values.firstWhere((elem) => elem.toString() == ('McuCommand.'+command), orElse: () => McuCommand.NOTHING);
}