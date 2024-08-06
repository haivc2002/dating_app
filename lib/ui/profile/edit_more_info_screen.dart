
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/press_popup_custom.dart';
import 'package:dating/tool_widget_custom/wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common/textstyles.dart';
import '../../../theme/theme_notifier.dart';
import '../../bloc/bloc_profile/store_edit_more_bloc.dart';
import '../../bloc/bloc_search_autocomplete/autocomplete_bloc.dart';
import '../../controller/profile_controller/edit_more_info_controller.dart';
import '../../controller/search_autocomplete_controller.dart';
import '../../model/location_model/search_autocomplete_model.dart';
import '../../tool_widget_custom/input_custom.dart';

class EditMoreInfoScreen extends StatefulWidget {
  static const String routeName = 'editMoreInfoScreen';
  const EditMoreInfoScreen({Key? key}) : super(key: key);

  @override
  State<EditMoreInfoScreen> createState() => _EditMoreInfoScreenState();
}

class _EditMoreInfoScreenState extends State<EditMoreInfoScreen> {

  AlignmentGeometry alignment = Alignment.topLeft;
  late EditMoreInfoController controller;
  TextEditingController inputControl = TextEditingController();
  late SearchAutocompleteController searchAutocomplete;

  @override
  void initState() {
    super.initState();
    controller = EditMoreInfoController(context);
    searchAutocomplete = SearchAutocompleteController(context);
  }


  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if(state is SuccessApiHomeState) {
            final infoMore = state.info?.infoMore;
            return AppBarCustom(
              title: 'Edit more information',
              textStyle: TextStyles.defaultStyle.appbarTitle.bold,
              bodyListWidget: [
                SizedBox(height: 50.w),
                PressPopupCustom(
                  content: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 101,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: infoMore?.height == (index+100) ? themeNotifier.systemTheme : Colors.transparent,
                          borderRadius: BorderRadius.circular(5.w)
                        ),
                        child: InkWell(
                          onTap: () => controller.onChange(state.info!, heightValue: index+100),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.w),
                            child: controller.listHeight(index)
                          )
                        ),
                      );
                    },
                  ),
                  child: itemComponentInfoMore(Icons.height, 'Height', controller.returnHeight(infoMore?.height??0), const SizedBox())
                ),
                SizedBox(height: 20.w),
                itemComponentInfoMore(
                    Icons.wine_bar, 'wine', '${infoMore?.wine}',
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20.w, 0, 0),
                      child: Wrap(
                        runSpacing: 10.w,
                        spacing: 10.w,
                        children: List.generate(controller.wineAndSmoking.length, (index) {
                          return GestureDetector(
                            onTap: ()=>controller.onChange(state.info!, wine: controller.wineAndSmoking[index]),
                            child: options(controller.wineAndSmoking[index], controller.wineAndSmoking[index] == infoMore?.wine),
                          );
                        }),
                      ),
                    )
                ),
                SizedBox(height: 20.w),
                itemComponentInfoMore(
                  Icons.smoking_rooms, 'smoking', '${infoMore?.smoking}',
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20.w, 0, 0),
                    child: Wrap(
                      runSpacing: 10.w,
                      spacing: 10.w,
                      children: List.generate(controller.wineAndSmoking.length, (index) {
                        return GestureDetector(
                          onTap: ()=> controller.onChange(state.info!, smoking: controller.wineAndSmoking[index]),
                          child: options(controller.wineAndSmoking[index], controller.wineAndSmoking[index] == infoMore?.smoking)
                        );
                      }),
                    ),
                  )
                ),
                SizedBox(height: 20.w),
                itemComponentInfoMore(
                  Icons.ac_unit_sharp, 'Zodiac', '${infoMore?.zodiac}',
                  const SizedBox()
                ),
                SizedBox(height: 20.w),
                itemComponentInfoMore(
                  Icons.account_balance, 'Religion', '${infoMore?.religion}',
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20.w, 0, 0),
                    child: Wrap(
                      runSpacing: 10.w,
                      spacing: 10.w,
                      children: List.generate(controller.religion.length, (index) {
                        return GestureDetector(
                          onTap: ()=> controller.onChange(state.info!, religion: controller.religion[index]),
                          child: options(controller.religion[index], controller.religion[index] == infoMore?.religion),
                        );
                      }),
                    ),
                  )
                ),
                SizedBox(height: 20.w),
                PressPopupCustom(
                  content: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollStartNotification) {
                        FocusScope.of(context).unfocus();
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Find', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.w),
                            child: InputCustom(
                              controller: inputControl,
                              colorInput: themeNotifier.systemTheme,
                              onChanged: (location) {
                                context.read<StoreEditMoreBloc>().add(StoreEditMoreEvent(textEditingState: inputControl.text));
                                searchAutocomplete.getData(location);
                              },
                            ),
                          ),
                          returnResult(),
                        ],
                      ),
                    ),
                  ),
                  child: itemComponentInfoMore(Icons.home, 'Hometown', '${infoMore?.hometown}', const SizedBox()),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        }
      ),
    );
  }

  Widget itemComponentInfoMore(IconData iconLeading, String title, String data, Widget widget) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Material(
      color: themeNotifier.systemThemeFade,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.w),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(iconLeading, color: themeNotifier.systemText.withOpacity(0.4)),
                  SizedBox(width: 10.w),
                  Material(color: Colors.transparent, child: Text(title, style: TextStyles.defaultStyle.bold.setColor(themeNotifier.systemText))),
                  SizedBox(width: 20.w),
                  Expanded(child: Material(color: Colors.transparent,
                    child: AutoSizeText(data, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText), maxLines: 1, textAlign: TextAlign.end)
                  ))
                ],
              ),
              widget
            ],
          ),
        ),
      ),
    );
  }

  Widget options(String title, bool condition) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: condition ? ThemeColor.pinkColor : ThemeColor.greyColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(100.w)
      ),
      padding: EdgeInsets.symmetric(vertical: 7.w, horizontal: 10.w),
      child: Text(title, style: TextStyles.defaultStyle.setColor(condition ? ThemeColor.whiteColor : themeNotifier.systemText)),
    );
  }

  Widget returnResult() {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return BlocBuilder<StoreEditMoreBloc, StoreEditMoreState>(builder: (context, store) {
      if((store.textEditingState??'').isNotEmpty) {
        return BlocBuilder<AutocompleteBloc, AutocompleteState>(
          builder: (context, state) {
            if(state is LoadAutocompleteState) {
              return Center(
                child: Wait(color: themeNotifier.systemText),
              );
            } else if(state is SuccessAutocompleteState) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.response.where((element) => element.properties?.formatted != null).length,
                itemBuilder: (context, index) {
                  final validItems = state.response.where((element) => element.properties?.formatted != null).toList();
                  return titleHometown(validItems, index);
                }
              );
            } else {
              return Text("Could not find the address", style: TextStyles.defaultStyle.setColor(themeNotifier.systemText));
            }
          }
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget titleHometown(List<Features> validItems, int index) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final properties = validItems[index].properties;
    String dataHomeTown = '${properties?.formatted}';
    return InkWell(
      borderRadius: BorderRadius.circular(5.w),
      onTap: ()=> controller.updateHomeTown(dataHomeTown),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 10.w),
        child: Row(
          children: [
            Icon(Icons.home_work_outlined, color: themeNotifier.systemText.withOpacity(0.4)),
            SizedBox(width: 20.w),
            Expanded(child: Text(dataHomeTown, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)))
          ],
        )
      ),
    );
  }

}
