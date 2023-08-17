
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:postownik/data/models/fb_publish_post_model/fb_publish_post_model.dart';
import 'package:postownik/domain/entities/fb_longlive_token_entity/fb_longlive_token_entity.dart';
import 'package:postownik/domain/entities/fb_pages_entity/fb_pages_entity.dart';
import 'package:postownik/domain/entities/fb_publish_post/fb_publish_post_entity.dart';

import 'package:postownik/domain/failures/failures.dart';
import 'package:postownik/domain/repositories/facebook_repository.dart';
import 'package:postownik/data/datasources/remote_datasource.dart';

import '../exceptions/exceptions.dart';

class RepoImpl implements FacebookRepository {
  RepoImpl({required this.remoteDatasource});
  final RemoteDatasource remoteDatasource;

  @override
  Future<Either<Failure, FbLongliveTokenEntity>> getFacebookLongLiveTokenFromDatasource(String accessToken) async {
    try {
      final result = await remoteDatasource.getLongLiveAccessTokenFromApi(accessToken);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e, stiacktrace) {
      debugPrint(e.toString());
      debugPrint(stiacktrace.toString());
      return left(GeneralFailure());
    }
  }

  @override
  Future<FbPagesEntity> getFbPagesFromDatasource(String accessToken) async {
    try {
      final result = await remoteDatasource.getPagesFromApi(accessToken);
      return result;
    } on ServerException catch (_) {
      throw ServerFailure();
    } catch (e) {
      throw GeneralFailure();
    }
  }

  @override
  Future<dynamic> publishPostOnFbPage(String pageAccessToken, String pageId, String message) async{
    try {
      final model = FbPublishPostModel(message: message, pageId: pageId, pageAccessToken: pageAccessToken);
      final result = await remoteDatasource.postPublishPostOnFbPage(model);
      return result;
    } on ServerException catch (_) {
      throw ServerFailure();
    } catch (e) {
      throw GeneralFailure();
    }
  }
}
