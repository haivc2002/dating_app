import 'package:dating/bloc/bloc_profile/edit_more_bloc.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/popup_type_hero.dart';
import 'package:dating/ui/all_tap_bottom/all_tap/profile/common_local/return_height_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../theme/theme_notifier.dart';

class SelectHeightPerson extends StatefulWidget {
  static const String routeName = 'selectHeightPerson';
  const SelectHeightPerson({Key? key}) : super(key: key);

  @override
  State<SelectHeightPerson> createState() => _SelectHeightPersonState();
}

class _SelectHeightPersonState extends State<SelectHeightPerson> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return BlocBuilder<EditMoreBloc, EditMoreState>(
      builder: (context, state) {
        return PopupTypeHero(
          tag: 1,
          data: '${returnHeightValue(state.heightPerson??0)}cm',
          iconTitle: Icons.height,
          title: 'Height',
          content: ListView.builder(
            shrinkWrap: true,
            itemCount: 101,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: state.heightPerson == (index+100) ? themeNotifier.systemTheme : Colors.transparent,
                  borderRadius: BorderRadius.circular(5.w)
                ),
                child: InkWell(
                  onTap: () {
                    context.read<EditMoreBloc>().add(EditMoreEvent(heightPerson: index+100));
                    state.heightPerson == (index+100) ? null : Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    child: listHeight(index)
                  )
                ),
              );
            },
          ),
        );
      }
    );
  }

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
}
