import 'package:camera/camera.dart';
import 'package:citizens/pages/login/loginPagesV2.dart';
import 'package:citizens/provider/faceAuth/faceAuthLoginProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FaceAuthLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FaceAuthLoginProvider _faceAuthProvider = FaceAuthLoginProvider();
    _faceAuthProvider.init(context);
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Icon(Icons.arrow_back_ios)),
          title: const Text('Face Authentication'),
        ),
        body: ChangeNotifierProvider(
          create: (_) => _faceAuthProvider,
          child: Consumer<FaceAuthLoginProvider>(
              builder: (context, faceAuthProvider, _) {
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 32),
                              )
                      ],
                    ),
            );
          }),
        ),
      ),
    );
  }

  Future<bool> onWillPop(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
    return Future.value(true);
  }
}
