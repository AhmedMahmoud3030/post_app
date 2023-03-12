import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/core/error/failures.dart';
import 'package:post_app/core/strings/failure_strings.dart';
import 'package:post_app/features/posts/domain/entities/post.dart';
import 'package:post_app/features/posts/domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;
  PostsBloc({required this.getAllPostsUseCase}) : super(LoadingPostsState()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final either = await getAllPostsUseCase();

        either.fold(
            (l) => emit(ErrorPostsState(message: _mapFailureToMessage(l))),
            (r) => emit(LoadedPostsState(posts: r)));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final either = await getAllPostsUseCase();

        either.fold(
            (l) => emit(ErrorPostsState(message: _mapFailureToMessage(l))),
            (r) => emit(LoadedPostsState(posts: r)));
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
