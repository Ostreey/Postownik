import 'package:equatable/equatable.dart';

import 'package:postownik/domain/entities/fb_pages_entity/fb_pages_entity.dart';

class FbPagesModel extends FbPagesEntity with EquatableMixin {
  FbPagesModel({required List<FbPagePropertiesModel> data})
      : super(data: data);

  factory FbPagesModel.fromJson(Map<String, dynamic> json) {
    final List<FbPagePropertiesModel> pagePropertiesList = (json['data'] as List)
        .map((pageJson) => FbPagePropertiesModel.fromJson(pageJson))
        .toList();
    return FbPagesModel(data: pagePropertiesList);
  }
}

class FbPagePropertiesModel extends FbPageProperties with EquatableMixin {
  FbPagePropertiesModel({
    required String name,
    required String pageAccessToken,
    required String id,
    required String picUrl,
  }) : super(name: name, pageAccessToken: pageAccessToken, id: id, picUrl: picUrl);

  factory FbPagePropertiesModel.fromJson(Map<String, dynamic> json) {
    return FbPagePropertiesModel(
      name: json['name'],
      pageAccessToken: json['access_token'],
      id: json['id'],
      picUrl: json['picture']['data']['url']?? '',
    );
  }
}




