import 'package:dartz/dartz.dart';
import 'package:movies/core/services/failure.dart';
import 'package:movies/features/layout/profile/domain/repositories/profile_repo.dart';

class UpdateUserDataUseCase {
  ProfileRepo profileRepo;
  UpdateUserDataUseCase({required this.profileRepo});

  Future<Either<Failure, void>> call({String  ? userName , String ? userPhone})  async{
    return await  profileRepo.updateUserData(userName: userName ,  userPhone:userPhone );
  }
}
