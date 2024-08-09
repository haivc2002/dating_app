import 'package:dating/common/extension/gradient.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ItemParallax extends StatelessWidget {
  final int? index;
  final String? title, subTitle;
  final String? image;
  const ItemParallax({Key? key, this.index, this.image, this.title, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: Container(
          height: 130.w,
          color: themeNotifier.systemThemeFade,
          child: Stack(
            children: [
              _itemImage(context),
              _itemInfo(context, themeNotifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemImage(BuildContext context) {
    return Hero(
      tag: '$index',
      child: Flow(
        delegate: ParallaxFlowDelegate(
          scrollable: Scrollable.of(context),
          itemContext: context,
        ),
        children: [
          Image.network(
            image ?? 'https://i.pinimg.com/736x/a1/ae/8a/a1ae8ad5d7f52510172f9384260105fd.jpg',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget _itemInfo(BuildContext context, ThemeNotifier themeNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: GradientColor.gradientBlackFade
          ),
          child: SizedBox(
            height: 50.w,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  Text(
                    title??'',
                    style: TextStyles.defaultStyle
                        .bold
                        .setTextSize(15.sp)
                        .setColor(ThemeColor.whiteColor),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.w),
                        border: Border.all(color: ThemeColor.whiteColor, width: 1.5),
                        color: ThemeColor.whiteColor.withOpacity(0.7)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
                        child: Text(
                          subTitle??'',
                          style: TextStyles
                              .defaultStyle
                              .setColor(ThemeColor.pinkColor)
                              .setTextSize(9.sp),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState? scrollable;
  final BuildContext itemContext;

  ParallaxFlowDelegate({
    required this.scrollable,
    required this.itemContext,
  }) : super(repaint: scrollable?.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) =>
      BoxConstraints.tightFor(width: constraints.maxWidth);

  @override
  void paintChildren(FlowPaintingContext context) {
    if (scrollable == null) return;

    final scrollableBox = scrollable!.context.findRenderObject() as RenderBox;
    final itemBox = itemContext.findRenderObject() as RenderBox;
    final itemOffset = itemBox.localToGlobal(
      itemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox,
    );
    final viewportDimension = scrollable!.position.viewportDimension;
    final scrollFraction =
    (itemOffset.dy / viewportDimension).clamp(0, 1);
    final verticalAlignment = Alignment(0, scrollFraction * 3 - 1);
    final imageBox = context.getChildSize(0)!;
    final childRect =
    verticalAlignment.inscribe(imageBox, Offset.zero & context.size);

    context.paintChild(0, transform: Transform.translate(offset: Offset(0, childRect.top)).transform);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }
}


