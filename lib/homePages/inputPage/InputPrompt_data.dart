import 'package:cardio_ai/models/inputPromptDataModel.dart';

List<inputPromptDataModel> prompt = <inputPromptDataModel>[
  inputPromptDataModel(
      unit: "years",
      questionTitle: "Age",
      info: "Enter your age",
      isDouble: true),
  inputPromptDataModel(
      unit: " ",
      options: ["Female", "Male"],
      questionTitle: "Gender",
      info: "Enter your gender",
      isDouble: false),
  inputPromptDataModel(
      unit: " ",
      options: [
        "typical angina",
        "atypical angina",
        "non-anginal pain",
        "asymptotic"
      ],
      questionTitle: "Chest Pain",
      info: "Choose the type of Chest pain",
      isDouble: false),
  inputPromptDataModel(
      unit: "mmHg",
      questionTitle: "Blood pressure",
      info:
          "Blood pressure is the pressure of circulating blood against the walls of blood vessels. Most of this pressure results from the heart pumping blood through the circulatory system.",
      isDouble: true),
  inputPromptDataModel(
      unit: "mg/dL",
      questionTitle: "Cholesterol",
      info:
          "In cases where a doctor does recommend fasting before a cholesterol test, this often means that the person must refrain from all food and drink except water for 9–12 hours before the test",
      isDouble: true),
  inputPromptDataModel(
      unit: "",
      questionTitle: "Fasting Blood Sugar",
      options: ["higher than 120 mg/dl", "lower than 120 mg/dl"],
      info:
          "Many types of glucose tests exist and they can be used to estimate blood sugar levels at a given time or, over a longer period of time, to obtain average levels or to see how fast body is able to normalize changed glucose levels.",
      isDouble: false),
  inputPromptDataModel(
      unit: " ",
      questionTitle: "Resting ECG",
      options: [
        "Normal",
        "Having St-T wave abnormality",
        "left ventricular hypertrophy"
      ],
      info: "Enter type of EGC pattern",
      isDouble: false),
  inputPromptDataModel(
      unit: "bpm",
      questionTitle: "Max Heart rate",
      info:
          "Heart rate is the speed of the heartbeat measured by the number of contractions of the heart per minute.",
      isDouble: true),
  inputPromptDataModel(
      unit: " ",
      questionTitle: "Exercise induced angina",
      options: ["no", "yes"],
      info: "If exercise induced angina is present",
      isDouble: false),
  inputPromptDataModel(
      unit: " ",
      questionTitle: "ST depression",
      info: "ST depression induced by exercise relative to rest",
      isDouble: true),
  inputPromptDataModel(
      unit: " ",
      questionTitle: "Peak exercise ST",
      options: ["up sloping", "flat", "down sloping"],
      info: "Peak exercise ST segment",
      isDouble: false),
  inputPromptDataModel(
      unit: " ",
      options: ["0", "1", "2","3"],
      questionTitle: "Number of major vessels",
      info: "Number of major vessels  colored by fluoroscopy",
      isDouble: false),
  inputPromptDataModel(
      unit: " ",
      options: ["normal","fixed defect","reversible defect"],
      questionTitle: "Thal ",
      info: "Thalassemia  type",
      isDouble: false),
];
