import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay/presentation/widgets/search_field.dart';
import '../../bloc/gallery_bloc.dart';
import '../../bloc/gallery_event.dart';
import '../../bloc/gallery_state.dart';
import '../../data/mdel/image_model.dart';
import '../widgets/image_grid.dart';

class GalleryPage extends StatefulWidget {
  final void Function(ImageModel image) onImageTapped;

  const GalleryPage({super.key, required this.onImageTapped});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final String _query = 'nature'; // Default search query
  int _page = 1; // Default page for pagination
  late ScrollController _scrollController;
  bool _isFetching = false;

  @override
  void initState() {
    // Dispatch initial FetchImages event when the screen is first loaded
    context.read<GalleryBloc>().add(FetchImages(query: _query, page: _page));
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      // User has scrolled to the bottom, fetch the next page
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if(!_isFetching){
          _isFetching = true;
          _page++;
          context.read<GalleryBloc>().add(FetchImages(query: _query, page: _page));
        }
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchField(),
          ),
          Expanded(
            child: BlocConsumer<GalleryBloc, GalleryState>(
              listener: (context, state) {
                if (state is GalleryLoaded) {
                  _isFetching = false; // Reset the fetching flag after loading new data
                }
              },
              builder: (context, state) {
                if (state is GalleryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GalleryLoaded) {
                  return ImageGrid(
                    images: state.images,
                    onImageTapped: widget.onImageTapped,
                    scrollController: _scrollController,
                  );
                } else if (state is GalleryError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const Center(child: Text('No Images'));
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
