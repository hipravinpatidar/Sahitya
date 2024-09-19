import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sahityadesign/model/chapters_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class ShareVerse extends ChangeNotifier {
  final ScreenshotController screenshotController = ScreenshotController();

  void shareCustomDesign(Verse verse) async {
    // Capture the widget as an image
    screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        final directory = await getTemporaryDirectory();
        final path = '${directory.path}/verse.png';
        final file = File(path)..writeAsBytesSync(image);

        // Share the image
        Share.shareFiles([path], text: "Check out this verse: ${verse.verseData!.verseData?.sanskrit ?? ''} \nListen here: ${verse.verseData!.audioUrl ?? ''}");
      }
    }).catchError((onError) {
      print(onError);
    });

    notifyListeners();
  }
}
