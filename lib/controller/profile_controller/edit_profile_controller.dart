import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/bottom_form_widget.dart';
import 'package:dating/tool_widget_custom/input_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../tool_widget_custom/item_card.dart';

class EditProfileController {
  BuildContext context;
  EditProfileController(this.context);

  void popupName() {
    BottomSheetCustom.showCustomBottomSheet(
      context,
      height: 300.w,
      backgroundColor: ThemeColor.whiteColor.withOpacity(0.5),
      Column(
        children: [
          InputCustom(),
          ItemCard(
            // colorCard: Colors.transparent,
            listWidget: [
              Text('data'),
              Text('data'),
            ],
          ),
        ],
      )
    );
  }
}