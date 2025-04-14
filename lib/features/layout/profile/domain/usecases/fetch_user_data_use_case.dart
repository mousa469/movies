import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/profile/domain/entities/user_profile_entity.dart';
import 'package:movies/features/layout/profile/domain/repositories/profile_repo.dart';

class FetchUserDataUseCase {
  ProfileRepo profileRepo;
  FetchUserDataUseCase({required this.profileRepo});
  Future<Either<Failure, UserProfileEntity>> call() async {
    return await profileRepo.fetchUserData();
  }
}
