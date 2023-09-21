import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:postownik/aplication/core/constants.dart';
import 'package:postownik/aplication/pages/generate_post/generate_post_provider.dart';
import 'package:postownik/domain/entities/fb_pages_entity/fb_pages_entity.dart';
import 'package:postownik/domain/repositories/facebook_repository.dart';
import 'package:postownik/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'facebook_pages_provider.g.dart';

@riverpod
Future<FbPagesEntity> facebookPages(FacebookPagesRef ref) async {
  final FacebookRepository repository = sl();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString(Constants.preffsFbAccessToken) ?? '';
  final facebookPages = await repository.getFbPagesFromDatasource(accessToken);
  return facebookPages;
}

@riverpod
class saveToSharedPreffsTwo extends _$saveToSharedPreffsTwo {
  @override
  FutureOr<void> build() {
  }
  Future<void> execute(FbPageProperties page) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      debugPrint("saveToSharedPreffsTwo: ${page.name}");
      final preffs = await SharedPreferences.getInstance();
      preffs.setString(Constants.preffsFbManagedPageId, page.id);
      preffs.setString(Constants.preffsFbManagedPageName, page.name);
      preffs.setString(Constants.preffsFbManagedPagePicUrl, page.picUrl);
    });
  }
}
