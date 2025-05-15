import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybookstore/core/consts/svg_path_enum.dart';

class AppSearchBar extends StatefulWidget {
  final String hintText;
  const AppSearchBar({super.key, required this.hintText});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final _controller = TextEditingController();

  bool _showClearButton = false;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _controller,
      hintText: widget.hintText,
      hintStyle: WidgetStatePropertyAll(
          Theme.of(context).textTheme.labelMedium!.copyWith(height: .2, fontWeight: FontWeight.w400)),
      onTapOutside: (_) => FocusScope.of(context).unfocus,
      onChanged: (value) {
        if (value.length == 1) {
          setState(() {
            _showClearButton = true;
          });
        }
        if (value.isEmpty) {
          setState(() {
            _showClearButton = false;
          });
        }
      },
      trailing: [
        Visibility(
          visible: _showClearButton,
          replacement: SvgPicture.asset(SvgPath.search.path,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.outlineVariant, BlendMode.srcIn)),
          child: IconButton(
            iconSize: 14,
            padding: EdgeInsets.zero,
            tooltip: 'Limpar busca',
            onPressed: () {
              setState(() {
                _controller.clear();
                _showClearButton = false;
              });
            },

            ///todo: alterar para o icone do figma
            icon: Icon(Icons.close),
          ),
        ),
      ],
    );
  }
}
