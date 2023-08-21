
import 'package:postownik/env/env.dart';

class Constants{
  static  String get openAiApiKey => Env.openAiKey;
    static const String preffsFbAccessToken = 'FB_ACCESS_TOKEN';
  static const String preffsFbUserId = 'FB_USER_ID';
  static const String preffsFbUserPicUrl = 'FB_USER_PIC_URL';
  static const String preffsFbUserName = 'FB_USER_NAME';

  //PAGES
  static const String preffsFbManagedPageName = 'FB_MANAGED_PAGE_NAME';
  static const String preffsFbManagedPagePicUrl = 'FB_MANAGED_PAGE_PIC_URL';
  static const String preffsFbManagedPageId = 'FB_MANAGED_PAGE_ID';
  static const String preffsFbManagedPageAccessToken = 'FB_MANAGED_ACCESS_TOKEN';
}
