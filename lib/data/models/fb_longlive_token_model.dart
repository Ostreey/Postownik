
import 'package:equatable/equatable.dart';
import 'package:postownik/domain/entities/fb_longlive_token_entity/fb_longlive_token_entity.dart';

class FbLongliveTokenModel extends FbLongliveTokenEntity with EquatableMixin{
  FbLongliveTokenModel({required super.accessToken, required super.tokenType, required super.expiresIn});

  factory FbLongliveTokenModel.fromJson(Map<String, dynamic> json) {
    return FbLongliveTokenModel(accessToken: json['access_token'], tokenType: json['token_type'], expiresIn: json['expires_in']);
  }
}