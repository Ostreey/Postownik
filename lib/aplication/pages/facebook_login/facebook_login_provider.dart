import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:postownik/aplication/core/constants.dart';
import 'package:postownik/domain/entities/fb_longlive_token_entity/fb_longlive_token_entity.dart';
import 'package:postownik/domain/entities/fb_user_data_entity/fb_user_data_entity.dart';
import 'package:postownik/domain/repositories/facebook_repository.dart';
import 'package:postownik/data/datasources/remote_datasource.dart';
import 'package:postownik/data/repositories/repo_impl.dart';
import 'package:postownik/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'facebook_login_provider.g.dart';

@riverpod
class longLiveToken extends _$longLiveToken {
  @override
  FutureOr<void> build() => const FbLongliveTokenEntity(
      accessToken: 'accessToken', tokenType: 'tokenType', expiresIn: 0);

  Future<void> get() async {
    state = const AsyncLoading();
    final FacebookRepository repository = sl();
    late String accessToken;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      accessToken = prefs.getString(Constants.preffsFbAccessToken) ?? '';
    } catch (e) {
      debugPrint(e.toString());
    }
    final failureOrSuccess =
        await repository.getFacebookLongLiveTokenFromDatasource(accessToken);
    state = failureOrSuccess.fold(
      (failure) => AsyncError(failure, StackTrace.empty),
      (success) => AsyncData(success),
    );
  }
}

@riverpod
class FbLogin extends _$FbLogin {
  @override
  FutureOr<LoginResult> build() => LoginResult(status: LoginStatus.success);

  Future<void> login() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final LoginResult result = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      final FbUserDataEntity fbUserDataEntity = FbUserDataEntity(
          picUrl: userData['picture']['data']['url'],
          name: userData['name'],
          picHeight: 'picHeight',
          picWidth: 'picWidth');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      debugPrint(fbUserDataEntity.picUrl);

      final facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      final firebaseResult = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      debugPrint("Login to firebase succesful");
      final userUuid = FirebaseAuth.instance.currentUser!.uid;
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userUuid);

      final userSnapshot = await userDoc.get();
      if (!userSnapshot.exists) {
        debugPrint("User created");
        final Map<String, dynamic> facebookPages = {
        };

        userDoc.set({
          'name': fbUserDataEntity.name,
          'picUrl': fbUserDataEntity.picUrl,
          'email': firebaseResult.user!.email,
          "credits": 10,
          'facebookPages': facebookPages,
        });
      }

      prefs.setString(Constants.preffsFbAccessToken, result.accessToken!.token);
      prefs.setString(Constants.preffsFbUserId, result.accessToken!.userId!);
      prefs.setString(Constants.preffsFbUserName, fbUserDataEntity.name);
      prefs.setString(Constants.preffsFbUserPicUrl, fbUserDataEntity.picUrl);
      prefs.setString(Constants.preffsFireStoreUserUuid, userUuid);

      return result;
    });
  }
}
