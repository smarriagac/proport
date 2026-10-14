import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final dynamic cause;

  const Failure(this.message, [this.cause]);

  @override
  List<Object?> get props => [message, cause];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server Error', super.cause]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache / Storage Error', super.cause]);
}

class AssetLoadFailure extends Failure {
  const AssetLoadFailure([super.message = 'Asset loading failed', super.cause]);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure([super.message = 'Invalid Input', super.cause]);
}
