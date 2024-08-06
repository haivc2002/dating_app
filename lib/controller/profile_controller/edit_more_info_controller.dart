import 'package:dating/controller/profile_controller/update_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bloc/bloc_home/home_bloc.dart';
import '../../common/city_cover.dart';
import '../../common/textstyles.dart';
import '../../model/model_info_user.dart';
import '../../theme/theme_notifier.dart';

class EditMoreInfoController {
  BuildContext context;
  EditMoreInfoController(this.context);

  List<String> wineAndSmoking = ['Sometime', 'Usually', 'Have', 'Never', 'Undisclosed'];
  List<String> zodiac = ['Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo', 'Libra', 'Scorpius', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'];
  List<String> religion = ['Atheist', 'Buddhism', 'Catholic', 'Protestantism', 'Islamic', 'CaoDai', 'HoaHao'];
  // List<String> character = ['Introverted', 'Outward', 'Somewhere in the middle', 'Undisclosed'];

  Widget listHeight(int index) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    if(index == 0) {
      return Text('lower 100cm', textAlign: TextAlign.center, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText),);
    } else if (index == 100) {
      return Text('higher 200cm', textAlign: TextAlign.center, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText),);
    } else {
      return Text('${index+100}cm', textAlign: TextAlign.center, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText),);
    }
  }

  void onChange(ModelInfoUser state, {
    int? heightValue,
    String? wine,
    String? smoking,
    String? zodiac,
    String? religion,
  }) {
    UpdateModel.updateModelInfo(
      state,
      height: heightValue,
      wine: wine,
      smoking: smoking,
      zodiac: zodiac,
      religion: religion,
    );
    context.read<HomeBloc>().add(SuccessApiHomeEvent(info: UpdateModel.modelInfoUser));
  }

  String returnHeight(int heightValue) {
    if (heightValue > 100 && heightValue < 200) {
      return '${heightValue}cm';
    } else if(heightValue == 100) {
      return 'lower ${heightValue}cm';
    } else if(heightValue == 200) {
      return 'higher ${heightValue}cm';
    } else {
      return 'null';
    }
  }

  void updateHomeTown(String dataHomeTown) {
    final state = context.read<HomeBloc>().state;
    if(state is SuccessApiHomeState) {
      UpdateModel.updateModelInfo(state.info!,
        hometown: cityAutoComplete(dataHomeTown)
      );
      context.read<HomeBloc>().add(SuccessApiHomeEvent(info: UpdateModel.modelInfoUser));
      FocusScope.of(context).unfocus();
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.pop(context);
      });
    }
  }

}