
import 'dart:io';
import 'dart:typed_data';

import 'package:dating/common/textstyles.dart';
import 'package:dating/tool_widget_custom/popup_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bloc/bloc_profile/upload_image_bloc.dart';
import '../theme/theme_color.dart';

class AccessPhotoGallery {
  BuildContext context;
  final ImagePicker picker = ImagePicker();
  List<File> imageUpload = [];
  AccessPhotoGallery(this.context);

  Future<void> selectImage(int? index) async {
    if (await _requestPermission(Permission.storage)) {
      try {
        if(context.mounted) {
          context.read<UploadImageBloc>().add(UploadImageEvent(isLoad: true));
        }
        final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
        if (pickedFile != null) {
          Uint8List compressedImage = await compute(compressImage, await File(pickedFile.path).readAsBytes());

          final compressedFile = File(pickedFile.path)
            ..writeAsBytesSync(compressedImage);

          if (index != null && index < imageUpload.length) {
            imageUpload[index] = compressedFile;
          } else {
            imageUpload.add(compressedFile);
          }

          if (context.mounted) {
            context.read<UploadImageBloc>().add(UploadImageEvent(imageUpload: imageUpload, isLoad: false));
          }
        }
      } catch (e) {
        if (context.mounted) {
          context.read<UploadImageBloc>().add(UploadImageEvent(isLoad: false));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error when selecting photo'),
            ),
          );
        }
      }
    } else {
      if (context.mounted) {
        PopupCustom.showPopup(context, textContent: "Permission denied, go to settings?", () async {
          await openAppSettings();
        });
      }
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }
  static Uint8List compressImage(Uint8List imageData) {
    final image = img.decodeImage(imageData);
    if (image != null) {
      return Uint8List.fromList(img.encodeJpg(image, quality: 50));
    }
    return imageData;
  }
}
