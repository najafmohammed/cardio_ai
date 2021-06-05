import 'package:auto_animated/auto_animated.dart';
import 'package:cardio_ai/history/history_info_tile.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/material.dart';
class HistoryInfo extends StatefulWidget {
  const HistoryInfo({Key key, this.entry}) : super(key: key);
  final List<dynamic> entry;
  @override
  _HistoryInfoState createState() => _HistoryInfoState();
}

final options = LiveOptions(
  showItemInterval: Duration(milliseconds: 200),
  showItemDuration: Duration(milliseconds: 200),
  visibleFraction: 0.85,
  reAnimateOnVisibility: false,
);

class _HistoryInfoState extends State<HistoryInfo> {

  Widget buildAnimatedItem(
      BuildContext context,
      int index,
      Animation<double> animation,
      ) =>
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            child: HistoryInfoTile(entry: widget.entry,index: index,)
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(
                  "More info",
                  style: whitePopLarge(
                    Colors.white,
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
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
                itemBuilder: buildAnimatedItem,
                scrollDirection: Axis.vertical,
                itemCount: widget.entry.length,
              )),
        ],
      ),
    );
  }
}

