import 'package:flutter/material.dart';

showSnackBar({
  required BuildContext context,
  required String message,
  bool isError = true,
}) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor: isError ? Colors.red : Colors.green,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    duration: Duration(seconds: 4),
    action: SnackBarAction(
      label: 'Dispensar',
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
