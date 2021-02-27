# KswCarData

Flutter plugin to get CarData from the MCU on KSW-android car headunits (with snapdragon 625).

## Usage
Use `KswCarData.carDataStream` to access the broadcast stream of the car status (`CarData`).  
Use `KswCarData.carDataStream` to access the broadcast stream of the raw status Json (`String`).  
Use `KswCarData.rpmStream` to access the broadcast stream of the engine rpm (`int`).  
Use `KswCarData.speedStream` to access the broadcast stream of the vehicle speed (`int`).  
Call `KswCarData.getCarData()` to fetch single instance of car status (`CarData`).  
Call `KswCarData.testCarData()` to trigger test data and fetch it (`CarData`).  
  
*Important! Most values require the ignition to be on, so ensure to update the car status if needed*

Car Status is returned as a `CarData` class type  
  
Available values include:
- Outside temperature (`double`)
- Average speed (`double`)
- Car door status (`int`, See below)
- Engine rpm (`int`)
- Handbrake status (`bool`)
- Remaining range (`int`)
- Fuel tank contents (`int`)
- Average fuel consumption (`double`)
- Seatbelt status (`bool`)
- Current speed (`int`)
- MCU version (`String`)
- Bluetooth Connection status (`bool`)

Additionally, the function `CarData.isOpen(int door)` can be used in combination with the const door values (e.g. `CarData.FRONT_LEFT`) to check the status for each door.

### Installation
The included example app shows the live data on-screen, and includes some test buttons.  
This plugin no longer needs any special permissions, but will only work on Android car headunits with KSW software.

### License
This project is licensed under a BSD-3 Clause license, see the included LICENSE file for the full text