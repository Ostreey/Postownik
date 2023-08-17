
class Endpoints{
  static const String _APP_ID = "1041532580131425";
  static const String _APP_SECRET = "633109cf0add2722cbd8517679c1d622";
  static const String _BASE_URL = "https://graph.facebook.com";
  static const String PAGES = '$_BASE_URL/me/accounts?fields=name,access_token,picture&access_token=';
  static const String LONGLIVE_ACCESS_TOKEN =
      "$_BASE_URL/oauth/access_token?grant_type=fb_exchange_token&client_id=$_APP_ID&client_secret=$_APP_SECRET&fb_exchange_token=";
  static const String PUBLISH_POST = "$_BASE_URL/";
}