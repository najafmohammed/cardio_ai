import 'package:auto_animated/auto_animated.dart';
import 'package:cardio_ai/homePages/inputPage/modalSection/modal_tile.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/material.dart';

class BottomModal extends StatefulWidget {
  const BottomModal({Key key}) : super(key: key);

  @override
  _BottomModalState createState() => _BottomModalState();
}

final options = LiveOptions(
  // Start animation after (default zero)
  delay: Duration(milliseconds: 10),

  // Show each item through (default 250)
  showItemInterval: Duration(milliseconds: 200),

  // Animation duration (default 250)
  showItemDuration: Duration(milliseconds: 200),

  // Animations starts at 0.05 visible
  // item fraction in sight (default 0.025)
  visibleFraction: 0.05,

  // Repeat the animation of the appearance
  // when scrolling in the opposite direction (default false)
  // To get the effect as in a showcase for ListView, set true
  reAnimateOnVisibility: false,
);
// Build animated item (helper for all examples)
Widget buildAnimatedItem(
  BuildContext context,
  int index,
  Animation<double> animation,
) =>
    // For example wrap with fade transition
    FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      // And slide transition
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -0.1),
          end: Offset.zero,
        ).animate(animation),
        // Paste you Widget
        child: ModalTile(),
      ),
    );

class _BottomModalState extends State<BottomModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(
                  "Input Data",
                  style: whitePopLarge(
                    Colors.white,
                  ),
                ),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
          Expanded(
              child: LiveList.options(
            options: options,

            // Like ListView.builder, but also includes animation property
            itemBuilder: buildAnimatedItem,

            // Other properties correspond to the
            // `ListView.builder` / `ListView.separated` widget
            scrollDirection: Axis.vertical,
            itemCount: 10,
          )),
        ],
      ),
    );
  }
}
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListView.builder(
// itemCount: 15,
// shrinkWrap: true,
// primary: false,
// itemBuilder: (context, index) {
// return ModalTile();
// },
// ),
// ),
