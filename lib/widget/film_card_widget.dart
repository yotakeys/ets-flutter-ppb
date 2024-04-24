import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ets_flutter_ppb/model/film.dart';

final _lightColors = [
  Colors.black,
];

class FilmCardWidget extends StatelessWidget {
  const FilmCardWidget({
    Key? key,
    required this.film,
    required this.index,
  }) : super(key: key);

  final Film film;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(film.createdTime);

    return Card(
      color: color,
      child: Container(
        constraints: const BoxConstraints(minHeight: 250, maxHeight: 300),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              film.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.network(
              film.gambar,
              width: 200,
              height: 200,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error_outline, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
