import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:pimo/animations/page_transformer.dart';
import 'package:pimo/viewmodels/model_image_view_model.dart';

class ImageItemPage extends StatelessWidget {
  const ImageItemPage({
    Key key,
    @required this.item,
    @required this.pageVisibility,
  }) : super(key: key);

  final ModelImageViewModel item;
  final PageVisibility pageVisibility;
  @override
  Widget build(BuildContext context) {
    var image = Image.network(
      item.fileName,
      fit: BoxFit.cover,
      alignment: FractionalOffset(
        0.5 + (pageVisibility.pagePosition / 3),
        0.5,
      ),
    );

    var imageOverlayGradient = const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Color(0xFF000000),
            Color(0x00000000),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            image,
            imageOverlayGradient,
          ],
        ),
      ),
    );
  }
}
