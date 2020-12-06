package dev.wits.kswcardata;

import android.os.Handler;
import android.os.Looper;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * KswCarDataPlugin
 */
public class KswCarDataPlugin implements MethodCallHandler, EventChannel.StreamHandler {

    private Process continuousLogging;
    private boolean recording = false;
    private ArrayList<String> log;
    private ArrayList<String> carStatus = new ArrayList<String>();

    private Map<Object, EventChannel.EventSink> listeners = new HashMap<>();

    /**
     * Plugin registration
     */
    public static void registerWith(Registrar registrar) {
      KswCarDataPlugin plugin = new KswCarDataPlugin();
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "dev.wits.kswcardata");
        channel.setMethodCallHandler(plugin);

        final EventChannel streamChannel = new EventChannel(registrar.messenger(), "dev.wits.kswcardata/carStream");
        streamChannel.setStreamHandler(plugin);
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if(call.method.equals("getCarData")) {
            result.success(carStatus);
        } else if(call.method.equals("restartLogger")) {
            if(recording) {
                stop();
                start();
            } else {
                start();
            }
        } else if(call.method.equals("getRecordingStatus")) {
            result.success(recording);
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

    String getLogs() {
        if(recording) {
            return String.join("\n",log);
        } else {
            start();
            return "Starting recording";
        }
    }

    void onNewLogEntry(String logEntry) {
        if(logEntry.contains("IPowerManagerAppService") & logEntry.contains("acData")) {
            carStatus.clear();
            String[] cardata = logEntry.split("airTemperature")[1].split(":");
            carStatus.add(cardata[1].split(",")[0]);
            carStatus.add(cardata[2].split(",")[0]);
            carStatus.add(cardata[3].split(",")[0]);
            carStatus.add(cardata[4].split(",")[0]);
            carStatus.add(cardata[5].split(",")[0]);
            carStatus.add(cardata[6].split(",")[0]);
            carStatus.add(cardata[7].split(",")[0]);
            carStatus.add(cardata[8].split(",")[0]);
            carStatus.add(cardata[9].split(",")[0]);
            carStatus.add(cardata[11].split(",")[0]);
            carStatus.add(cardata[12].split(",")[0]);
            carStatus.add(cardata[13].split(",")[0].replace("}",""));
            carStatus.add(cardata[14].split(",")[0]);
            for(Map.Entry<Object, EventChannel.EventSink> entry : listeners.entrySet()) {
                entry.getValue().success(carStatus);
            }
        }
    }

    void start() throws IllegalStateException {
        if (!recording) {
            recording = true;

            Thread thread = new Thread() {
                public void run() {
                    log = new ArrayList<String>();
                    String line;
                    try {
                        //Clear all logcat entries, up until this point.
                        continuousLogging = Runtime.getRuntime().exec("logcat -c");
                        continuousLogging = Runtime.getRuntime().exec("logcat IPowerManagerAppService:I *:S");

                        //Get the Runtime Process' output.
                        BufferedReader bufferedReader = new BufferedReader(
                                new InputStreamReader(continuousLogging.getInputStream()));

                        while ((line = bufferedReader.readLine()) != null) {
                            final String logEntry = line + "\n";
                            log.add(logEntry);
                            if(log.size() > 20) {
                                log.remove(0);
                            }
                            onNewLogEntry(logEntry);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        recording = false;
                    }
                }
            };
            thread.start();
        } else {
            throw new IllegalStateException("Unable to call start(): Already recording.");
        }
    }

    void stop() throws IllegalStateException {
        if (recording) {
            if (continuousLogging != null) {
                //Kill the Runtime Process.
                continuousLogging.destroy();
            }
            log.clear();

            recording = false;
        } else {
            throw new IllegalStateException("Unable to call stop(): Currently not recording.");
        }
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
