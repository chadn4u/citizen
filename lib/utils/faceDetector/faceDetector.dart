import 'package:camera/camera.dart';
import 'package:citizens/provider/faceAuth/faceAuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraPreviewScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FaceAuthProvider _faceAuthProvider = FaceAuthProvider();
    _faceAuthProvider.init();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ML Vision Example'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => _faceAuthProvider,
        child:
            Consumer<FaceAuthProvider>(builder: (context, faceAuthProvider, _) {
          return Container(
            constraints: const BoxConstraints.expand(),
            child: faceAuthProvider.camera == null
                ? const Center(
                    child: Text(
                      'Initializing Camera...',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 30.0,
                      ),
                    ),
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      CameraPreview(faceAuthProvider.camera),
                      faceAuthProvider.buildResultWidget,
                      (faceAuthProvider.result.isEmpty)
                          ? Container()
                          : Text(
                              faceAuthProvider.result,
                              style: TextStyle(color: Colors.red, fontSize: 32),
                            )
                    ],
                  ),
          );
        }),
      ),
    );
  }
}
