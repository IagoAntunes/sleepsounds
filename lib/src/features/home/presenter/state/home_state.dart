import 'package:sleepsounds/src/features/home/domain/models/categorie_model.dart';

sealed class IHomeState {}

class SuccessHomeState extends IHomeState {
  List<CategorieModel> listCategories;
  SuccessHomeState({
    required this.listCategories,
  });
}

class FailureHomeState extends IHomeState {}

class IdleHomeState extends IHomeState {}

class LoadingHomeState extends IHomeState {}
