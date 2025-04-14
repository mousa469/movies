import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/profile/domain/repositories/profile_repo.dart';

class LogOutUseCase {
  ProfileRepo profileRepo;
  LogOutUseCase({required this.profileRepo});
  Future<Either<Failure, void>> call() {
    return profileRepo.logOut();
  }
}
