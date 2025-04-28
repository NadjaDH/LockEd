import 'package:flutter/material.dart';
import 'package:locked/styles/colors.dart';
import 'package:locked/fonts/font.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:async'; // <-- needed for StreamSubscription
import 'dart:io';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key, required this.title});
  final String title;

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  BluetoothDevice? targetDevice;
  BluetoothCharacteristic? targetCharacteristic;
  StreamSubscription<List<ScanResult>>? scanSubscription;

  @override
  void initState() {
    super.initState();
    initializeBluetooth();
  }

  Future<void> initializeBluetooth() async {
    await requestPermissions();
    await connectToDevice();
  }

  Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      // Check if the Android version is 11 or lower
      if (Platform.version.contains('11') || Platform.version.contains('30')) {
        // For Android 11 and below, permissions are granted at install time
        print(
          "Permissions are granted at install time for Android 11 or lower.",
        );
      } else {
        // For Android 12+, you would need to handle runtime permissions
        print("This device is running Android 12 or higher.");
      }
    }
  }

  Future<void> connectToDevice() async {
    try {
      // Start scanning for devices
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

      // Listen for scan results
      scanSubscription = FlutterBluePlus.scanResults.listen((results) async {
        for (ScanResult result in results) {
          developer.log(
            "Device found: ${result.device.name} (${result.device.remoteId})",
          );

          if (result.device.name == "Nano33BLE_LED") {
            developer.log('Found target device: ${result.device.name}');
            targetDevice = result.device;

            // Stop scanning and connect to the target device
            await FlutterBluePlus.stopScan();
            await connectToTargetDevice();
            break;
          }
        }
      });
    } catch (e) {
      developer.log('Error during scanning: $e');
    }
  }

  Future<void> connectToTargetDevice() async {
    if (targetDevice == null) return;

    try {
      final state = await targetDevice!.connectionState.first;
      if (state != BluetoothConnectionState.connected) {
        await targetDevice!.connect();
      }

      developer.log('Connected to ${targetDevice!.name}');

      // Discover services and find a writable characteristic
      List<BluetoothService> services = await targetDevice!.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.properties.write) {
            targetCharacteristic = characteristic;
            developer.log('Found writable characteristic');
            return;
          }
        }
      }
    } catch (e) {
      developer.log('Error during connection: $e');
    }
  }

  void sendCommand(String command) {
    if (targetCharacteristic != null) {
      targetCharacteristic!.write(utf8.encode(command), withoutResponse: true);
      developer.log('Command sent: $command');
    } else {
      developer.log('No writable characteristic found');
    }
  }

  @override
  void dispose() {
    scanSubscription?.cancel();
    targetDevice?.disconnect().catchError((e) {
      developer.log("Error while disconnecting: $e");
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 32.0, right: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/first_icon.png',
                  width: 325,
                  height: 325,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                Text(
                  'Ugens Tema',
                  style: AppTextStyles.heading,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 600,
                      child: const Divider(
                        color: Color(0xFFA5D6A7),
                        thickness: 3,
                        height: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Her kan du skrive en introduktion til ugens tema.',
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0, right: 100.0),
              child: ElevatedButton(
                onPressed: () {
                  sendCommand("1");
                  Navigator.pushNamed(context, '/tasks');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Mycolors.buttonColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadowColor: Colors.black.withOpacity(1),
                  elevation: 10,
                ),
                child: Text('Start', style: AppTextStyles.button),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
