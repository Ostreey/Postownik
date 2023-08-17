import 'package:equatable/equatable.dart';

class FbUserDataEntity extends Equatable {
  final String name ;
  final String picHeight;
  final String picWidth;
  final String picUrl;

  const FbUserDataEntity(
      {required this.picUrl,required this.name, required this.picHeight,required this.picWidth});

  @override
  List<Object?> get props => [name, picHeight, picWidth,picUrl];
}
