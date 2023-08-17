

import 'package:equatable/equatable.dart';

class FbPublishPostEntity extends Equatable{
  final String message;
  final String pageId;
  final String pageAccessToken;

  const FbPublishPostEntity({
    required this.message,
    required this.pageId,
    required this.pageAccessToken,
  });

  @override
  List<Object?> get props => [message, pageId, pageAccessToken];
}