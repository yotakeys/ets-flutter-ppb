import 'package:flutter/material.dart';

class FilmFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? gambar;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedGambar;

  const FilmFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.gambar = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedGambar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 16),
              buildGambar(),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );

  Widget buildGambar() => TextFormField(
        maxLines: 1,
        initialValue: gambar,
        style: const TextStyle(
          color: Colors.white70,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Gambar',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (gambar) => gambar != null && gambar.isEmpty
            ? 'The gambar cannot be empty'
            : null,
        onChanged: onChangedGambar,
      );
}
