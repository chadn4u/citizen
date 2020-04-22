import 'package:flutter/material.dart';
import 'package:ota_update/ota_update.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePages extends StatefulWidget {
  final String updateLink;

  const UpdatePages({Key key, this.updateLink}) : super(key: key);

  @override
  _UpdatePagesState createState() => _UpdatePagesState();
}

class _UpdatePagesState extends State<UpdatePages> {
  OtaEvent otaEvent;

  @override
  Widget build(BuildContext context) {
    if (otaEvent == null) {
      return Scaffold(
        body: Container(
          child: Center(child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('New Update Available',style: TextStyle(color: Colors.red),),
                Text('Click link below, if download not started'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Text('Link',style: TextStyle(color: Colors.blue,fontSize: 32),),
                    onTap: ()=> launch(widget.updateLink),
                  ),
                )
              ],
            ),
          )),
        ),
      );
    }
    print(widget.updateLink);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Update'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Status: ${getStatus(otaEvent.status)} ',
              style: TextStyle(fontSize: 24),
            ),
            otaEvent.status == OtaStatus.DOWNLOADING
                ? Text(
                    '${otaEvent.value} %',
                    style: TextStyle(fontSize: 24),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tryOtaUpdate();
  }

  String getStatus(OtaStatus otaStatus) {
    switch (otaStatus) {
      case OtaStatus.ALREADY_RUNNING_ERROR:
        return "Already Running Error";
        break;
      case OtaStatus.DOWNLOAD_ERROR:
        return "Download Error";
        break;
      case OtaStatus.DOWNLOADING:
        return "Downloading";
        break;
      case OtaStatus.INSTALLING:
        return "Installing";
        break;
      case OtaStatus.INTERNAL_ERROR:
        return "Internal Error";
        break;
      case OtaStatus.PERMISSION_NOT_GRANTED_ERROR:
        return "Permission not Granted";
        break;
      default:
        return "Unknown Status";
    }
  }

  Future<void> tryOtaUpdate() async {
    try {
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
      OtaUpdate()
          .execute(widget.updateLink, destinationFilename: 'Citizens.apk')
          .listen(
        (OtaEvent event) {
          setState(() => otaEvent = event);
          print(otaEvent);
        },
      );
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }
}
