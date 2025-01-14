import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.aud,
    required this.role,
    required this.email,
    this.emailConfirmedAt,
    this.invitedAt,
    required this.phone,
    this.phoneConfirmedAt,
    this.confirmationSentAt,
    this.recoverySentAt,
    this.emailChange,
    this.emailChangeSentAt,
    this.phoneChange,
    this.phoneChangeSentAt,
    this.reauthenticationSentAt,
    this.lastSignInAt,
    required this.appMetadata,
    required this.userMetadata,
    this.factors,
    required this.identities,
    required this.createdAt,
    required this.updatedAt,
    this.bannedUntil,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      aud: json['aud'] as String,
      role: json['role'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      lastSignInAt: json['last_sign_in_at'] == null
          ? null
          : DateTime.parse(json['last_sign_in_at'] as String),
      appMetadata: json['app_metadata'] as Map<String, dynamic>,
      userMetadata: json['user_metadata'] as Map<String, dynamic>,
      identities: (json['identities'] as List<dynamic>)
          .map((e) => Identity.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      emailConfirmedAt: json['email_confirmed_at'] == null
          ? null
          : DateTime.parse(json['email_confirmed_at'] as String),
      invitedAt: json['invited_at'] == null
          ? null
          : DateTime.parse(json['invited_at'] as String),
      phoneConfirmedAt: json['phone_confirmed_at'] == null
          ? null
          : DateTime.parse(json['phone_confirmed_at'] as String),
      confirmationSentAt: json['confirmation_sent_at'] == null
          ? null
          : DateTime.parse(json['confirmation_sent_at'] as String),
      recoverySentAt: json['recovery_sent_at'] == null
          ? null
          : DateTime.parse(json['recovery_sent_at'] as String),
      emailChange: json['email_change'] as String?,
      emailChangeSentAt: json['email_change_sent_at'] == null
          ? null
          : DateTime.parse(json['email_change_sent_at'] as String),
      phoneChange: json['phone_change'] as String?,
      phoneChangeSentAt: json['phone_change_sent_at'] == null
          ? null
          : DateTime.parse(json['phone_change_sent_at'] as String),
      reauthenticationSentAt: json['reauthentication_sent_at'] == null
          ? null
          : DateTime.parse(json['reauthentication_sent_at'] as String),
      factors: (json['factors'] as List<dynamic>?)
          ?.map((e) => Factor.fromJson(e as Map<String, dynamic>))
          .toList(),
      bannedUntil: json['banned_until'] == null
          ? null
          : DateTime.parse(json['banned_until'] as String),
    );
  }

  final String id;
  final String aud;
  final String role;
  final String email;
  final DateTime? emailConfirmedAt;
  final DateTime? invitedAt;
  final String phone;
  final DateTime? phoneConfirmedAt;
  final DateTime? confirmationSentAt;
  final DateTime? recoverySentAt;
  final String? emailChange;
  final DateTime? emailChangeSentAt;
  final String? phoneChange;
  final DateTime? phoneChangeSentAt;
  final DateTime? reauthenticationSentAt;
  final DateTime? lastSignInAt;
  final Map<String, dynamic> appMetadata;
  final Map<String, dynamic> userMetadata;
  final List<Factor>? factors;
  final List<Identity> identities;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? bannedUntil;

  @override
  List<Object?> get props => [
        id,
        aud,
        role,
        email,
        emailConfirmedAt,
        invitedAt,
        phone,
        phoneConfirmedAt,
        confirmationSentAt,
        recoverySentAt,
        emailChange,
        emailChangeSentAt,
        phoneChange,
        phoneChangeSentAt,
        reauthenticationSentAt,
        lastSignInAt,
        appMetadata,
        userMetadata,
        factors,
        identities,
        createdAt,
        updatedAt,
        bannedUntil,
      ];
}

class Factor extends Equatable {
  const Factor({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.factorType,
    this.friendlyName,
  });

  final String id;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String factorType;
  final String? friendlyName;

  // Factory constructor to create a Factor object from a JSON map
  factory Factor.fromJson(Map<String, dynamic> json) {
    return Factor(
      id: json['id'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      factorType: json['factorType'] as String,
      friendlyName: json['friendlyName'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        status,
        createdAt,
        updatedAt,
        factorType,
        friendlyName,
      ];
}

class Identity extends Equatable {
  const Identity({
    required this.id,
    required this.userId,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
    this.lastSignInAt,
    this.identityData,
  });

  factory Identity.fromJson(Map<String, dynamic> json) {
    return Identity(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      provider: json['provider'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      lastSignInAt: json['last_sign_in_at'] != null
          ? DateTime.parse(json['last_sign_in_at'] as String)
          : null,
      identityData: json['identity_data'] as Map<String, dynamic>?,
    );
  }

  final String id;
  final String userId;
  final String provider;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastSignInAt;
  final Map<String, dynamic>? identityData;

  @override
  List<Object?> get props => [
        id,
        userId,
        provider,
        createdAt,
        updatedAt,
        lastSignInAt,
        identityData,
      ];
}
