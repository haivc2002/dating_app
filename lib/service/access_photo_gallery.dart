
import 'dart:io';

import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/controller/profile_controller/update_model.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/popup_custom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bloc/bloc_profile/edit_bloc.dart';
import '../common/global.dart';
import '../model/model_info_user.dart';

class AccessPhotoGallery {
  BuildContext context;
  final ImagePicker picker = ImagePicker();
  List<File> imageUpload = [];
  AccessPhotoGallery(this.context);

  Future<void> selectImage(int? index) async {
    if (await _requestPermission(Permission.storage)) {
      try {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
        if (pickedFile != null) {
          final file = File(pickedFile.path);
          if (await file.exists()) {
            final imageBytes = await file.readAsBytes();

            final compressedFile = File(pickedFile.path)
              ..writeAsBytesSync(imageBytes);

            if (context.mounted) {
              final currentImages = context.read<EditBloc>().state.imageUpload ?? [];
              if (index != null && index < currentImages.length) {
                currentImages[index] = compressedFile;
              } else {
                currentImages.add(compressedFile);
              }
              context.read<EditBloc>().add(EditEvent(imageUpload: currentImages));
            }
          }
        }
      } catch (e) {
        print(e);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error when selecting photo'),
            ),
          );
        }
      }
    } else {
      if (context.mounted) {
        PopupCustom.showPopup(
          context,
          textContent: "Permission denied, go to settings?",
          listAction: [
            Text('No', style: TextStyles.defaultStyle.setColor(ThemeColor.redColor)),
            Text('Yes', style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor)),
          ],
          listOnPress: [
                () {},
                () async => await openAppSettings(),
          ],
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

  void remove() {
    imageUpload = List.from(context.read<EditBloc>().state.imageUpload ?? []);
    if (imageUpload.isNotEmpty) {
      imageUpload.removeLast();
      context.read<EditBloc>().add(EditEvent(imageUpload: imageUpload));
    }
  }

  Uint8List compressImage(Uint8List imageData) {
    final image = img.decodeImage(imageData);
    if (image != null) {
      return Uint8List.fromList(img.encodeJpg(image, quality: 50));
    }
    return imageData;
  }

  Future<void> updateImage(int index) async {
    if (await _requestPermission(Permission.storage)) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final rotatedImage = await FlutterExifRotation.rotateImage(path: pickedFile.path);
        final compressedImage = compressImage(await rotatedImage.readAsBytes());
        final compressedFile = File(pickedFile.path)..writeAsBytesSync(compressedImage);
        onSuccess(compressedFile, index);
      } else {
        if(context.mounted) {
          PopupCustom.showPopup(
            context,
            content: const Text('File null'),
            listOnPress: [()=> Navigator.pop(context)],
            listAction: [Text('Ok', style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor)),]
          );
        }
      }
    } else {
      onError();
    }
  }

  Future<void> deleteImage(int index) async {
    final state = context.read<HomeBloc>().state;
    List<ListImage> imageUpload = List.from(state.info?.listImage ?? []);
    if (index < imageUpload.length) {
      imageUpload.removeAt(index);
      UpdateModel.updateModelInfo(
        state.info!,
        listImage: imageUpload,
      );

      if (context.mounted) {
        context.read<HomeBloc>().add(HomeEvent(info: UpdateModel.modelInfoUser));
        Navigator.pop(context);
      }
    }
  }

  void onSuccess(compressedFile, int index) async {
    final state = context.read<HomeBloc>().state;
    List<ListImage> imageUpload = List.from(state.info?.listImage ?? []);

    String imagePath = compressedFile.path;

    if (index < imageUpload.length) {
      imageUpload[index] = ListImage(id: imageUpload[index].id, idUser: imageUpload[index].idUser, image: imagePath);
    } else {
      imageUpload.add(ListImage(id: null, idUser: Global.getInt('idUser'), image: imagePath));
    }
    UpdateModel.updateModelInfo(
      state.info!,
      listImage: imageUpload,
    );

    if (context.mounted) {
      context.read<HomeBloc>().add(HomeEvent(info: UpdateModel.modelInfoUser));
    }
  }

  void onError() {
    PopupCustom.showPopup(
      context,
      textContent: "Permission denied, go to settings?",
      listAction: [
        Text('No', style: TextStyles.defaultStyle.setColor(ThemeColor.redColor)),
        Text('Yes', style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor)),
      ],
      listOnPress: [
        () => Navigator.pop(context),
        () async => await openAppSettings(),
      ],
    );
  }
}
