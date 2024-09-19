import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pixabay/router/app_router.dart';
import 'bloc/gallery_bloc.dart';
import 'data/api/pixabay_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/image_repository.dart';

void main() {
  final dio = Dio();
  final pixabayApi = PixabayApi(dio);
  final imageRepository = ImageRepository(pixabayApi);

  runApp(MyApp(imageRepository: imageRepository));
}

class MyApp extends StatelessWidget {
  final ImageRepository imageRepository;

  const MyApp({super.key, required this.imageRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryBloc(repository: imageRepository),
      child: MaterialApp.router(
        routerDelegate: AppRouterDelegate(),
        routeInformationParser: AppRouteInformationParser(),
      ),
    );
  }
}
