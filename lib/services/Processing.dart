import 'package:cardio_ai/models/inputPromptDataModel.dart';

class Processing {
  static processPatientRecord(List<inputPromptDataModel> list) {
    List <double>processedList=List.filled(list.length, 0);
    int i=0;
    list.forEach((element) {
      if(element.questionTitle=="Thal "){
        String temp=element.options.indexOf(element.val).toString();
        switch (int.tryParse(temp)){
          case 0: processedList[i]=3;break;
          case 1: processedList[i]=6;break;
          case 2: processedList[i]=7;break;
        }
        i++;
      }
      if(element.isDouble) {
        processedList[i] = (double.tryParse(element.val ?? 0.0));
        i++;
      }
      if(!element.isDouble && element.questionTitle!="Thal "){
        String temp=element.options.indexOf(element.val).toString();
        processedList[i] = (double.tryParse(temp??0));
        i++;
      }
    });
    return processedList;
  }
}
