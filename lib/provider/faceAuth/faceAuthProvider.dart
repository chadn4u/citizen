import 'dart:async';
import 'dart:io';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:citizens/utils/faceDetector/detector_painters.dart';
import 'package:citizens/utils/faceDetector/scannerUtils.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:ffi/ffi.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as imglib;
import 'package:tflite/tflite.dart';

typedef convert_func = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Int32, Int32, Int32, Int32);
typedef Convert = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, int, int, int, int);

class FaceAuthProvider with ChangeNotifier {
  final DynamicLibrary convertImageLib = Platform.isAndroid
      ? DynamicLibrary.open("libconvertImage.so")
      : DynamicLibrary.process();
  Convert conv;

  dynamic _scanResults;
  dynamic get scanResults => _scanResults;

  CameraController _camera;
  CameraController get camera => _camera;

  Detector _currentDetector = Detector.face;
  Detector get currentDetector => _currentDetector;
  // bool _isDetecting = false;
  String _localPath;
  String get localPath => _localPath;

  CameraImage _savedImage;
  CameraImage get savedImage => _savedImage;

  TargetPlatform _platform = TargetPlatform.android;
  TargetPlatform get platform => _platform;

  bool _isDetected = false;
  bool get isDetected => _isDetected;

  //TensorFlow
  List<dynamic> _recognitions;
  List<dynamic> get recognitions => _recognitions;

  int _imageHeight = 0;
  int get imageHeight => _imageHeight;
  int _imageWidth = 0;
  int get imageWidth => _imageWidth;

  StreamController<List<dynamic>> streamControllerMaskDetect =
      new StreamController();
  //
  CameraLensDirection _direction = CameraLensDirection.front;
  CameraLensDirection get direction => _direction;

  Widget _buildResultWidget = Container();
  Widget get buildResultWidget => _buildResultWidget;

  String _result = "";
  String get result => _result;

  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  //Exception Flag
  bool _isMasked = false;
  bool get isMasked => _isMasked;

  bool _isSmile = false;
  bool get isSmile => _isSmile;
  //

  final BarcodeDetector _barcodeDetector =
      FirebaseVision.instance.barcodeDetector();
  final FaceDetector _faceDetector = FirebaseVision.instance
      .faceDetector(FaceDetectorOptions(enableClassification: true));

