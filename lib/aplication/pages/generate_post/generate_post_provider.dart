import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

part 'generate_post_provider.g.dart';

@riverpod
class response extends _$response {
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

      final chat = OpenAI(apiKey: Constants.key, temperature: 0.9);
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
