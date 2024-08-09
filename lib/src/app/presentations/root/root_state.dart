import 'package:get/get.dart';

class RootState {
  final RxBool _isLoadingInitApp = false.obs;

  bool get isLoadingInitApp => _isLoadingInitApp.value;

  void setIsLoadingInitApp(bool value) => _isLoadingInitApp.value = value;
}
