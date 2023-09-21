// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facebook_login_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$longLiveTokenHash() => r'7d15f1992d3587e5249357c3e8342ee081b84cd6';

/// See also [longLiveToken].
@ProviderFor(longLiveToken)
final longLiveTokenProvider =
    AutoDisposeAsyncNotifierProvider<longLiveToken, void>.internal(
  longLiveToken.new,
  name: r'longLiveTokenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$longLiveTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$longLiveToken = AutoDisposeAsyncNotifier<void>;
String _$fbLoginHash() => r'f1d116c4878188581ba0c089f608b6b9f93f5cfb';

/// See also [FbLogin].
@ProviderFor(FbLogin)
final fbLoginProvider =
    AutoDisposeAsyncNotifierProvider<FbLogin, LoginResult>.internal(
  FbLogin.new,
  name: r'fbLoginProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fbLoginHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FbLogin = AutoDisposeAsyncNotifier<LoginResult>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
