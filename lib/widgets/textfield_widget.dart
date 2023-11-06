import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool? readOnly;
  final bool? enableBackButton;
  const TextFieldWidget({
    required this.title,
    required this.controller,
    this.readOnly = false,
    this.enableBackButton = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: Row(
              children: [
                // enableBackButton!
                //     ? InkWell(
                //         borderRadius: BorderRadius.circular(48),
                //         onTap: () {
                //           Navigator.of(context).pop();
                //         },
                //         child: const Padding(
                //           padding: EdgeInsets.all(8.0),
                //           child: Icon(Icons.chevron_left),
                //         ))
                //     : Container(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        TextField(
          controller: controller,
          maxLines: 3,
          readOnly: readOnly!,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
