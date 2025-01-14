import 'package:equatable/equatable.dart';

class AppInfo extends Equatable {
  const AppInfo({
    required this.buildNumber,
  });

  final String buildNumber;

  @override
  List<Object?> get props => [buildNumber];
}
