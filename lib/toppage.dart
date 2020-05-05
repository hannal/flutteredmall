
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './src/models/image_model.dart';

class TopPage extends StatefulWidget {
  TopPage({Key key, this.title}): super(key: key);

  final String title;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/photos';
  static const int _defaultLimit = 10;
  List<ImageModel> images = [];

  String buildUrl({int page=1, int limit=_defaultLimit}) {
    return '$_baseUrl?_page=$page&_limit=$limit';
  }

  Future<List<ImageModel>> fetchImages({int page, int limit}) async {
    final response = await http.get(buildUrl(page: page, limit: limit));
    List<dynamic> items = json.decode(response.body);
    List<ImageModel> result = [];

    items.forEach((dynamic item) {
      result.add(ImageModel.fromJson(item));
    });
    return Future.value(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: this.fetchImages(),
                builder: (context, snapshot) {
                  return ImageList(snapshot.data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  ImageList(this.images);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: images.length,
      itemBuilder: (context, int index) {
        var image = images[index];
        return Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Image.network(image.url),
              ),
              Text(image.title),
            ],
          ),
        );
      },
    );
  }
}

