part of 'change_post_bloc.dart';

abstract class ChangePostState extends Equatable {
  const ChangePostState();

  @override
  List<Object> get props => [];
}

class ChangePostInitial extends ChangePostState {}

class LoadingChangePostState extends ChangePostState {}

class SuccessChangePostState extends ChangePostState {
  final String message;

  const SuccessChangePostState({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorChangePostState extends ChangePostState {
  final String message;

  const ErrorChangePostState({required this.message});

  @override
  List<Object> get props => [message];
}
