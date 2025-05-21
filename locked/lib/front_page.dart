import 'package:flutter/material.dart';
import 'package:locked/data/tasks.dart';
import 'package:locked/styles/colors.dart';
import 'package:locked/fonts/font.dart';
import 'package:locked/bluetooth.dart';


///The FrontPage widget is the first screen that the user sees when they open the app.
///Displays the selected theme and a button to start the task sequence.
class FrontPage extends StatefulWidget {
  final BluetoothConnection bluetoothConnection;
  final int themeIndex; //Index to determine the selected theme from [taskCollections].

  const FrontPage({
    super.key,
    required this.bluetoothConnection,
    required this.themeIndex,
  });

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Main context of the page
          Padding(
            padding: const EdgeInsets.only(top: 90.0, left: 32.0, right: 32.0),
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
                
                //Theme title from the taskCollections list
                Text(
                  taskCollections[widget.themeIndex].theme,
                  style: AppTextStyles.heading,
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 10),
                
                // Visual divider under the title
                const Divider(
                  color: Color(0xFFA5D6A7),
                  thickness: 3,
                  height: 20,
                ),
              ],
            ),
          ),
          
          // Bottom-right aligned "Start" button
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0, right: 100.0),
              child: ElevatedButton(
                // Sends a Bluetooth command to Arduino and navigates to the task page
                onPressed: () async {
                  await widget.bluetoothConnection.sendCommand("1");
                  
                  Navigator.pushNamed(
                    context,
                    '/tasks',
                    arguments: {
                      'themeIndex': widget.themeIndex,
                    }, // Pass themeIndex
                  );
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
