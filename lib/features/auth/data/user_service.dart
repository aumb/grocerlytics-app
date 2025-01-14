import 'dart:convert';

import 'package:grocerlytics/features/auth/models/user.dart';
import 'package:grocerlytics/features/common/services/network_module.dart';
import 'package:grocerlytics/features/common/services/network_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserService {
  const UserService(
    this.service,
  );

  final NetworkService service;

  Future<User> run() async {
    final result = await service.get(
      '${NetworkModule.auth.path}/user',
      requiresAuth: true,
    );
    final decodedResult = jsonDecode(result.data);

    return User.fromJson(decodedResult ?? {});
  }
}
