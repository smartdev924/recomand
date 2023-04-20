import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageScreen extends StatefulWidget {
  final String url;
  final dynamic urlList;
  ImageScreen(this.url, this.urlList);

  @override
  _MyImageScreen createState() => _MyImageScreen(url, urlList);
}

class _MyImageScreen extends State<ImageScreen> {
  final String url;
  final dynamic urlList;
  _MyImageScreen(this.url, this.urlList);
  dynamic imgList_alt;
  dynamic real_imgList;
  int index = 0;

  @override
  void initState() {
    super.initState();
    real_imgList = urlList;
    index = real_imgList.indexWhere((f) => f['link'] == url);

    List first, second;
    first = real_imgList.sublist(0, index);
    second = real_imgList.sublist(index, real_imgList.length);
    setState(() {
      imgList_alt = second + first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(imgList_alt[index]['link']),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              // heroAttributes: PhotoViewHeroAttributes(
              //     tag: galleryItems[index].id),
            );
          },
          itemCount: imgList_alt.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
          backgroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            color: Theme.of(context).canvasColor,
          ),
        ));
  }
}
