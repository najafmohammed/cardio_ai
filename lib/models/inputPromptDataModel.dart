class inputPromptDataModel {
  final String questionTitle;
  final String info;
  final bool isDouble;
  String val;
  final List<String> options;

  final String unit;
  inputPromptDataModel(
      {this.unit, this.val, this.questionTitle, this.isDouble, this.info,this.options });
}
