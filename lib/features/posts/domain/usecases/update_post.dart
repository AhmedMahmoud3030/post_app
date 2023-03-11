import 'package:dartz/dartz.dart';
import 'package:post_app/features/posts/domain/entities/post.dart';

import '../../../../core/error/failures.dart';
import '../repositories/posts_repository.dart';

class UpdatePostUseCase {
  final PostsRepository repository;

  UpdatePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