  void init() {
    loadModel();
    _initializeCamera();
    conv = convertImageLib
        .lookup<NativeFunction<convert_func>>('convertImage')
        .asFunction<Convert>();
    streamControllerMaskDetect.stream.listen((event) {
      event.forEach((element) {
        if (element["label"] == '0 with_mask' && (element['confidence'] * 100) > 80 && isDetected) {
          _result = 'Mask Detected ${(element['confidence'] * 100).toStringAsFixed(0)}%';
          _isMasked = true;
        } else {
          _result = "";
          _isMasked = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _camera.dispose().then((_) {
      _barcodeDetector.close();
      _faceDetector.close();
    });
    streamControllerMaskDetect.sink;
    _currentDetector = null;
    super.dispose();
  }

  void loadModel() async {
    await Tflite.loadModel(
      model: "assets/images/model_unquant.tflite",
      labels: "assets/images/labels.txt",
    );
  }

  // void _toggleCameraDirection() async {
  //   if (_direction == CameraLensDirection.back) {
  //     _direction = CameraLensDirection.front;
  //   } else {
  //     _direction = CameraLensDirection.back;
  //   }

  //   await _camera.stopImageStream();
  //   await _camera.dispose();

  //   _camera = null;
  //   notifyListeners();

  //   _initializeCamera();
  // }

  void _initializeCamera() async {
    final CameraDescription description =
        await ScannerUtils.getCamera(_direction);
    _localPath =
        (await _findLocalPath()) + Platform.pathSeparator + 'citizens/';

    _camera = CameraController(
      description,
      defaultTargetPlatform == TargetPlatform.iOS
          ? ResolutionPreset.low
          : ResolutionPreset.low,
    );
    await _camera
        .initialize()
        .then((value) => _camera.startImageStream((CameraImage image) {
              _savedImage = image;
              // if (_isDetected) return;
              ScannerUtils.detect(
                image: image,
                detectInImage: _getDetectionMethod(),
                imageRotation: description.sensorOrientation,
              ).then(
                (dynamic results) {
                  if (_currentDetector == null) return;
                  if (results is List<Face>) {
                    if (results.length > 1) {
                      _result = "Multiple Face Detected";
                      notifyListeners();
                    } else {
                      Tflite.runModelOnFrame(
                        bytesList: image.planes.map(
                          (plane) {
                            return plane.bytes;
                          },
                        ).toList(),
                        threshold: 0.5,
                        rotation: 0,
                        imageHeight: image.height,
                        imageWidth: image.width,
                        numResults: 1,
                      ).then(
                        (recognitions) {
                          _recognitions = recognitions;
                          streamControllerMaskDetect.add(_recognitions);
                          _imageHeight = image.height;
                          _imageWidth = image.width;
                          // isDetecting = false;
                        },
                      );
                      _scanResults = results;
                      _buildResults();
                    }
                  }
                },
              );
            }));
    notifyListeners();
  }

  Future<String> _findLocalPath() async {
    final directory = platform == TargetPlatform.android
        ? await DownloadsPathProvider.downloadsDirectory
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<dynamic> Function(FirebaseVisionImage image) _getDetectionMethod() {
    if (_currentDetector == Detector.barcode)
      return _barcodeDetector.detectInImage;
    else if (_currentDetector == Detector.face)
      return _faceDetector.processImage;

    return null;
  }

  imglib.Image convertImage() {
    Stopwatch stopwatch = new Stopwatch()..start();
    // Allocate memory for the 3 planes of the image
    Pointer<Uint8> p = allocate(count: _savedImage.planes[0].bytes.length);
    Pointer<Uint8> p1 = allocate(count: _savedImage.planes[1].bytes.length);
    Pointer<Uint8> p2 = allocate(count: _savedImage.planes[2].bytes.length);

    // Assign the planes data to the pointers of the image
    Uint8List pointerList = p.asTypedList(_savedImage.planes[0].bytes.length);
    Uint8List pointerList1 = p1.asTypedList(_savedImage.planes[1].bytes.length);
    Uint8List pointerList2 = p2.asTypedList(_savedImage.planes[2].bytes.length);
    pointerList.setRange(
        0, _savedImage.planes[0].bytes.length, _savedImage.planes[0].bytes);
    pointerList1.setRange(
        0, _savedImage.planes[1].bytes.length, _savedImage.planes[1].bytes);
    pointerList2.setRange(
        0, _savedImage.planes[2].bytes.length, _savedImage.planes[2].bytes);

    // Call the convertImage function and convert the YUV to RGB
    Pointer<Uint32> imgP = conv(
        p,
        p1,
        p2,
        _savedImage.planes[1].bytesPerRow,
        _savedImage.planes[1].bytesPerPixel,
        _savedImage.width,
        _savedImage.height);
    // Get the pointer of the data returned from the function to a List
    List imgData = imgP.asTypedList((_savedImage.width * _savedImage.height));

    // Generate image from the converted data
    imglib.Image img =
        imglib.Image.fromBytes(_savedImage.height, _savedImage.width, imgData);
    print("4 =====> ${stopwatch.elapsedMilliseconds}");

    // Free the memory space allocated
    // from the planes and the converted data
    free(p);
    free(p1);
    free(p2);
    free(imgP);
    return img;
  }

  void _saveImage(imglib.Image uint8List) async {
    String filename = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    bool isDirExist = await Directory(_localPath).exists();
    if (!isDirExist) Directory(_localPath).create();
    String tempPath = _localPath + filename;
    File image = File(tempPath);
    bool isExist = await image.exists();
    if (isExist) await image.delete();
    File(tempPath).writeAsBytesSync(encodeJpg(uint8List),
        mode: FileMode.write, flush: true);
  }

  void _buildResults() {
    if (_scanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      _result = 'No results!';
      notifyListeners();
      return;
    }

    CustomPainter painter;

    final Size imageSize = Size(
      _camera.value.previewSize.height,
      _camera.value.previewSize.width,
    );

    switch (_currentDetector) {
      case Detector.barcode:
        if (_scanResults is! List<Barcode>) {
          _result = 'No results!';
          notifyListeners();
          return;
        }
        painter = BarcodeDetectorPainter(imageSize, _scanResults);
        break;
      case Detector.face:
        if (_scanResults is! List<Face>) {
          _result = 'No results!';
          notifyListeners();
          return;
        }
        for (Face face in _scanResults) {
          if (face.smilingProbability > 0.8) {
            _result = "Terima kasih telah tersenyum";
            notifyListeners();
          } else {
            _result = "";
            notifyListeners();
          }
        }
        if (!_isProcessing) takePicture();
        painter = FaceDetectorPainter(imageSize, _scanResults);
        break;
      default:
        assert(_currentDetector == Detector.text ||
            _currentDetector == Detector.cloudText);
        if (_scanResults is! VisionText) {
          _result = 'No results!';
          notifyListeners();
          return;
        }
    }
    _buildResultWidget = CustomPaint(
      painter: painter,
    );
    notifyListeners();
  }

  void takePicture() async {
    if (_scanResults is List<Face>) {
      for (Face face in _scanResults) {
        if (face.boundingBox == null)
          _isDetected = false;
        else {
          if (!_isProcessing) {
            _isDetected = true;
            _isProcessing = true;
            Future.delayed(Duration(seconds: 3), () {
              _saveImage(convertImage());
            });
          }
        }
      }
    }
  }
}
