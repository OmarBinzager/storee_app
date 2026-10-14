import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/store_profile.dart';

abstract class SettingsRepository {
  Future<Either<Failure, StoreProfile>> getStoreProfile();
  Future<Either<Failure, Unit>> saveStoreProfile(StoreProfile profile);
}
