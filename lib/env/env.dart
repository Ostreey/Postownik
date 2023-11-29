// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'locks.env')
abstract class Env {
  @EnviedField(varName: 'openAiKey', obfuscate: true)
   static String openAiKey = _Env.openAiKey;
  @EnviedField(varName: 'fbAppId', obfuscate: true)
  static String fbAppId = _Env.fbAppId;
  @EnviedField(varName: 'fbSecret', obfuscate: true)
  static String fbSecret = _Env.fbSecret;
}