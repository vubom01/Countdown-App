class ApiCode{
  const ApiCode._();
  static const List<int> successCodes = [
    success0,
    success200,
  ];

  static const int success0 = 0;
  static const int invalidMethod = 1;
  static const int validationError = 2;

  static const int userSignedInAnotherLocation = 3;
  static const int staffNotFound = 4;
  static const int exception = 5;
  static const int headerMustContainToken = 6;

  static const int incorrectUser = 101;
  static const int inactiveUser = 102;
  static const int generateTokenException = 104;

  static const int success200 = 200;
  static const int tokenNotFound = 201;
  static const int invalidToken = 202;
  static const int expiredToken = 203;
  static const int userSignedOut = 204;
  static const int notAllowedDevice = 205;

  static const int serviceNotSupported = 301;
  static const int accountNotFound = 302;
  static const int accountNotFoundFromEm = 304;

  static const int accountServiceNotSupported = 402;

  static const int withdrawEMoneyTimeout = 603;

  static const int transactionNotFound = 901;
  static const int transactionServiceNotSupported = 902;
}