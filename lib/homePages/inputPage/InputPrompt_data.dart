import 'package:cardio_ai/models/inputPromptDataModel.dart';

List<inputPromptDataModel> prompt = <inputPromptDataModel>[
  inputPromptDataModel(
      unit: "bpm",
      questionTitle: "Heart rate",
      info:
          "Heart rate is the speed of the heartbeat measured by the number of contractions of the heart per minute.",
      dType: "heartRate"),
  inputPromptDataModel(
    unit: "mmHg",
      questionTitle: "Blood pressure",
      info:
          "Blood pressure is the pressure of circulating blood against the walls of blood vessels. Most of this pressure results from the heart pumping blood through the circulatory system. When used without qualification, the term "
          'blood pressure'
          " refers to the pressure in the large arteries.",
      dType: "bloodPressure"),
  inputPromptDataModel(
    unit: "mg/dL",
      questionTitle: "Fasting Blood Sugar",
      info:
          "Many types of glucose tests exist and they can be used to estimate blood sugar levels at a given time or, over a longer period of time, to obtain average levels or to see how fast body is able to normalize changed glucose levels. Eating food for example leads to elevated blood sugar levels",
      dType: "fastingBloodSugar"),
  inputPromptDataModel(
      unit: "mg/dL",
      questionTitle: "Cholesterol",
      info:
          "In cases where a doctor does recommend fasting before a cholesterol test, this often means that the person must refrain from all food and drink except water for 9–12 hours before the test",
      dType: "cholesterol"),
];
