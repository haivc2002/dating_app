import 'package:dating/bloc/bloc_all_tap/get_location_bloc.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/bottom_sheet_custom.dart';
import 'package:dating/tool_widget_custom/input_custom.dart';
import 'package:dating/tool_widget_custom/popup_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../tool_widget_custom/item_card.dart';

class EditProfileController {
  BuildContext context;
  EditProfileController(this.context);

  // void popupName() {
  //   BottomSheetCustom.showCustomBottomSheet(
  //     context,
  //     height: 300.w,
  //     backgroundColor: ThemeColor.whiteColor.withOpacity(0.5),
  //     Column(
  //       children: [
  //         InputCustom(),
  //         ItemCard(
  //           // colorCard: Colors.transparent,
  //           listWidget: [
  //             Text('data'),
  //             Text('data'),
  //           ],
  //         ),
  //       ],
  //     )
  //   );
  // }

  void popupName() {
    PopupCustom.showPopup(context,
      title: 'Name',
      textEnable: 'Apply',
      textDisable: 'Cancel',
      content: Column(
        children: [
          contentRow('Name', SizedBox()),
          InputCustom(),
          contentRow('Birthday', SizedBox()),
          contentRow('Location', BlocBuilder<GetLocationBloc, GetLocationState>(builder: (context, state) {
            if(state is LoadGetLocationState) {
              return const CircularProgressIndicator();
            } else if (state is SuccessGetLocationState) {
              return Text('${state.response[0].city}');
            } else {
              return const Text('Error');
            }
          })),
        ],
      ),
      () {

      }
    );
  }

  Widget contentRow(String title, Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      child: Row(
        children: [
          Text(title),
          const Spacer(),
          widget,
        ],
      ),
    );
  }
}