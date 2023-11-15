import 'dart:convert';

class SoundModel {
  String id;
  String mp4;
  SoundModel({
    required this.id,
    required this.mp4,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'mp4': mp4,
    };
  }

  factory SoundModel.fromMap(Map<String, dynamic> map) {
    return SoundModel(
      id: map['id'] as String,
      mp4: map['mp4'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SoundModel.fromJson(String source) =>
      SoundModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
