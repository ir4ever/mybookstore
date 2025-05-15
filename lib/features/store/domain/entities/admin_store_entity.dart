import 'package:mybookstore/features/store/domain/entities/store_entity.dart';
import 'package:mybookstore/features/user/domain/entities/admin_user_entity.dart';

class AdminStoreEntity extends StoreEntity {
  final AdminUserEntity admin;
  const AdminStoreEntity(
      {super.id, required super.banner, required super.name, required super.slogan, required this.admin});

  @override
  List<Object?> get props => [banner, id, name, slogan, admin];
}
