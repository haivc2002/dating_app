
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/controller/profile_controller/edit_profile_controller.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/press_popup_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common/textstyles.dart';
import '../../../theme/theme_notifier.dart';
import '../../bloc/bloc_profile/store_edit_more_bloc.dart';
import '../../bloc/bloc_search_autocomplete/autocomplete_bloc.dart';
import '../../controller/location_controller/search_autocomplete_controller.dart';
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
  late EditProfileController controller;
  TextEditingController inputControl = TextEditingController();
  late SearchAutocompleteController searchAutocomplete;

  @override
  void initState() {
    super.initState();
    controller = EditProfileController(context);
    searchAutocomplete = SearchAutocompleteController(context);
  }


  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: AppBarCustom(
        title: 'Edit more information',
        textStyle: TextStyles.defaultStyle.appbarTitle.bold,
        bodyListWidget: [
          SizedBox(height: 50.w),
          PressPopupCustom(
            content: BlocBuilder<StoreEditMoreBloc, StoreEditMoreState>(
                builder: (context, state) {
                  return ListView.builder(
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
                              context.read<StoreEditMoreBloc>().add(StoreEditMoreEvent(heightPerson: index+100));
                              state.heightPerson == (index+100) ? null : Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.w),
                              child: controller.listHeight(index)
                            )
                        ),
                      );
                    },
                  );
                }
            ),
            child: BlocBuilder<StoreEditMoreBloc, StoreEditMoreState>(builder: (context, state) {
              return itemComponentInfoMore(Icons.height, 'Height', '180cm', const SizedBox());
            }),
          ),
          SizedBox(height: 20.w),
          BlocBuilder<StoreEditMoreBloc, StoreEditMoreState>(
            builder: (context, state) {
              return itemComponentInfoMore(
                Icons.wine_bar, 'wine', '${state.wine}',
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20.w, 0, 0),
                  child: Wrap(
                    runSpacing: 10.w,
                    spacing: 10.w,
                    children: List.generate(controller.wineAndSmoking.length, (index) {
                      return GestureDetector(
                        onTap: ()=>context.read<StoreEditMoreBloc>().add(StoreEditMoreEvent(wine: controller.wineAndSmoking[index])),
                        child: options(controller.wineAndSmoking[index], controller.wineAndSmoking[index] == state.wine)
                      );
                    }),
                  ),
                )
              );
            }
          ),
          SizedBox(height: 20.w),
          BlocBuilder<StoreEditMoreBloc, StoreEditMoreState>(
            builder: (context, state) {
              return itemComponentInfoMore(
                Icons.smoking_rooms, 'smoking', '${state.smoking}',
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 20.w, 0, 0),
                    child: Wrap(
                      runSpacing: 10.w,
                      spacing: 10.w,
                      children: List.generate(controller.wineAndSmoking.length, (index) {
                        return GestureDetector(
                            onTap: ()=> context.read<StoreEditMoreBloc>().add(StoreEditMoreEvent(smoking: controller.wineAndSmoking[index])),
                            child: options(controller.wineAndSmoking[index], controller.wineAndSmoking[index] == state.smoking)
                        );
                      }),
                    ),
                  )
              );
            }
          ),
          SizedBox(height: 20.w),
          BlocBuilder<StoreEditMoreBloc, StoreEditMoreState>(
            builder: (context, state) {
              return itemComponentInfoMore(
                Icons.ac_unit_sharp, 'Zodiac', '${state.zodiac}',
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20.w, 0, 0),
                  child: Wrap(
                    runSpacing: 10.w,
                    spacing: 10.w,
                    children: List.generate(controller.zodiac.length, (index) {
                      return GestureDetector(
                          onTap: ()=> context.read<StoreEditMoreBloc>().add(StoreEditMoreEvent(zodiac: controller.zodiac[index])),
                          child: options(controller.zodiac[index], controller.zodiac[index] == state.zodiac)
                      );
                    }),
                  ),
                )
              );
            }
          ),
          SizedBox(height: 20.w),
          itemComponentInfoMore(
            Icons.account_balance, 'Religion', 'vô thần',
            Text('♈data')
          ),
          SizedBox(height: 20.w),
          PressPopupCustom(
            content: BlocBuilder<StoreEditMoreBloc, StoreEditMoreState>(
              builder: (context, state) {
                return NotificationListener<ScrollNotification>(
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
                );
              }
            ),
            child: BlocBuilder<StoreEditMoreBloc, StoreEditMoreState>(builder: (context, state) {
              return itemComponentInfoMore(Icons.height, 'Hometown', '${state.homeTown}', const SizedBox());
            }),
          ),
        ],
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
                  child: CircularProgressIndicator(color: themeNotifier.systemText),
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
      onTap: () {
        context.read<StoreEditMoreBloc>().add(StoreEditMoreEvent(homeTown: dataHomeTown));
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
              Expanded(child: Text(dataHomeTown, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)))
            ],
          )
      ),
    );
  }

}
