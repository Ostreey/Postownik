import 'package:flutter/material.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:postownik/domain/repositories/facebook_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injection.dart';
import '../../core/constants.dart';

part 'generate_post_provider.g.dart';


final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  final preffs = await SharedPreferences.getInstance();
  final userPicUrl = preffs.getString(Constants.preffsFbManagedPagePicUrl) ?? '';
  final pageName = preffs.getString(Constants.preffsFbManagedPageName) ?? '';
  ref.read(pageNameProvider.notifier).state = pageName;
  ref.read(userPicUrlProvider.notifier).state = userPicUrl;
  return preffs;
});

@riverpod
class pageName extends _$pageName {
  @override
  String build() => '';
}

@riverpod
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

  Future<void> publish() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final FacebookRepository repository = sl();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString(Constants.preffsFbManagedPageAccessToken) ?? '';
      String pageId = prefs.getString(Constants.preffsFbManagedPageId) ?? '';
      final postContent = ref.watch(postMessageProvider);
      debugPrint ("PUBLISH TEST: $postContent");
      final response = await repository.publishPostOnFbPage(accessToken, pageId, postContent);
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String companySpecialization = prefs.getString('company_specialization') ?? 'przykladowa firma';
      String companyName = prefs.getString('company_name') ?? 'nazwa firmy';

      final chat = OpenAI(apiKey: Constants.openAiApiKey, temperature: 0.9);
      const template =
          'Jesteś profesjonalnym menadżerem mediów społecznościowych, Twoim klientem jest {company_specialization} o nazwie {company_name}.';
      final systemMessagePrompt =
          SystemChatMessagePromptTemplate.fromTemplate(template);
      const humanTemplate = '{text}';
      final humanMessagePrompt =
          HumanChatMessagePromptTemplate.fromTemplate(humanTemplate);

      final chatPrompt = ChatPromptTemplate.fromPromptMessages(
          [systemMessagePrompt, humanMessagePrompt]);
      final formattedPrompt = chatPrompt.formatPrompt({
        'company_specialization': companySpecialization,
        'company_name': companyName,
        'text': prompt
      }).toChatMessages();
      final aiMsg = await chat.predictMessages(formattedPrompt);
      final response = aiMsg.content.split("System: ")[0];
      print(response);
      return response;
    });
  }
}
