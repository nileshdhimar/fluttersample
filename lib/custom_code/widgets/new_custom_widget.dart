// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

import 'package:barkoder_flutter/barkoder_flutter.dart';

class NewCustomWidget extends StatefulWidget {
  const NewCustomWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<NewCustomWidget> createState() => _NewCustomWidgetState();
}

class _NewCustomWidgetState extends State<NewCustomWidget>
    with WidgetsBindingObserver {
  late Barkoder _barkoder;

  bool _isScanningActive = false;
  String _barkoderVersion = '';

  String _resultValue = '';
  String _typeValue = '';
  String _extrasValue = '';
  Uint8List? _resultImage;
  Uint8List? _resultThumbnailImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      _barkoder.stopScanning();
      _updateState(null, false);
    }
  }

  void _onBarkoderViewCreated(barkoder) async {
    _barkoder = barkoder;

    String barkoderVersion = await _barkoder.getVersion;
    _setActiveBarcodeTypes();
    _setBarkoderSettings();

    // or use configuration object
    _barkoder.configureBarkoder(BarkoderConfig(
      imageResultEnabled: true,
      decoder: DekoderConfig(qr: BarcodeConfig(enabled: true)),
    ));

    if (!mounted) return;

    setState(() {
      _barkoderVersion = barkoderVersion;
    });
  }

  void _setActiveBarcodeTypes() {
    _barkoder.setBarcodeTypeEnabled(BarcodeType.qr, true);
    _barkoder.setBarcodeTypeEnabled(BarcodeType.ean13, true);
    _barkoder.setBarcodeTypeEnabled(BarcodeType.upcA, true);
  }

  void _setBarkoderSettings() {
    _barkoder.setImageResultEnabled(true);
    _barkoder.setLocationInImageResultEnabled(true);
    _barkoder.setRegionOfInterestVisible(true);
    _barkoder.setPinchToZoomEnabled(true);
    _barkoder.setRegionOfInterest(5, 5, 90, 90);
  }

  void _updateState(BarkoderResult? result, bool scanninIsActive) {
    if (!mounted) return;

    setState(() {
      _isScanningActive = scanninIsActive;

      if (result != null) {
        _resultValue = result.textualData;
        _typeValue = result.barcodeTypeName;
        _extrasValue = result.extra?.toString() ?? '';

        if (result.resultImageAsBase64 != null) {
          _resultImage =
              const Base64Decoder().convert(result.resultImageAsBase64!);
        } else {
          _resultImage = null;
        }

        if (result.resultThumbnailAsBase64 != null) {
          _resultThumbnailImage =
              const Base64Decoder().convert(result.resultThumbnailAsBase64!);
        } else {
          _resultThumbnailImage = null;
        }
      } else {
        _resultValue = '';
        _typeValue = '';
        _extrasValue = '';
        _resultImage = null;
        _resultThumbnailImage = null;
      }
    });
  }

  void _scanPressed() {
    if (_isScanningActive) {
      _barkoder.stopScanning();
    } else {
      _barkoder.startScanning((result) {
        _updateState(result, false);
      });
    }

    _updateState(null, !_isScanningActive);
  }

  void _showFullResult() {
    if (_resultValue != '') {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Result'),
          content: Text(_resultValue),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF0022),
        title: Text('Barkoder Sample (v$_barkoderVersion)'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Stack(children: <Widget>[
            const Align(
                alignment: Alignment.center,
                child: Text('Press the button to start scanning',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 20))),
            if (_resultImage != null)
              Align(
                  alignment: Alignment.center,
                  child: Image.memory(_resultImage!)),
            BarkoderView(
                licenseKey:
                    'PEmBIohr9EZXgCkySoetbwP4gvOfMcGzgxKPL2X6uqPDhKvwspOK7mou0RLyZm20zu9rcxCQX26sKKFzJSF7BSr12fgPVTNv8dFg1nrNE5_08236uYDrkkfEWI6AAVPZKfjxGXzwaQg6PXiGNPwo3DhF0NZYJSbYIFp6NqgsQlE3By-Q7BOCyHYRgWU0o_yMuUf387nNZonExibwIFFHnR-Patp3mA6hxZFZUaByEwArJndbBzwEKAqNIMdkDAglu69bRa_yq_cvOa90yDLDWzGCb2HZYwTSxVMQ58cZo93FxzyUtnPgozk30Q9L7dMI',
                onBarkoderViewCreated: _onBarkoderViewCreated),
          ])),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _showFullResult,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      Expanded(
                          child: Row(children: [
                        if (_resultThumbnailImage != null)
                          Align(
                              alignment: Alignment.topLeft,
                              child: Image.memory(
                                _resultThumbnailImage!,
                                height: 450,
                                width: 250,
                              )),
                      ])),
                    ],
                  )))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: _isScanningActive ? 'Stop scan' : 'Start scan',
        onPressed: _scanPressed,
        backgroundColor: _isScanningActive ? Colors.red : Colors.black,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
