import 'package:grocerlytics/features/sign_in/data/sign_in_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInUseCase {
  const SignInUseCase({
    required this.signInService,
  });

  final SignInService signInService;

  Future<void> run(String email) => signInService.run(email);
}
