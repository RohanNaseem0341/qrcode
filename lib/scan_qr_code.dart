import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  String qrResult = 'Scanned Data Will appear here';
  final MobileScannerController _controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Qr Code Scanner")),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: MobileScanner(
              controller: _controller,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  final value = barcodes.first.rawValue ?? '';
                  if (value.isNotEmpty) {
                    setState(() {
                      qrResult = value;
                    });
                  }
                }
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(qrResult, style: TextStyle(color: Colors.black)),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _controller.start(),
                        child: Text('Start'),
                      ),
                      SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => _controller.stop(),
                        child: Text('Stop'),
                      ),
                      SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => _controller.toggleTorch(),
                        child: Text('Torch'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
