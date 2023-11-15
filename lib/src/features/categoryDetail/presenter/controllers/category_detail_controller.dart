import 'package:flutter/foundation.dart';

import '../../../home/domain/models/categorie_model.dart';

class CategoryDetailController extends ChangeNotifier {
  CategorieModel categoryModel;
  CategoryDetailController({
    required this.categoryModel,
  });
}
