import 'package:qixer/view/utils/const_strings.dart';

class IntroHelper {
  getImage(int i) {
    return 'assets/images/intro${i + 1}.png';
  }

  List title = [
    ConstString.houseCleaningService,
    ConstString.repairingService,
    ConstString.homeShiftService
  ];
  List subTitle = [
    ConstString.getHouseServiceFromExperts,
    ConstString.getRepairedFromExperts,
    ConstString.homeShiftFromExperts
  ];
}
