import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_app/modules/auth/login/domain/entities/user.dart';
import 'package:surf_app/modules/home/presenter/usecases/i_home_usercase.dart';

@Injectable()
class HomeUseCase extends IHomeUseCase {
  @override
  Future<Either<Exception, User>> getUserInfromations() {}
}
