import 'dart:convert';

import 'package:sleepsounds/src/features/home/domain/models/sound_model.dart';

class CategorieModel {
  String id;
  String image;
  String category;
  String name;
  List<SoundModel> sounds;
  CategorieModel({
    required this.id,
    required this.image,
    required this.sounds,
    required this.category,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'category': category,
      'name': name,
      'sounds': sounds.map((x) => x.toMap()).toList(),
    };
  }

  factory CategorieModel.fromMap(Map<String, dynamic> map) {
    return CategorieModel(
      id: map['id'] as String,
      image: map['image'] as String,
      category: map['category'] as String,
      name: map['name'] as String,
      sounds: List<SoundModel>.from(
        (map['sounds'] as List<dynamic>).map<SoundModel>(
          (x) => SoundModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategorieModel.fromJson(String source) =>
      CategorieModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
