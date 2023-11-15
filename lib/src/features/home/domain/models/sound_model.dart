import 'dart:convert';

class SoundModel {
  String id;
  String mp3;
  String name;
  SoundModel({
    required this.id,
    required this.mp3,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'mp3': mp3,
      'name': name,
    };
  }

  factory SoundModel.fromMap(Map<String, dynamic> map) {
    return SoundModel(
      id: map['id'] as String,
      mp3: map['mp3'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SoundModel.fromJson(String source) =>
      SoundModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
