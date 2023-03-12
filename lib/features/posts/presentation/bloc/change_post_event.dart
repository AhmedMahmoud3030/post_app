part of 'change_post_bloc.dart';

abstract class ChangePostEvent extends Equatable {
  const ChangePostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends ChangePostEvent {
  final Post post;

  const AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends ChangePostEvent {
  final Post post;

  const UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends ChangePostEvent {
  final int postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
