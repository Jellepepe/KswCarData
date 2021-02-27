/**
 * Copyright 2021 Pepe Tiebosch (Jellepepe). All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

package dev.wits.kswcardata;

import android.os.Handler;
import android.os.Looper;
import android.os.IBinder;
import android.os.RemoteException;
import android.util.Log;
import android.app.Activity;
import android.provider.Settings;

import java.io.InputStreamReader;
import java.util.concurrent.ThreadLocalRandom;
import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.wits.pms.ICmdListener;
import com.wits.pms.IContentObserver;
import com.wits.pms.IPowerManagerAppService;

/**
 * KswCarDataPlugin
 */
public class KswCarDataPlugin implements MethodCallHandler, EventChannel.StreamHandler {

    private static String test_data() {
        return "{\"carData\":{\"airTemperature\":0.0,\"averSpeed\":0.0,\"carDoor\":80,\"carGear\":0,\"distanceUnitType\":0,\"engineTurnS\":"
        + ThreadLocalRandom.current().nextInt(0, 6001)
        + ",\"handbrake\":false,\"mileage\":0,\"oilSum\":0,\"oilUnitType\":0,\"oilWear\":0.0,\"safetyBelt\":false,\"signalDouble\":0,\"signalLeft\":0,\"signalRight\":0,\"speed\":"
        + ThreadLocalRandom.current().nextInt(0, 221)
        + ",\"temperatureUnitType\":0},\"mcuVerison\":\"023052dGS-CIC-GTL-200617-B18\\u0000\\u0000\\u0000\\u0000\\u0000\\u0000\\u0000\\u0000\\u0000\\u0000\\u0000\\u0000\",\"systemMode\":0}";
    }

    private final Activity activity;
    private String carStatus;

    private HashMap<Object, EventChannel.EventSink> listeners = new HashMap<>();

    private ICmdListener cmdListener = new ICmdListener.Stub() {
        @Override
        public boolean handleCommand(String str) {
            return false;
        }

        @Override
        public void updateStatusInfo(String statusInfo) {
            if (!statusInfo.isEmpty() && Character.getNumericValue(statusInfo.charAt(statusInfo.length()-2)) == 5) {
                onNewLogEntry(statusInfo.substring(12, statusInfo.length()-11));
            }
        }
    };

    private IContentObserver contentObserver = new IContentObserver.Stub() {
        @Override
        public void onChange() throws RemoteException {
            onNewLogEntry(getWitsManager().getStatusString("mcuJson"));
        }
    };

    private static IPowerManagerAppService getWitsManager() {
        try {
            Class<?> serviceManager = Class.forName("android.os.ServiceManager");
            return IPowerManagerAppService.Stub.asInterface((IBinder) serviceManager.getMethod("getService", new Class[]{String.class}).invoke(serviceManager, new Object[]{"wits_pms"}));
        } catch (Exception e) {
            Log.e("KswCarData", "Error wits_pms service init", e);
            return null;
        }
    }

    /**
     * Plugin registration
     */
    public static void registerWith(Registrar registrar) {
      final MethodChannel channel = new MethodChannel(registrar.messenger(), "dev.wits.kswcardata");
      KswCarDataPlugin plugin = new KswCarDataPlugin(registrar.activity());
      channel.setMethodCallHandler(plugin);

      final EventChannel streamChannel = new EventChannel(registrar.messenger(), "dev.wits.kswcardata/carStream");
      streamChannel.setStreamHandler(plugin);
    }

    private KswCarDataPlugin(Activity activity) {
        this.activity = activity;
        try{
            getWitsManager().registerCmdListener(cmdListener);
            getWitsManager().registerObserver("mcuJson", contentObserver);
        } catch (Exception e){
            Log.e("KswCarData","Error Attaching Listeners",e);
        }
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if(call.method.equals("getCarData")) {
            try{
                onNewLogEntry(getWitsManager().getStatusString("mcuJson"));
            } catch (Exception e){
                Log.e("KswCarData","Error Fetching CarStatus manually",e);
            }
            result.success(carStatus);
        } else if(call.method.equals("testCarData")) {
            onNewLogEntry(test_data());
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onListen(Object listener, EventChannel.EventSink eventSink) {
        listeners.put(listener, new MainThreadEventSink(eventSink));
    }
    
    @Override
    public void onCancel(Object listener) {
        listeners.remove(listener);
    }

    void onNewLogEntry(String mcuJson) {
        if(mcuJson.contains("carData")) {
            carStatus = mcuJson.replace("\\u0000","");
            carStatus = carStatus.replace("\\","");
            carStatus = addValue(carStatus, "bluetooth", Settings.System.getInt(activity.getContentResolver(), "ksw_bluetooth", 0));
            for(HashMap.Entry<Object, EventChannel.EventSink> entry : listeners.entrySet()) {
                entry.getValue().success(carStatus);
            }
        }
    }

    private String addValue(String mcuJson, String name, Object value) {
        mcuJson = mcuJson.substring(0,mcuJson.length()-1);
        mcuJson += ",\""+name+"\":"+String.valueOf(value)+"}";
        return mcuJson;
    }

    private static class MainThreadEventSink implements EventChannel.EventSink {
        private EventChannel.EventSink eventSink;
        private Handler handler;
    
        MainThreadEventSink(EventChannel.EventSink eventSink) {
          this.eventSink = eventSink;
          handler = new Handler(Looper.getMainLooper());
        }
    
        @Override
        public void success(final Object o) {
          handler.post(new Runnable() {
            @Override
            public void run() {
              eventSink.success(o);
            }
          });
        }
    
        @Override
        public void error(final String s, final String s1, final Object o) {
          handler.post(new Runnable() {
            @Override
            public void run() {
              eventSink.error(s, s1, o);
            }
          });
        }

        @Override
        public void endOfStream() {
          handler.post(new Runnable() {
            @Override
            public void run() {
              eventSink.endOfStream();
            }
          });
        }
    }
}
