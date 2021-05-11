import 'package:flutter/material.dart';

class QuickInfoModel {
  final String title;
  final int value;
  final int prev;
  final DateTime lastDate;
  final String remark;
  final String imageLoc;
  final Color colorValue;
  final String unit;

  QuickInfoModel(
      {this.title,
      this.value,
      this.unit,
      this.prev,
      this.lastDate,
      this.remark,
      this.imageLoc,
      this.colorValue});
}
