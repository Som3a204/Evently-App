import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

abstract class SnackBarService {
  static void showSuccessMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 14.0,
            ),
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE6FFF4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    "assets/icons/success_icn.png",
                    // repeat: false,
                    height: 20,
                    width: 20,
                    // fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  flex: 8,
                  child: Text(
                    msg,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: cancelFunc,
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      duration: const Duration(seconds: 5),
      dismissDirections: [DismissDirection.endToStart],
    );
  }

  static void showWarningMessage(String msg, {bool isLoginWarning = false}) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 12.0,
            ),
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDE6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    "assets/icons/warning_icn.png",
                    // repeat: false,
                    height: 20,
                    width: 20,
                    // fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  flex: 6,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: msg,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                        const WidgetSpan(child: SizedBox(width: 5)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: cancelFunc,
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      duration: const Duration(seconds: 5),
      dismissDirections: [DismissDirection.endToStart],
    );
  }

  static void showErrorMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.maxFinite,

            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 12.0,
            ),
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE6E6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    "assets/icons/error_icn.png",
                    // repeat: false,
                    height: 20,
                    width: 20,
                    // fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  flex: 6,
                  child: Text(
                    msg,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: cancelFunc,
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      duration: const Duration(seconds: 5),
      dismissDirections: [DismissDirection.endToStart],
    );
  }
}