import 'package:sleepsounds/src/features/home/domain/models/categorie_model.dart';

sealed class IHomeGetCategoriesState {}

class SuccessGetCategoriesState extends IHomeGetCategoriesState {
  List<CategorieModel> listCategories;
  SuccessGetCategoriesState({
    required this.listCategories,
  });
}

class FailureGetCategoriesState extends IHomeGetCategoriesState {
  String exception;
  FailureGetCategoriesState({
    required this.exception,
  });
}
