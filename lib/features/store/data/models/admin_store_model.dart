import 'package:mybookstore/features/store/domain/entities/admin_store_entity.dart';
import 'package:mybookstore/features/user/data/models/admin_user_model.dart';

class AdminStoreModel extends AdminStoreEntity {
  const AdminStoreModel({required super.banner, required super.name, required super.slogan, required super.admin});

  factory AdminStoreModel.fromEntity(AdminStoreEntity entity) {
    return AdminStoreModel(
      banner: entity.banner,
      name: entity.name,
      slogan: entity.slogan,
      admin: entity.admin,
    );
  }

  Map<String, dynamic> toMap() {
    final adminModel = AdminUserModel.fromEntity(admin);
    return {
      'name': name,
      'slogan': slogan,
      'banner': banner,
      'admin': adminModel.toMap(),
    };
  }

  @override
  String toString() {
    return 'AdminStoreModel{name: $name, slogan: $slogan, banner: $banner, admin: $admin}';
  }
}
