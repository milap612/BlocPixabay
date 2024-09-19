import 'package:flutter/material.dart';
import 'package:pixabay/presentation/pages/full_screen_image_page.dart';
import '../data/mdel/image_model.dart';
import '../presentation/pages/gallery_page.dart';

class AppRouteInformationParser extends RouteInformationParser<RouteSettings> {
  @override
  Future<RouteSettings> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    if (uri.pathSegments.isEmpty) {
      return const RouteSettings(name: '/');
    }

    if (uri.pathSegments.first == 'image' && uri.queryParameters.containsKey('id')) {
      final image = ImageModel(
        id: int.parse(uri.queryParameters['id']!),
        webformatURL: uri.queryParameters['webformatURL']!,
        largeImageURL: uri.queryParameters['largeImageURL']!,
        likes: int.parse(uri.queryParameters['likes']!),
        views: int.parse(uri.queryParameters['views']!),
      );
      return RouteSettings(name: '/image', arguments: image);
    }

    return const RouteSettings(name: '/');
  }

  @override
  RouteInformation? restoreRouteInformation(RouteSettings configuration) {
    if (configuration.name == '/') {
      return const RouteInformation(location: '/');
    }

    if (configuration.name == '/image' && configuration.arguments is ImageModel) {
      final image = configuration.arguments as ImageModel;
      return RouteInformation(
        location: '/image?id=${image.id}&webformatURL=${image.webformatURL}&largeImageURL=${image.largeImageURL}&likes=${image.likes}&views=${image.views}',
      );
    }

    return null;
  }
}

class AppRouterDelegate extends RouterDelegate<RouteSettings>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteSettings> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String? selectedImageId;
  ImageModel? selectedImage;

  AppRouterDelegate() : selectedImageId = null;

  @override
  RouteSettings? get currentConfiguration {
    if (selectedImage != null) {
      return RouteSettings(
        name: '/image',
        arguments: selectedImage,
      );
    }
    return const RouteSettings(name: '/');
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: GalleryPage(
            onImageTapped: (image) {
              selectedImage = image;
              notifyListeners();
            },
          ),
        ),
        if (selectedImage != null)
          MaterialPage(
            child: FullScreenImagePage(image: selectedImage!),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;

        selectedImage = null;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouteSettings configuration) async {
    if (configuration.name == '/') {
      selectedImage = null;
    } else if (configuration.name == '/image' && configuration.arguments is ImageModel) {
      selectedImage = configuration.arguments as ImageModel;
    }
  }
}
