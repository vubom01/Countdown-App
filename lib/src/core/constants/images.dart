import 'dart:math';

class AppAssetImages {
  const AppAssetImages._();

  static const String google = 'assets/images/logo/google.png';
  static const String apple = 'assets/images/logo/apple.png';
  static const String vietnam = 'assets/images/kingdom.png';
  static const String kingdom = 'assets/images/vietnam.png';
  /// ----------------------------------------------------------------------------------------------

  static const String authHeader = 'assets/images/auth_header.png';
  /// ----------------------------------------------------------------------------------------------

  static const String avatar1 = 'assets/images/avatar/avatar-1.png';
  static const String avatar2 = 'assets/images/avatar/avatar-2.png';
  static const String avatar3 = 'assets/images/avatar/avatar-3.png';
  static const String avatar4 = 'assets/images/avatar/avatar-4.png';
  static const String avatar5 = 'assets/images/avatar/avatar-5.png';
  static const String avatar6 = 'assets/images/avatar/avatar-6.png';
  static const String avatar7 = 'assets/images/avatar/avatar-7.png';
  static const String avatar8 = 'assets/images/avatar/avatar-8.png';

  static String get randomAvatar {
    final random = Random();
    final index = random.nextInt(8);
    switch (index) {
      case 0:
        return avatar1;
      case 1:
        return avatar2;
      case 2:
        return avatar3;
      case 3:
        return avatar4;
      case 4:
        return avatar5;
      case 5:
        return avatar6;
      case 6:
        return avatar7;
      case 7:
        return avatar8;
      default:
        return avatar1;
    }
  }
}