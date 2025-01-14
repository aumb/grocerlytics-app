import 'package:grocerlytics/features/common/models/session/session_model.dart';
import 'package:grocerlytics/features/sign_in/verify_otp_sign_in/data/verify_otp_sign_in_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VerifyOtpSignInUseCase {
  const VerifyOtpSignInUseCase({
    required this.verifyOtpSignInService,
  });

  final VerifyOtpSignInService verifyOtpSignInService;

  Future<SessionModel> run(String email, String otp) async {
    final result = await verifyOtpSignInService.run(email, otp);

    return SessionModel.fromResponse(result);
  }
}
