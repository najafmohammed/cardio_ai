import 'package:flutter/material.dart';

class QuickInfoModel {
  final String title;
  final int value;
  final int prev;
  final DateTime lastDate;
  final String imageLoc;
  final Color colorValue;
  final String unit;

  QuickInfoModel(
      {this.title,
      this.value,
      this.unit,
      this.prev,
      this.lastDate,
      this.imageLoc,
      this.colorValue});
}
