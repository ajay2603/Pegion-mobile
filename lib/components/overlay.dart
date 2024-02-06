import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OverlayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Color.fromARGB(255, 255, 255, 255),
            size: 60,
          ),
        ),
      ),
    );
  }
}

class OverlayManager {
  static late OverlayEntry _overlayEntry;

  static void putOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => OverlayWidget(),
    );

    Overlay.of(context).insert(_overlayEntry);
  }

  static void removeOverlay() {
    _overlayEntry.remove();
  }
}
