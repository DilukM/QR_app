import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String scannedData = ''; // Variable to hold the scanned data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Scanned Data:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            scannedData,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            // Added a button to simulate displaying scanned data elsewhere
            onPressed: () {
              _displayScannedData(context);
            },
            child: const Text('Mark Student Attendance'),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedData =
            scanData.code!; // Update scanned data when a QR code is scanned
      });
    });
  }

  void _displayScannedData(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Scanned Data'),
          content: Text(scannedData),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
