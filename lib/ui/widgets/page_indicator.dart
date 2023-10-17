import 'package:flutter/material.dart';
import 'package:lichi_app/ui/widgets/picture_indicator_clip.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final int? current;
  const PageIndicator({Key? key, required this.count, required this.current})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    for (var i = 0; i < count; i++) {
      double k = i == (current ?? 0) ? 2 : 1;
      widgets.add(
        ClipPath(
          clipper: PictureIndicatorClip(k),
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            alignment: Alignment.center,
            width: 7,
            height: 7,
          ),
        ),
      );
      widgets.add(const SizedBox(
        width: 4,
      ));
    }
    return Container(
      height: 24,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0x77FFFFFF)),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...widgets],
      ),
    );
  }
}
