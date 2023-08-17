import 'package:equatable/equatable.dart';

class FbPagesEntity extends Equatable {
  final List<FbPageProperties> data;


  const FbPagesEntity({required this.data});

  @override
  List<Object?> get props => [data];
}

class FbPageProperties extends Equatable {
  final String name;
  final String pageAccessToken;
  final String id;
  final String picUrl;

  const FbPageProperties({
    required this.picUrl,
    required this.name,
    required this.pageAccessToken,
    required this.id,
  });

  @override
  List<Object?> get props => [name, pageAccessToken, id];
}

class FbPagePicture extends Equatable {
  final String url;

  const FbPagePicture({required this.url});

  @override
  List<Object?> get props => [url];
}

