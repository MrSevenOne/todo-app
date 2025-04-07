class ImageModel {
  final String imageUrl;

  ImageModel({required this.imageUrl});

  factory ImageModel.fromJson(String url) {
    return ImageModel(imageUrl: url);
  }
}
