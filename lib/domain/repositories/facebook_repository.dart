
import 'package:dartz/dartz.dart';
import 'package:postownik/domain/entities/fb_longlive_token_entity/fb_longlive_token_entity.dart';
import 'package:postownik/domain/entities/fb_pages_entity/fb_pages_entity.dart';
import 'package:postownik/domain/entities/fb_publish_post/fb_publish_post_entity.dart';


import '../failures/failures.dart';

abstract class FacebookRepository {
  Future<Either<Failure, FbLongliveTokenEntity>> getFacebookLongLiveTokenFromDatasource(String accessToken);
  Future<FbPagesEntity> getFbPagesFromDatasource(String accessToken);
  Future<dynamic> publishPostOnFbPage(String accessToken, String pageId, String message);
}
