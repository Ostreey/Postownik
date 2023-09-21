import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:postownik/domain/repositories/facebook_repository.dart';
import 'package:postownik/domain/usecases/ai_content_usecase.dart';
import 'package:postownik/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injection.dart';
import '../../core/constants.dart';

part 'generate_post_provider.g.dart';

final sharedPreferencesProvider =
    FutureProvider.autoDispose<SharedPreferences>((ref) async {
  final preffs = await SharedPreferences.getInstance();
  final userPicUrl =
      preffs.getString(Constants.preffsFbManagedPagePicUrl) ?? '';
  final pageName = preffs.getString(Constants.preffsFbManagedPageName) ?? '';
  ref.read(pageNameProvider.notifier).state = pageName;
  ref.read(userPicUrlProvider.notifier).state = userPicUrl;
  debugPrint("sharedPreferencesProvider: ${pageName}");
  return preffs;
});

@Riverpod(keepAlive: true)
class pageName extends _$pageName {
  @override
  String build() => '';
}

@Riverpod(keepAlive: true)
class userPicUrl extends _$userPicUrl {
  @override
  String build() => '';
}

@riverpod
class publishOnFbPage extends _$publishOnFbPage {
  @override
  Future<dynamic> build() {
    return Future.value();
  }

  Future<void> publish(String postContent) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final FacebookRepository repository = sl();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken =
          prefs.getString(Constants.preffsFbManagedPageAccessToken) ?? '';
      String pageId = prefs.getString(Constants.preffsFbManagedPageId) ?? '';
      debugPrint("PUBLISH TEST: $postContent");
      final response = await repository.publishPostOnFbPage(
          accessToken, pageId, postContent);
      return response;
    });
  }
}

@Riverpod(keepAlive: true)
class postMessage extends _$postMessage {
  @override
  String build() => '';
}

@riverpod
class prompt extends _$prompt {
  @override
  FutureOr<String> build() => '';

  Future<void> generate(String prompt) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
     final response = AiContentUseCase().generateText(prompt);
      return response;
    });
  }
}
