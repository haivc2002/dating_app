
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AccessPhotoGallery {
  final ImagePicker picker = ImagePicker();
  File? imageUpload;


  Future<void> selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // setState(() {
      //   _backgroundImage = File(pickedFile.path);
      // });


      //====> change to bloc patten
    }
  }

}