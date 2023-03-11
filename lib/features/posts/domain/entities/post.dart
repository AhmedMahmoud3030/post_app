import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String subTitle;

  const Post({required this.id, required this.title, required this.subTitle});

  @override
  List<Object?> get props => [id, title, subTitle];
}
