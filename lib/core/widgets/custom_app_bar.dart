import 'package:flutter/material.dart';
import 'package:mybookstore/core/themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  const CustomAppBar({super.key, this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 24, left: 24.0, right: 24.0),
      child: Row(
        spacing: 16,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.purple,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: AppColors.background),
            ),
          ),
          Visibility(visible: text.isNotEmpty, child: Text(text, style: Theme.of(context).textTheme.headlineMedium)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(64);
}
