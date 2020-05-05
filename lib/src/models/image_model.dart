
class ImageModel {
 int id;
 String url;
 String title;

 ImageModel({this.id, this.url, this.title});

 factory ImageModel.fromJson(Map<String, dynamic> json) {
  return ImageModel(
   id: json['id'],
   url: json['url'],
   title: json['title'],
  );
 }

 @override
 String toString() => '$id,$url';
}
