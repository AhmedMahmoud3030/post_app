import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/core/error/failures.dart';
import 'package:post_app/features/posts/domain/entities/post.dart';
import 'package:post_app/features/posts/domain/usecases/add_post.dart';
import 'package:post_app/features/posts/domain/usecases/update_post.dart';

import '../../../../core/strings/failure_strings.dart';
import '../../../../core/strings/message.dart';
import '../../domain/usecases/delete_post.dart';

part 'change_post_event.dart';
part 'change_post_state.dart';

class ChangePostBloc extends Bloc<ChangePostEvent, ChangePostState> {
  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;
  ChangePostBloc({
    required this.addPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super(ChangePostInitial()) {
    on<ChangePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingChangePostState());
        final either = await addPostUseCase(event.post);
        either.fold(
            (l) => emit(ErrorChangePostState(message: _mapFailureToMessage(l))),
            (_) => emit(
                const SuccessChangePostState(message: ADD_SUCCESS_MESSAGE)));
      } else if (event is UpdatePostEvent) {
        emit(LoadingChangePostState());
        final either = await updatePostUseCase(event.post);
        either.fold(
            (l) => emit(ErrorChangePostState(message: _mapFailureToMessage(l))),
            (_) => emit(
                const SuccessChangePostState(message: UPDATE_SUCCESS_MESSAGE)));
      } else if (event is DeletePostEvent) {
        emit(LoadingChangePostState());
        final either = await deletePostUseCase(event.postId);
        either.fold(
            (l) => emit(ErrorChangePostState(message: _mapFailureToMessage(l))),
            (_) => emit(
                const SuccessChangePostState(message: DELETE_SUCCESS_MESSAGE)));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return 'UnExpected Error please try again later';
    }
  }
}
