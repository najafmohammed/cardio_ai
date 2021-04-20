import 'package:cardio_ai/models/quickInfoModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuickInfo extends StatelessWidget {
  final QuickInfoModel info;

  QuickInfo({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
      child: Card(
        color: darkCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(90),
              topRight: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: darkBg,
                  child: Image.asset(info.imageLoc
                  ),
                  radius: 40,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                            child: Text(
                              info.title,
                              style: whitePop(info.colorValue),
                            ),
                          ),
                          subtitle: SizedBox(
                            width: 50,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "last Reading",
                                      style: whitePopSmall,
                                    ),
                                    Text(
                                      DateFormat('dd-MM-yyyy')
                                          .format(info.lastdate)
                                          .toString(),
                                      style: whitePopSmall,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Previous value",
                                      style: whitePopSmall,
                                    ),
                                    Text(
                                      info.prev.toString(),
                                      style: whitePopSmall,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Remarks",
                                      style: whitePopSmall,
                                    ),
                                    Text(info.remark,
                                      style: whitePopSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ),
                    ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      Text(info.value.toString(),style: whitePopLarge(info.colorValue) ),
                      Icon(Icons.arrow_upward,color: Colors.green,)
                    ],
                  ),
                ),
                    // child: Text("89",style: whitePop,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
