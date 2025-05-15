import 'package:mybookstore/features/store/domain/entities/store_entity.dart';

class StoreModel extends StoreEntity {
  const StoreModel({required super.banner, required super.id, required super.name, required super.slogan});

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      banner: map['banner'],
      id: map['id'],
      name: map['name'],
      slogan: map['slogan'],
    );
  }

  factory StoreModel.fromEntity(StoreEntity entity) {
    return StoreModel(
      banner: entity.banner,
      id: entity.id,
      name: entity.name,
      slogan: entity.slogan,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'banner': banner,
      'id': id,
      'name': name,
      'slogan': slogan,
    };
  }

  @override
  String toString() {
    return 'StoreModel{banner: $banner, id: $id, name: $name, slogan: $slogan}';
  }
}
