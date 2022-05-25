import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool textScanning = false;
  bool textScanningTwo = false;

  XFile? imageFile;
  XFile? imageFileTwo;

  String scannedText = "";
  String scannedTextTwo = "";

  String pagarTotal = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Reconociento De Mediciones"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey[300]!,
                  ),
                if (imageFile != null) Image.file(File(imageFile!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.grey,
                          shadowColor: Colors.grey[400],
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.image,
                                size: 30,
                              ),
                              Text(
                                "Galeria",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                Text(
                                  "Foto",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    scannedText,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                if (textScanningTwo) const CircularProgressIndicator(),
                if (!textScanningTwo && imageFileTwo == null)
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey[300]!,
                  ),
                if (imageFileTwo != null) Image.file(File(imageFileTwo!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.grey,
                          shadowColor: Colors.grey[400],
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                        onPressed: () {
                          getImageTwo(ImageSource.gallery);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.image,
                                size: 30,
                              ),
                              Text(
                                "Galeria",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImageTwo(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                Text(
                                  "Foto",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "Total a pagar: " + result(),
                    //scannedTextTwo,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Ha ocurrido un error";
      setState(() {});
    }
  }

  void getImageTwo(ImageSource sourceTwo) async {
    try {
      final pickedImageTwo = await ImagePicker().pickImage(source: sourceTwo);
      if (pickedImageTwo != null) {
        textScanningTwo = true;
        imageFileTwo = pickedImageTwo;
        setState(() {});
        getRecognisedTextTwo(pickedImageTwo);
      }
    } catch (e) {
      textScanningTwo = false;
      imageFileTwo = null;
      scannedTextTwo = "Ha ocurrido un error";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text;
        if (scannedText.contains('O') ||
            scannedText.contains('P') ||
            scannedText.contains('Q')) {
          var result = '';
          result = scannedText.replaceAll('O', '0');
          result = result.replaceAll('P', '0');
          result = result.replaceAll('Q', '0');
          var to = result.substring(result.length - 4);
          scannedText = to;
        }
        var tu = scannedText.substring(scannedText.length - 4);
        scannedText = tu;
      }
    }
    textScanning = false;
    setState(() {});
  }

  void getRecognisedTextTwo(XFile imageTwo) async {
    final inputImageTwo = InputImage.fromFilePath(imageTwo.path);
    final textDetectorTwo = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedTextTwo =
        await textDetectorTwo.processImage(inputImageTwo);
    await textDetectorTwo.close();
    scannedTextTwo = "";
    for (TextBlock block in recognisedTextTwo.blocks) {
      for (TextLine line in block.lines) {
        scannedTextTwo = scannedTextTwo + line.text;
        if (scannedTextTwo.contains('O') ||
            scannedTextTwo.contains('P') ||
            scannedTextTwo.contains('Q')) {
          var resultTwo = '';
          resultTwo = scannedTextTwo.replaceAll('O', '0');
          resultTwo = resultTwo.replaceAll('P', '0');
          resultTwo = resultTwo.replaceAll('Q', '0');
          var toTwo = resultTwo.substring(resultTwo.length - 4);
          scannedTextTwo = toTwo;
        }
        var tuTwo = scannedTextTwo.substring(scannedTextTwo.length - 4);
        scannedTextTwo = tuTwo;
      }
    }
    textScanningTwo = false;
    setState(() {});
  }

  result() {
    if (scannedText == "" || scannedTextTwo == "") {
      return "0";
    } else {
      var firstLecture = int.parse(scannedText);
      var secondLecture = int.parse(scannedTextTwo);
      var operation = secondLecture - firstLecture;
      var pagar = operation * 1043;
      pagarTotal = "";
      return pagarTotal = pagar.toString();
    }

    //scannedText;
    //scannedTextTwo;
  }

  @override
  void initState() {
    super.initState();
  }
}
