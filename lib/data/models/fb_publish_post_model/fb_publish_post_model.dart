import 'package:equatable/equatable.dart';
import 'package:postownik/domain/entities/fb_publish_post/fb_publish_post_entity.dart';

class FbPublishPostModel extends FbPublishPostEntity with EquatableMixin {
  FbPublishPostModel(
      {required String message,
      required String pageId,
      required String pageAccessToken})
      : super(
            message: message,
            pageId: pageId,
            pageAccessToken: pageAccessToken);

  Map<String, dynamic> toMap() {
    return {
      'message': this.message,
      'pageId': this.pageId,
      'pageAccessToken': this.pageAccessToken,
    };
  }

  factory FbPublishPostModel.fromMap(Map<String, dynamic> map) {
    return FbPublishPostModel(
      message: map['message'] as String,
      pageId: map['pageId'] as String,
      pageAccessToken: map['pageAccessToken'] as String,
    );
  }
}
