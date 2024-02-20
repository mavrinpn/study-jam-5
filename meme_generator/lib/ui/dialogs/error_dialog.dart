import 'package:flutter/material.dart';

showErrorModal({required BuildContext context, required dynamic message}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(message.toString()),
          ));
}
