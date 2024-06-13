
import 'dart:io';
import 'dart:typed_data';

import 'package:dating/common/textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bloc/bloc_profile/upload_image_bloc.dart';
import '../theme/theme_color.dart';

// class AccessPhotoGallery {
//   BuildContext context;
//   final ImagePicker picker = ImagePicker();
//   List<File> imageUpload = [];
//   AccessPhotoGallery(this.context);
//
//   Future<void> selectImage(int? index) async {
//     if (await _requestPermission(Permission.storage)) {
//       try {
//         final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 1);
//         if (pickedFile != null) {
//           if (index != null && index < imageUpload.length) {
//             imageUpload[index] = File(pickedFile.path);
//           } else {
//             imageUpload.add(File(pickedFile.path));
//           }
//           if (context.mounted) {
//             context.read<UploadImageBloc>().add(UploadImageEvent(imageUpload));
//           }
//         }
//       } catch (e) {
//         if(context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('error when selecting photo'),
//             ),
//           );
//         }
//       }
//     } else {
//       if(context.mounted) {
//         showCupertinoDialog(
//             context: context,
//             builder: (BuildContext context) => CupertinoAlertDialog(
//               title: const Text("Message"),
//               content: const Text("Permission denied, go to settings?"),
//               actions: <Widget>[
//                 CupertinoDialogAction(
//                   isDefaultAction: true,
//                   child: Text('yes', style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor).bold),
//                   onPressed: () async {
//                     Navigator.pop(context);
//                     await openAppSettings();
//                   },
//                 ),
//                 CupertinoDialogAction(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text("No", style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor)),
//                 )
//               ],
//             )
//         );
//       }
//     }
//   }
//
//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       final result = await Permission.storage.request();
//       return result == PermissionStatus.granted;
//     }
//   }
//
//   Uint8List compressImage(Uint8List imageData) {
//     final image = img.decodeImage(imageData);
//     if (image != null) {
//       return Uint8List.fromList(img.encodeJpg(image, quality: 50));
//     }
//     return imageData;
//   }
//
//
// }

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
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text("Message"),
            content: const Text("Permission denied, go to settings?"),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Yes', style: TextStyle(color: ThemeColor.blueColor, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  Navigator.pop(context);
                  await openAppSettings();
                },
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child: const Text("No", style: TextStyle(color: ThemeColor.blueColor)),
              )
            ],
          ),
        );
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

  // Hàm nén hình ảnh chạy trên isolate riêng
  static Uint8List compressImage(Uint8List imageData) {
    final image = img.decodeImage(imageData);
    if (image != null) {
      return Uint8List.fromList(img.encodeJpg(image, quality: 50));
    }
    return imageData;
  }
}
