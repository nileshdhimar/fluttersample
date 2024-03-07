// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import 'package:barkoder_flutter/barkoder_flutter.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'index.dart'; // Imports other custom widgets

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' show Platform;

class ScanbarKoder extends StatefulWidget {
  const ScanbarKoder({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ScanbarKoder> createState() => new _ScanbarKoderState();
}

class _ScanbarKoderState extends State<ScanbarKoder> {
  static List<String> brCodeList = [];
  static List<String> newbrCodeList = [];

  // final _model = _ScanSerialNumberState();
  final TextEditingController serialNumberController = TextEditingController();
  static String serialNumber = '';
  late Barkoder _barkoder;
  static bool _isScanningActive = false;

  //BarkoderViewController _controller;
  static bool _isScanning = false;
  static String _resultValue = '';

  @override
  void dispose() {
    serialNumberController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

//handle add click button
  void handleAddButtonClick() {
    String serialNo =
        serialNumberController.text; // Get the value from the TextFormField
    if (!brCodeList.contains(serialNo)) {
      setState(() {
        if (serialNo.isNotEmpty) {
          brCodeList.add(serialNo); // Add the value to the list
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Please Enter Serial Number'),
            backgroundColor: Colors.red,
          ));
        }
      });
      serialNumberController.clear(); // Clear the text field
    } else {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: 'Error!!',
              text: 'Serial No Already Exist !!'));
    }
  }

  // Handle the scanned QR code
  void handleScannedCode(String? barcode) {
    setState(() {
      if (!brCodeList.contains(barcode!)) {
        if (barcode != "-1" && barcode != "") {
          brCodeList.add(barcode);
          // showToast("Barcode scanned: ${brCodeList.length}");
          HapticFeedback.vibrate();

          /* if (!isAddSerialNoINList) {
            brCodeList.clear();
          } else {}*/
        }
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          // Generated code for this Column Widget...
          SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //serial no
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: serialNumberController,
                                onChanged: (value) {
                                  setState(() {
                                    serialNumber = value;
                                  });
                                },
                                //  controller: _model.serialNumberController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  //contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust the vertical padding

                                  hintText: 'Serial No',
                                  hintStyle:
                                      FlutterFlowTheme.of(context).bodySmall,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .txtBoxBdr,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'DM Sans',
                                      fontSize: 14,
                                    ),
                                maxLines: null,
                                // validator: _model
                                // .serialNumberControllerValidator
                                //   .asValidator(context),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 5, 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        handleAddButtonClick();
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .buttonIcon,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print('QR Code button pressed ...');
                                      // barcodeScanStream();

                                      if (Platform.isAndroid ||
                                          Platform.isIOS) {
                                        // Custom UI or action goes here

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BarcodeScannerScreen(),
                                          ),
                                        );

                                        /*     Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BarkoderView(
                                                licenseKey:
                                                    'PEmBIohr9EZXgCkySoetbwP4gvOfMcGzgxKPL2X6uqPDhKvwspOK7mou0RLyZm20zu9rcxCQX26sKKFzJSF7BSr12fgPVTNv8dFg1nrNE5_08236uYDrkkfEWI6AAVPZKfjxGXzwaQg6PXiGNPwo3DhF0NZYJSbYIFp6NqgsQlE3By-Q7BOCyHYRgWU0o_yMuUf387nNZonExibwIFFHnR-Patp3mA6hxZFZUaByEwArJndbBzwEKAqNIMdkDAglu69bRa_yq_cvOa90yDLDWzGCb2HZYwTSxVMQ58cZo93FxzyUtnPgozk30Q9L7dMI',
                                                onBarkoderViewCreated:
                                                    _onBarkoderViewCreated),
                                          ),
                                        );*/
                                      } else {}
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .buttonIcon,
                                      ),
                                      child: Icon(
                                        Icons.qr_code_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //SCAN NO

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Serial No.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              'Scan Count: ${brCodeList.length}',
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Action',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: FlutterFlowTheme.of(context).accent4,
                      ),

                      //listview
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double screenHeight =
                              MediaQuery.of(context).size.height;
                          double remainingHeight = screenHeight *
                              0.55; // Adjust the percentage as needed

                          return SingleChildScrollView(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                            child: SizedBox(
                              height: remainingHeight,
                              child: Scrollbar(
                                //  isAlwaysShown: true,
                                child: ListView.builder(
                                  itemCount: brCodeList.length,
                                  itemExtent: 35,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Row(
                                        children: [
                                          Text(
                                            '${index + 1}.',
                                            style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              brCodeList[index],
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                brCodeList.removeAt(index);
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                color: Color(0xFFF8D7DA),
                                              ),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors
                                                    .red, // Replace with desired color
                                                size: 19,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      //  ========

                      //submit button

                      //   =========
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  late Barkoder _barkoder;
  bool _isScanningActive = false;
  String scannedBarcode = '';
  String _resultValue = '';
  int scan_count = 0;

  @override
  void initState() {
    super.initState();
    scan_count = _ScanbarKoderState.brCodeList.length;

    // Start scanning automatically when the widget is loaded
  }

  @override
  void dispose() {
    // Stop scanning when the widget is disposed
    //  _barkoder.stopScanning();
    super.dispose();
  }

  //implement barkoder methods
  void _onBarkoderViewCreated(barkoder) {
    _barkoder = barkoder;

    _barkoder.setBarcodeTypeEnabled(BarcodeType.qr, true);
    _barkoder.setRegionOfInterestVisible(true);
    _barkoder.setCloseSessionOnResultEnabled(false);
    _barkoder.setImageResultEnabled(false);
    _barkoder.setDuplicatesDelayMs(0);
  }

  void _updateState(BarkoderResult? result, bool scanninIsActive) {
    setState(() {
      _isScanningActive = scanninIsActive;

      if (result != null) {
        _resultValue = result.textualData;

        //  _ScanbarKoderState.handleScannedCode(_resultValue);

        if (!_ScanbarKoderState.brCodeList.contains(_resultValue!)) {
          if (_resultValue != "-1" && _resultValue != "") {
            _ScanbarKoderState.brCodeList.add(_resultValue);
            scan_count = _ScanbarKoderState.brCodeList.length;
            //  showToast( "Barcode scanned: ${_ScanbarKoderState.brCodeList.length}");
            //_scanPressed();
          }
        } else {
          // _barkoder.stopScanning();
        }
      } else {
        _resultValue = '';
      }
    });
  }

  // Callback function to get a reference to the BarkoderViewController
  void _scanPressed() {
    if (_isScanningActive) {
      // _updateState(null, !_isScanningActive);

      _barkoder.stopScanning();
    } else {
      _barkoder.startScanning((result) {
        _updateState(result, true);
      });
    }

    _updateState(null, !_isScanningActive);
  }

  //show toast for scan count
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void onSubmit() {
    setState(() {
      if (_isScanningActive) {
        _isScanningActive = false;
        _barkoder.stopScanning();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ScanbarKoder()),
        );
        //  Navigator.pop(context, true);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ScanbarKoder()),
        );
        //  Navigator.pop(context, true);
      }
    });
  }

  void onCancel() {
    setState(() {
      if (_isScanningActive) {
        _isScanningActive = false;
        _barkoder.stopScanning();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ScanbarKoder()),
        );

        //  Navigator.pop(context, true);
      } else {
        //  Navigator.pop(context, true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          // color: Colors.transparent,
          height: double.maxFinite,
          child: new Stack(
            //alignment:new Alignment(x, y)
            children: [
              //-------start-----------

              new Positioned(
                top: 30.0,
                //left: 20.0,
                // right: 20.0,

                //-----start row

                child: new Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.indigo,
                  //decoration: new BoxDecoration(color: Colors.lightBlueAccent),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new InkWell(
                          onTap: () {
                            onCancel();

                            //   Navigator.pop(context, true);
                          },
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      onCancel();
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.transparent,
                                            width: 1),
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        new InkWell(
                          onTap: () {
                            //  onSubmit();

                            // Navigator.pop(context, true);
                          },
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // handleAddButtonClick();
                                    },
                                    child: Container(
                                      width: 140,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                            color: Colors.transparent,
                                            width: 1),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Count : ${scan_count} / 10',
                                          //  textDirection: TextDirection.ltr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              decoration: TextDecoration.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ),

              new Positioned(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // BarkoderView widget integrated into the UI

// BarkoderView widget integrated into the UI
                    // BarkoderView widget integrated into the UI

                    Container(
                      width: 500,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InputDecorator(
                          decoration: InputDecoration(
                              labelText: 'barkoder'.toUpperCase(),
                              // floatingLabelAlignment: FloatingLabelAlignment.start,
                              labelStyle: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white),
                              )),
                          child: BarkoderView(
                              licenseKey:
                                  'PEmBIohr9EZXgCkySoetbwP4gvOfMcGzgxKPL2X6uqPDhKvwspOK7mou0RLyZm20zu9rcxCQX26sKKFzJSF7BSr12fgPVTNv8dFg1nrNE5_08236uYDrkkfEWI6AAVPZKfjxGXzwaQg6PXiGNPwo3DhF0NZYJSbYIFp6NqgsQlE3By-Q7BOCyHYRgWU0o_yMuUf387nNZonExibwIFFHnR-Patp3mA6hxZFZUaByEwArJndbBzwEKAqNIMdkDAglu69bRa_yq_cvOa90yDLDWzGCb2HZYwTSxVMQ58cZo93FxzyUtnPgozk30Q9L7dMI',
                              onBarkoderViewCreated: _onBarkoderViewCreated),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              new Positioned(
                //top: 20.0,
                //left: 20.0,
                // right: 20.0,

                //-----start row
                child: new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: new Container(
                    margin: const EdgeInsets.fromLTRB(15, 20, 15, 30),
                    height: 50,
                    width: MediaQuery.of(context).size.width,

                    //decoration: new BoxDecoration(color: Colors.lightBlueAccent),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new InkWell(
                            onTap: () {
                              onCancel();

                              //   Navigator.pop(context, true);
                            },
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 5, 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        // handleAddButtonClick();
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 1),
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.flash_on_sharp,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new InkWell(
                            onTap: () {
                              onSubmit();

                              // Navigator.pop(context, true);
                            },
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 5, 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        _scanPressed();
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 1),
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.qr_code_scanner,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              )
              //------end coding-------------
              //------
              /*new Positioned(
                top: 20.0,
                //left: 20.0,
                // right: 20.0,

                //-----start row

                child: new Container(
                  decoration: new BoxDecoration(color: Colors.lightBlueAccent),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new InkWell(
                          onTap: () {
                            onCancel();

                            //   Navigator.pop(context, true);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none),
                          ),
                        ),
                        new InkWell(
                          onTap: () {
                            onSubmit();

                            // Navigator.pop(context, true);
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ]),
                ),
              ),*/

              //**********
              //........................
              /*new Positioned(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // BarkoderView widget integrated into the UI

// BarkoderView widget integrated into the UI
                    // BarkoderView widget integrated into the UI

                    Container(
                      width: 500,
                      height: 200,
                      child: InputDecorator(
                        decoration: InputDecoration(
                            labelText: 'Box',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: BarkoderView(
                            licenseKey:
                                'PEmBIohr9EZXgCkySoetbwP4gvOfMcGzgxKPL2X6uqPDhKvwspOK7mou0RLyZm20zu9rcxCQX26sKKFzJSF7BSr12fgPVTNv8dFg1nrNE5_08236uYDrkkfEWI6AAVPZKfjxGXzwaQg6PXiGNPwo3DhF0NZYJSbYIFp6NqgsQlE3By-Q7BOCyHYRgWU0o_yMuUf387nNZonExibwIFFHnR-Patp3mA6hxZFZUaByEwArJndbBzwEKAqNIMdkDAglu69bRa_yq_cvOa90yDLDWzGCb2HZYwTSxVMQ58cZo93FxzyUtnPgozk30Q9L7dMI',
                            onBarkoderViewCreated: _onBarkoderViewCreated),
                      ),
                    ),

                   

                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: _scanPressed,
                      child: Text('Start Scanning'),
                    ),
                  ],
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
