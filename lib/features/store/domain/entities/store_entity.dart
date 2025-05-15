import 'package:equatable/equatable.dart';

class StoreEntity extends Equatable {
  final int? id;
  final String banner;
  final String name;
  final String slogan;

  const StoreEntity({
    this.id,
    required this.banner,
    required this.name,
    required this.slogan,
  });

  @override
  List<Object?> get props => [banner, id, name, slogan];
}
