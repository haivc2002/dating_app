import 'package:dating/bloc/bloc_detail/detail_bloc.dart';
import 'package:dating/model/model_info_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/service_info_user.dart';
import '../theme/theme_color.dart';

class DetailController {
  BuildContext context;
  DetailController(this.context);

  ServiceInfoUser info = ServiceInfoUser();

  List<Widget> items(ModelInfoUser data) {
    List<Widget> result = [];

    if (data.infoMore?.height != null) {
      result.add(_itemMore(Icons.height, '${data.infoMore?.height}cm'));
    }
    if (data.infoMore?.wine != null) {
      result.add(_itemMore(Icons.wine_bar, '${data.infoMore?.wine}'));
    }
    if (data.infoMore?.smoking != null) {
      result.add(_itemMore(Icons.smoking_rooms, '${data.infoMore?.smoking}'));
    }
    if (data.infoMore?.zodiac != null) {
      result.add(_itemMore(Icons.ac_unit_sharp, '${data.infoMore?.zodiac}'));
    }
    if (data.infoMore?.religion != null) {
      result.add(_itemMore(Icons.account_balance, '${data.infoMore?.religion}'));
    }
    if (data.infoMore?.hometown != null) {
      result.add(_itemMore(Icons.home, '${data.infoMore?.hometown}'));
    }
    
    return result;
  }

  Widget _itemMore(IconData iconData, String data) {
    return Container(
      decoration: BoxDecoration(
          color: ThemeColor.whiteColor,
          borderRadius: BorderRadius.circular(100.w)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 12.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData),
            SizedBox(width: 5.w),
            Text(data),
          ],
        ),
      ),
    );
  }

  void getData(int idUser) async {
    onLoad();
    ModelInfoUser response = await info.info(idUser, context);
    if(response.result == 'Success') {
      onSuccess(response);
    } else {
      onError();
    }
  }

  void onLoad()=> context.read<DetailBloc>().add(LoadDetailEvent());

  void onSuccess(ModelInfoUser response)=> context.read<DetailBloc>().add(SuccessDetailEvent(response));

  void onError() {}
}