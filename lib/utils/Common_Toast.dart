import 'package:flutter/material.dart';

class CustomToast {
  static void show(BuildContext context, String message) {
    OverlayState? overlayState = Overlay.of(context);
    if (overlayState == null) return;

    // Create an OverlayEntry
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100, // Adjust position
        left: MediaQuery.of(context).size.width * 0.2,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    // Insert overlay entry
    overlayState.insert(overlayEntry);

    // Remove overlay after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
