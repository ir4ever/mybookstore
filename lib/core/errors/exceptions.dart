import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];

  @override
  String toString() => message;
}

class SimpleException extends Equatable implements Exception {
  final String message;

  const SimpleException({required this.message});

  @override
  List<Object?> get props => [message];
}
