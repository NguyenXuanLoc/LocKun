import 'package:base_bloc/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_styles.dart';
import '../theme/colors.dart';
import '../utils/log_utils.dart';
import 'app_text.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class ItemContentWidget extends StatelessWidget {
  final String content;
  final int index;
  final VoidCallback deleteOnClick;
  final VoidCallback copyBoardOnClick;

  const ItemContentWidget(
      {super.key,
      required this.content,
      required this.index,
      required this.deleteOnClick,
      required this.copyBoardOnClick});

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ObjectKey(content),
      trailingActions: <SwipeAction>[
        SwipeAction(
            title: "Delete",
            style: typoW500.copyWith(color: colorWhite),
            onTap: (CompletionHandler handler) async {
              deleteOnClick.call();
            },
            color: Colors.red),
      ],
      child: InkWell(
        onTap: () => copyBoardOnClick.call(),
        child: Container(
          color: index % 2 == 0
              ? Colors.grey.withOpacity(0.95)
              : Colors.grey.withOpacity(0.9),
          padding: EdgeInsets.all(contentPadding + 8),
          child: AppText(
            content,
            style: typoW500.copyWith(color: colorWhite, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
