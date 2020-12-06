# KswCarData

Flutter plugin to get CarData from the MCU on KSW-android car headunits (with snapdragon 625) using Logcat entries from the IPowerManagerAppService.
Based on work on MCU Logcat decoding by [daschacka](https://github.com/daschacka)

## Usage
Call `KswCarData.carDataStream` to access the broadcast stream of the car status.
Then cast to `List<String>` and create a `CarData` object.

Available values include:
- Outside temperature
- Average speed
- Car door status
- Engine rpm
- Fueltank contents
- Remaining range
- Seatbelt status
- Current speed

### Installation
The included example app shows the live data on-screen
Simply grant your app the READ_LOGS permission to allow it to read the logcat entries.

`adb shell pm grant dev.wits.kswcardata_example android.permission.READ_LOGS`
