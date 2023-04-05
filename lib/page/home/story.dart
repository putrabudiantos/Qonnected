import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stories/flutter_stories.dart';

class StoryPerusahaan extends StatelessWidget {
  final _momentCount = 5;
  final _momentDuration = const Duration(seconds: 5);

  const StoryPerusahaan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final images = List.generate(
      _momentCount,
      (idx) => Image.asset(
        'assets/images/story/${idx + 1}.jpg',
        fit: BoxFit.fill,
      ),
    );

    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.0),
                  border: Border.all(
                    color: CupertinoColors.systemGrey3,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
                width: 64.0,
                height: 64.0,
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoPageScaffold(
                            child: Story(
                              fullscreen: false,
                              onFlashForward: Navigator.of(context).pop,
                              onFlashBack: Navigator.of(context).pop,
                              momentCount: images.length,
                              momentDurationGetter: (idx) => _momentDuration,
                              momentBuilder: (context, idx) => images[idx],
                            ),
                          );
                        },
                      );
                    },
                    child: Image.asset("assets/icons/revisi/logo.png")))),
      ),
    );
  }
}
