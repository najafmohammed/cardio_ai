import 'package:flutter/material.dart';

class QuickInfoModel {
  final String title;
  final int value;
  final int prev;
  final DateTime lastdate;
  final String remark;
  final String imageLoc;
  final Color colorValue;

  QuickInfoModel(
      {this.title,
      this.value,
      this.prev,
      this.lastdate,
      this.remark,
      this.imageLoc,
      this.colorValue});
}
