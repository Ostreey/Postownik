import 'package:postownik/env/env.dart';

class Endpoints {
  static  String get _APP_ID => Env.fbAppId;
  static  String get _APP_SECRET => Env.fbSecret;
  static const String _BASE_URL = "https://graph.facebook.com";

  static const String PAGES = '$_BASE_URL/me/accounts?fields=name,access_token,picture&access_token=';
  static String LONGLIVE_ACCESS_TOKEN =
      "$_BASE_URL/oauth/access_token?grant_type=fb_exchange_token&client_id=$_APP_ID&client_secret=$_APP_SECRET&fb_exchange_token=";
  static const String PUBLISH_POST = "$_BASE_URL/";
}
