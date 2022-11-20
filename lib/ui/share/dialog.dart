import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Are you sure?',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w700
        ),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('No',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          onPressed:() {
            Navigator. of(ctx).pop(false);
          },
        ),
        TextButton(
          child: const Text('Yes',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          onPressed: () {
            Navigator.of(ctx).pop(true);
          },
        ),
      ],
    ),
  );
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context, 
    builder: (ctx) => AlertDialog(
      title: const Text('An Error Occurred!'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}

// Future<void> showAlertDialog(BuildContext context, String message) {
//   return showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (ctx) { 
//       Future.delayed(const Duration(milliseconds: 500), () {
//          Navigator.of(ctx).pop();
//       });

//       return AlertDialog(
//         backgroundColor: Colors.black54,
//         content: Text(message,
//           style: const TextStyle(color: Colors.white)
//         ),
//       );

//     }
//   );
// }