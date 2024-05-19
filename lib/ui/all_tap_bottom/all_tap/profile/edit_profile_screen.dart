import 'package:dating/theme/theme_color.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'editProfileScreen';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.backgroundScaffold,
    );
  }
}
