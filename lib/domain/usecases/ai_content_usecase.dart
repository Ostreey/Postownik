
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:postownik/data/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../aplication/core/constants.dart';
import '../../env/env.dart';

class AiContentUseCase{
  Future<String> generateText(String prompt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final firebaseUser = prefs.getString(Constants.preffsFireStoreUserUuid);
    final userDoc =
    FirebaseFirestore.instance.collection('users').doc(firebaseUser);

    final userSnapshot = await userDoc.get();
    final currentCredit = userSnapshot['credits'] ?? 0;
    if(currentCredit <= 0){
      throw InsufficientCreditFailure("Brak środków. Doładuj konto.");
    }

    String companySpecialization =
        prefs.getString(Constants.preffsCompanySpecialization) ?? 'przykladowa firma';
    String companyName = prefs.getString(Constants.preffsCompanyName) ?? 'nazwa firmy';

    final chat = OpenAI(apiKey: Env.openAiKey, temperature: 0.9);
    const template =
        'Jesteś profesjonalnym menadżerem mediów społecznościowych, '
        'Twoim klientem jest {company_specialization} o nazwie {company_name}.'
        ' Stworz gotowa do opublikowania tresc posta na media spolecznosciowe o tematyce:';
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
    debugPrint(aiMsg.content);

    if (userSnapshot.exists) {
      final currentCredit = userSnapshot['credits'] ?? 0;
      if (currentCredit > 0) {
        await userDoc.update({'credits': currentCredit - 1});
      }
    }
    return response;
  }
}