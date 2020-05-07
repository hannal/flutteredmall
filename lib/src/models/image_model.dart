
class ImageModel {
 int id;
 String url;
 String title;
 String thumbnailUrl;

 ImageModel({this.id, this.url, this.title, this.thumbnailUrl});

 factory ImageModel.fromJson(Map<String, dynamic> json) {
  return ImageModel(
   id: json['id'],
   url: json['url'],
   title: json['title'],
   thumbnailUrl: json['thumbnailUrl'],
  );
 }

 @override
 String toString() => '$id,$url';
}
