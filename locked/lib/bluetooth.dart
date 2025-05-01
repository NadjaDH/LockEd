import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:async';

class BluetoothConnection {
  BluetoothDevice? targetDevice;
  BluetoothCharacteristic? targetCharacteristic;
  StreamSubscription<List<ScanResult>>? scanSubscription;

  Future<void> initializeBluetooth() async {
    await connectToDevice();
  }

  Future<void> connectToDevice() async {
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));

      scanSubscription = FlutterBluePlus.scanResults.listen((results) async {
        for (ScanResult result in results) {
          developer.log(
            "Device found: ${result.device.name} (${result.device.remoteId})",
          );

          if (result.device.name == "Nano33BLE_LED") {
            developer.log('Found target device: ${result.device.name}');
            targetDevice = result.device;

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

      List<BluetoothService> services = await targetDevice!.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.properties.write ||
              characteristic.properties.writeWithoutResponse) {
            targetCharacteristic = characteristic;
            developer.log('Found writable characteristic');
            return;
          }
        }
      }
      developer.log('No writable characteristic found');
    } catch (e) {
      developer.log('Error during connection: $e');
    }
  }

  Future<void> sendCommand(String command) async {
    if (targetDevice == null) {
      developer.log('No target device connected');
      return;
    }

    try {
      final state = await targetDevice!.connectionState.first;
      if (state != BluetoothConnectionState.connected) {
        developer.log('Device is not connected');
        return;
      }

      if (targetCharacteristic != null) {
        if (targetCharacteristic!.properties.writeWithoutResponse) {
          await targetCharacteristic!.write(
            utf8.encode(command),
            withoutResponse: true,
          );
          developer.log('Command sent with WRITE_NO_RESPONSE: $command');
        } else if (targetCharacteristic!.properties.write) {
          await targetCharacteristic!.write(
            utf8.encode(command),
            withoutResponse: false,
          );
          developer.log('Command sent with WRITE: $command');
        } else {
          developer.log('Characteristic does not support writing');
        }
      } else {
        developer.log('No writable characteristic found');
      }
    } catch (e) {
      developer.log('Error sending command: $e');
    }
  }

  void dispose() {
    scanSubscription?.cancel();
    targetDevice?.disconnect().catchError((e) {
      developer.log("Error while disconnecting: $e");
    });
  }
}
