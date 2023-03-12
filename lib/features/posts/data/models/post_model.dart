import 'package:post_app/features/posts/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({required super.id, required super.title, required super.subTitle});
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      PostModel(id: json['id'], title: json['title'], subTitle: json['body']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': subTitle,
    };
  }
}
