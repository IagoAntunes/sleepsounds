import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:sleepsounds/src/features/home/domain/models/categorie_model.dart';
import 'package:sleepsounds/src/features/home/domain/states/home_get_categories_state.dart';

abstract class IHomeDatasource {
  Future<IHomeGetCategoriesState> getAllCategories();
}

class HomeDatasource extends IHomeDatasource {
  @override
  Future<IHomeGetCategoriesState> getAllCategories() async {
    try {
      List<CategorieModel> listCategories = [];
      FirebaseFirestore firestore = GetIt.I.get<FirebaseFirestore>();
      var result = await firestore.collection('categories').get();

      for (var item in result.docs) {
        listCategories.add(
          CategorieModel.fromMap(
            item.data(),
          ),
        );
      }
      return SuccessGetCategoriesState(listCategories: listCategories);
    } catch (e) {
      return FailureGetCategoriesState(exception: e.toString());
    }
  }
}
