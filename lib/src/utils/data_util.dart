import 'package:uuid/uuid.dart';

class DataUtil{
  static String makeFilePath(){
    return '${Uuid().v4()}.jpg';
  }

  //TODO 확장자를 모르기때문에 제대로하려면 분리해서 처리
  // static String makeFilePath(File file){
  //   var fileName = basename(file!.path);
  //   return '${Uuid().v4()}.jpg';
  // }

}