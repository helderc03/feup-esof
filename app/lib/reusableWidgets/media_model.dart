import 'package:flutter/material.dart';

class MediaModel{
  String mediaTitle;
  String mediaType;
  String? mediaReleaseYear;
  String poster;
  String description;
  double? rating;
  int? id;

  MediaModel(this.mediaTitle, this.mediaType, this.mediaReleaseYear, this.rating, this.poster, this.description, this.id);
}