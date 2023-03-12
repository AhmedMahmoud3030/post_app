import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:post_app/core/network/network_info.dart';
import 'package:post_app/features/posts/data/datasources/post_local_data_source.dart';
import 'package:post_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:post_app/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:post_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:post_app/features/posts/domain/usecases/add_post.dart';
import 'package:post_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:post_app/features/posts/presentation/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/posts/domain/usecases/delete_post.dart';
import '../features/posts/domain/usecases/update_post.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Feature Posts
//?bloc
  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(() => ChangePostBloc(
        addPostUseCase: sl(),
        deletePostUseCase: sl(),
        updatePostUseCase: sl(),
      ));
//?usecases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
//?repository
  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localDataSource: sl(),
    ),
  );
//?datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

//!core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
//!external
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
