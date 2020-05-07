
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
  final String _baseUrl = 'http://10.0.2.2:3000/photos';
  static const int _defaultLimit = 4;
  List<ImageModel> images = [];

  String buildUrl({int page, int limit}) {
    if (page == null || page < 1) page = 1;
    if (limit == null || limit < _defaultLimit) limit = _defaultLimit;
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
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  future: this.fetchImages(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return ImageList(snapshot.data);
                    }
                    return Text('empty');
                  },
                ),
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
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (context, int index) {
        var image = images[index];
        return Container(
          child: GestureDetector(
            onTapUp: (TapUpDetails details) { Navigator.pushNamed(context, '/home'); },
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 300.0,
                  child: Image.network(image.url),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

