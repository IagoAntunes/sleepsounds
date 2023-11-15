import 'package:flutter/foundation.dart';

import 'package:sleepsounds/src/features/home/domain/home_repository.dart';
import 'package:sleepsounds/src/features/home/presenter/state/home_state.dart';

class HomeController extends ChangeNotifier {
  HomeController({
    required this.repository,
  }) {
    getAllCategories();
  }
  HomeRepository repository;
  List<String> listMenus = [
    "All",
    "Instrumental",
    "Ambient",
  ];
  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  ValueNotifier<IHomeState> state = ValueNotifier<IHomeState>(IdleHomeState());

  void changeMenuIndex(int newIndex) {
    selectedIndex.value = newIndex;
    notifyListeners();
  }

  void getAllCategories() async {
    state.value = LoadingHomeState();
    notifyListeners();
    final result = await repository.getAllCategories();
    if (result != null) {
      state.value = SuccessHomeState(listCategories: result);
    } else {
      state.value = FailureHomeState();
    }
    notifyListeners();
  }
}
