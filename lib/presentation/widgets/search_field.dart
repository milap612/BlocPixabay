import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/gallery_bloc.dart';
import '../../bloc/gallery_event.dart';
import 'package:rxdart/rxdart.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  SearchFieldState createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchField> {
  final _debounce = BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();

    _debounce.stream
        .debounceTime(const Duration(milliseconds: 500))
        .listen((query) {
      if (query.isNotEmpty && context.mounted) {
          BlocProvider.of<GalleryBloc>(context)
              .add(FetchImages(query: query, page: 1));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          _debounce.add(value);
        },
        decoration: const InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce.close();
    super.dispose();
  }
}
