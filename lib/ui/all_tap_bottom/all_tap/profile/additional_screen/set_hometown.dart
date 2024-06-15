import 'package:dating/bloc/bloc_profile/edit_more_bloc.dart';
import 'package:dating/bloc/bloc_search_autocomplete/autocomplete_bloc.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/tool_widget_custom/input_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../../../../../theme/theme_notifier.dart';
import '../../../../../../tool_widget_custom/popup_type_hero.dart';
import '../../../../../controller/location_controller/search_autocomplete_controller.dart';
import '../../../../../model/location_model/search_autocomplete_model.dart';

class SetHomeTown extends StatefulWidget {
  static const String routeName = 'setHomeTown';
  const SetHomeTown({Key? key}) : super(key: key);

  @override
  State<SetHomeTown> createState() => _SetHomeTownState();
}

class _SetHomeTownState extends State<SetHomeTown> {

  late SearchAutocompleteController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = SearchAutocompleteController(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return BlocBuilder<EditMoreBloc, EditMoreState>(
      builder: (context, editMoreState) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: PopupTypeHero(
            tag: 8,
            title: 'Hometown',
            data: editMoreState.homeTown,
            iconTitle: Icons.home,
            content: SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Find', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    child: InputCustom(
                      colorInput: themeNotifier.systemTheme,
                      onChanged: (location) {
                        controller.getData(location);
                      },
                    ),
                  ),
                  BlocBuilder<AutocompleteBloc, AutocompleteState>(
                    builder: (context, state) {
                      if(state is LoadAutocompleteState) {
                        return Center(
                          child: CircularProgressIndicator(color: themeNotifier.systemText),
                        );
                      } else if(state is SuccessAutocompleteState) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.response.where((element) => element.properties?.city != null).length,
                          itemBuilder: (context, index) {
                            final validItems = state.response.where((element) => element.properties?.city != null).toList();
                            return titleHometown(validItems, index);
                          }
                        );

                      } else {
                        return Text("Could not find the address", style: TextStyles.defaultStyle.setColor(themeNotifier.systemText));
                      }
                    }
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget titleHometown(List<Features> validItems, int index) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final properties = validItems[index].properties;
    String dataHomeTown = '${properties?.city}, ${properties?.country}';
    return InkWell(
      borderRadius: BorderRadius.circular(5.w),
      onTap: () {
        context.read<EditMoreBloc>().add(EditMoreEvent(homeTown: dataHomeTown));
        FocusScope.of(context).unfocus();
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pop(context);
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 10.w),
        child: Row(
          children: [
            Icon(Icons.home_work_outlined, color: themeNotifier.systemText.withOpacity(0.4)),
            SizedBox(width: 20.w),
            Text(dataHomeTown, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
          ],
        )
      ),
    );
  }

}
