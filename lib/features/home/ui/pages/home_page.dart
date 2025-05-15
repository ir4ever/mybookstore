import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybookstore/core/consts/svg_path_enum.dart';
import 'package:mybookstore/core/widgets/app_search_bar.dart';
import 'package:mybookstore/core/widgets/app_snackbar.dart';
import 'package:mybookstore/core/widgets/list_view_title.dart';
import 'package:mybookstore/features/auth/ui/bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final String userName;

  @override
  void initState() {
    userName = context.read<AuthBloc>().state.authEntity!.user.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
        child: Column(
          spacing: 40,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              spacing: 24,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(SvgPath.logo.path,
                    height: 42, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
                Text('Olá, $userName 👋', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            Row(
              spacing: 16,
              children: [
                Expanded(child: AppSearchBar(hintText: 'Buscar')),
                IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          AppSnackbar(message: 'Ops... Ainda estamos trabalhando nessa feature', context: context));
                    },
                    icon: SvgPicture.asset(SvgPath.filter.path))
              ],
            ),
            ListViewTitle(title: 'Livros salvos', isVisible: true, aspectRatio: 4 / 3, child: const SizedBox.shrink()),
            ListViewTitle(title: 'Todos os livros', isVisible: true, aspectRatio: 4 / 3, child: const SizedBox.shrink())
          ],
        ),
      ),
    ));
  }
}
