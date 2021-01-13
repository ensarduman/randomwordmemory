import 'package:instantmessage/common/enums.dart';

class RandomScreenModel {
  EnumDateFilterType dataFilterType;
  bool isMyLanguageFirst;

  RandomScreenModel({EnumDateFilterType dataFilterType, bool isMyLanguageFirst}) {
    this.dataFilterType = dataFilterType;
    this.isMyLanguageFirst = isMyLanguageFirst;
  }
}
