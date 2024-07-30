import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ItemParallax extends StatelessWidget {
  final int? index;
  const ItemParallax({Key? key, this.index}) : super(key: key);

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
          child: Row(
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
    return Expanded(
      child: Hero(
        tag: '$index',
        child: SizedBox(
          height: 130.w,
          child: Flow(
            delegate: ParallaxFlowDelegate(
              scrollable: Scrollable.of(context),
              itemContext: context,
            ),
            children: [
              Image.network(
                'https://i.pinimg.com/736x/a1/ae/8a/a1ae8ad5d7f52510172f9384260105fd.jpg',
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemInfo(BuildContext context, ThemeNotifier themeNotifier) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'dataName, 20',
                style: TextStyles.defaultStyle
                    .bold
                    .setTextSize(15.sp)
                    .setColor(ThemeColor.pinkColor),
              ),
              SizedBox(height: 10.w),
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      color: themeNotifier.systemText.withOpacity(0.5)),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'dataName 20',
                      style: TextStyles.defaultStyle.setColor(
                          themeNotifier.systemText.withOpacity(0.5)
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(CupertinoIcons.square_stack_3d_up,
                      color: themeNotifier.systemText.withOpacity(0.5)),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Dating',
                      style: TextStyles.defaultStyle.setColor(
                          themeNotifier.systemText.withOpacity(0.5)
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
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
    final verticalAlignment = Alignment(0, scrollFraction * 2 - 1);
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


