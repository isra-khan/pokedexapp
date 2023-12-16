import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  bool isFavorite;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Pokemon copyWith({
    int? id,
    String? name,
    String? imageUrl,
    required bool? isFavorite,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, isFavorite];
}
