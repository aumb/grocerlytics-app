import 'package:grocerlytics/features/auth/data/user_service.dart';
import 'package:grocerlytics/features/auth/models/user.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserUseCase {
  const GetUserUseCase({
    required this.userService,
  });

  final UserService userService;

  Future<User> run() => userService.run();
}
