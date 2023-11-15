import 'package:sleepsounds/src/features/home/data/home_datasource.dart';
import 'package:sleepsounds/src/features/home/domain/models/categorie_model.dart';
import 'package:sleepsounds/src/features/home/domain/states/home_get_categories_state.dart';

abstract class IHomeRepository {
  Future<List<CategorieModel>?> getAllCategories();
}

class HomeRepository extends IHomeRepository {
  IHomeDatasource datasource;
  HomeRepository({
    required this.datasource,
  });
  @override
  Future<List<CategorieModel>?> getAllCategories() async {
    final result = await datasource.getAllCategories();
    if (result is SuccessGetCategoriesState) {
      return result.listCategories;
    } else {
      return null;
    }
  }
}
