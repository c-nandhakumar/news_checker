import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String? url;
  final String? source;
  const WebViewScreen(this.url, this.source, {super.key});
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewScreen> {
  double height = 0;

  final WebViewController _controller = WebViewController();

  @override
  void initState() {
    super.initState();
    _controller.loadRequest(Uri.parse(widget.url!));

    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(false);
        return false;
      },
      child: GestureDetector(
        ///Right swipe to pop the page and
        ///Navigate back to the previous screen
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 18) {
            Navigator.of(context).pop(false);
          }
        },
        child: Scaffold(
            appBar: buildAppBar(),
            body: WebViewWidget(
              controller: _controller,
              gestureRecognizers: {
                Factory(
                  () => PlatformViewVerticalGestureRecognizer(context: context),
                ),
              },
            )),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.chevron_left),
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
      elevation: 0,
      title: Text(
        widget.source ?? "Source",
      ),
      centerTitle: true,
    );
  }
}

class PlatformViewVerticalGestureRecognizer
    extends VerticalDragGestureRecognizer {
  PlatformViewVerticalGestureRecognizer({PointerDeviceKind? kind, this.context})
      : super();

  // supportedDevices: <PointerDeviceKind>{kind!}
  final BuildContext? context;

  Offset _dragDistance = Offset.zero;
  // BuildContext context;
  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
  }

  @override
  void handleEvent(PointerEvent event) {
    _dragDistance = _dragDistance + event.delta;

    if (event is PointerMoveEvent) {
      final double dy = _dragDistance.dy.abs();
      final double dx = _dragDistance.dx.abs();
      if (dy > dx && dy > kTouchSlop) {
        // vertical drag - accept
        resolve(GestureDisposition.accepted);
        _dragDistance = Offset.zero;
      } else if (dx > kTouchSlop) {
        print("<===Horizontal Drag===>");
      }
      // else if (dx > kTouchSlop && dx > dy) {
      //   // horizontal drag - stop tracking
      //   print("HORZ");
      //   Navigator.of(context!).pop();
      //   stopTrackingPointer(event.pointer);
      //   _dragDistance = Offset.zero;
      // }
    }
  }

  @override
  String get debugDescription => 'horizontal drag (platform view)';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
