import 'dart:convert';
import 'package:postownik/aplication/core/my_http_client.dart';
import 'package:postownik/data/endpoints/facebook_endpoints.dart';
import 'package:postownik/data/models/fb_longlive_token_model.dart';
import 'package:postownik/data/models/fb_pages_model/fb_pages_model.dart';
import 'package:postownik/data/models/fb_publish_post_model/fb_publish_post_model.dart';
import 'package:postownik/domain/entities/fb_publish_post/fb_publish_post_entity.dart';
abstract class
RemoteDatasource {
  Future<FbLongliveTokenModel> getLongLiveAccessTokenFromApi(String accessToken);
  Future<FbPagesModel> getPagesFromApi(String accessToken);
  Future<dynamic> postPublishPostOnFbPage(FbPublishPostModel postModel);
}

class RemoteDatasourceImpl implements RemoteDatasource {
  final MyHttpClient client;


  RemoteDatasourceImpl({required this.client});

  @override
  Future<FbLongliveTokenModel> getLongLiveAccessTokenFromApi(
      String accessToken) async {
    final response = await client.get(Endpoints.LONGLIVE_ACCESS_TOKEN + accessToken);
    return FbLongliveTokenModel.fromJson(jsonDecode(response));
  }


  @override
  Future<FbPagesModel> getPagesFromApi(String accessToken) async {
    final response = await client.get(Endpoints.PAGES + accessToken);
    return FbPagesModel.fromJson(response);
  }

  @override
  Future<dynamic> postPublishPostOnFbPage(FbPublishPostModel postModel) async {
    final http = client.client;
    final response = await http.post(
      Uri.parse(Endpoints.PUBLISH_POST + postModel.pageId + '/feed'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'message': postModel.message,
        'access_token': postModel.pageAccessToken,
      },
    );

    if (response.statusCode == 200) {
      // Post published successfully
      print('Post published successfully');
    } else {
      // Handle error
      print('Error publishing post: ${response.body}');
    }
  }
}

