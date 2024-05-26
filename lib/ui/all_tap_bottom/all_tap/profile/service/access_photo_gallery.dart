
import 'dart:io';

import 'package:dating/common/textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../theme/theme_color.dart';
import 'bloc/upload_image_bloc.dart';

class AccessPhotoGallery {
  BuildContext context;
  final ImagePicker picker = ImagePicker();
  List<File> imageUpload = [];
  AccessPhotoGallery(this.context);

  Future<void> selectImage(int? index) async {
    if (await _requestPermission(Permission.storage)) {
      try {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          if (index != null && index < imageUpload.length) {
            imageUpload[index] = File(pickedFile.path);
          } else {
            imageUpload.add(File(pickedFile.path));
          }
          if (context.mounted) {
            context.read<UploadImageBloc>().add(UploadImageEvent(imageUpload));
          }
        }
      } catch (e) {
        if(context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('error when selecting photo'),
            ),
          );
        }
      }
    } else {
      if(context.mounted) {
        showCupertinoDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text("Message"),
              content: const Text("Permission denied, go to settings?"),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('yes', style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor).bold),
                  onPressed: () async {
                    Navigator.pop(context);
                    await openAppSettings();
                  },
                ),
                CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context),
                  child: Text("No", style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor)),
                )
              ],
            )
        );
      }
    }
  }


  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    }
  }

}