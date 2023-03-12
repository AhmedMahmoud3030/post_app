import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:post_app/core/network/network_info.dart';
import 'package:post_app/features/posts/data/datasources/post_local_data_source.dart';
import 'package:post_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:post_app/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:post_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:post_app/features/posts/presentation/bloc/change_post_bloc.dart';
import 'package:post_app/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:post_app/features/posts/presentation/pages/posts_page.dart';
import 'core/ingection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.sl<ChangePostBloc>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PostsPage();
  }
}
