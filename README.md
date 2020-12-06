# KswCarData

Flutter plugin to get CarData from the MCU on KSW-android car headunits (with snapdragon 625) using Logcat entries from the IPowerManagerAppService.
Based on work on MCU Logcat decoding by [daschacka](https://github.com/daschacka)

## Usage
Use `KswCarData.carDataStream` to access the broadcast stream of the car status (`CarData`).  
Use `KswCarData.rpmStream` to access the broadcast stream of the engine rpm (`int`).  
Use `KswCarData.speedStream` to access the broadcast stream of the vehicle speed (`double`).  
Call `KswCarData.getCarData()` to fetch single instance of car status (`CarData`).  
  
*Important! Most values require the ignition to be on, so ensure to update the car status if needed*

Available values include:
- Outside temperature
- Average speed
- Car door status
- Engine rpm
- Handbrake status
- Remaining range
- Fuel tank contents
- Fuel consumption
- Seatbelt status
- Current speed
- MCU version

### Installation
The included example app shows the live data on-screen
Simply grant your app the READ_LOGS permission to allow it to read the logcat entries.

`adb shell pm grant dev.wits.kswcardata_example android.permission.READ_LOGS`
