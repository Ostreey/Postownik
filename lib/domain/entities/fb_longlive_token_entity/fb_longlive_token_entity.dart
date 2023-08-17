import 'package:equatable/equatable.dart';

class FbLongliveTokenEntity extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  const FbLongliveTokenEntity(
      {required this.accessToken, required this.tokenType,required this.expiresIn});

  @override
  List<Object?> get props => [accessToken, tokenType, expiresIn];
}
