import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybookstore/core/consts/svg_path_enum.dart';
import 'package:mybookstore/core/widgets/empty_app_bar.dart';
import 'package:mybookstore/features/auth/ui/bloc/auth_bloc.dart';
import 'package:mybookstore/features/home/ui/pages/home_page.dart';
import 'package:mybookstore/features/menu/ui/blocs/navigation_bar_bloc.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: BlocBuilder<NavigationBarBloc, NavigationBarState>(
          builder: (context, state) {
            final bloc = context.read<NavigationBarBloc>();

            return Scaffold(
              appBar: EmptyAppBar(),
              bottomNavigationBar: NavigationBar(
                selectedIndex: state.index,
                animationDuration: const Duration(milliseconds: 500),
                onDestinationSelected: (index) {
                  bloc.add(NavigationBarChangedEvent(index));
                },
                destinations: _buildDestinations(context),
              ),
              body: SafeArea(
                child: PageView(
                  controller: bloc.pageController,
                  onPageChanged: (index) {
                    bloc.add(NavigationBarChangedEvent(index));
                  },
                  children: _buildPages(),
                ),
              ),
            );
          },
        ));
  }

  List<Widget> _buildPages() => [HomePage(), Container(), Container(), Container()];

  List<NavigationDestination> _buildDestinations(BuildContext context) {
    final isAdmin = context.read<AuthBloc>().state.authEntity?.user.role == 'Admin';
    return [
      NavigationDestination(
        icon: _svgIcon(SvgPath.home.path, Theme.of(context).colorScheme.surface),
        label: 'Home',
        selectedIcon: _svgIcon(SvgPath.home.path, Theme.of(context).colorScheme.secondary),
      ),
      if (isAdmin)
        NavigationDestination(
          icon: _svgIcon(SvgPath.search.path, Theme.of(context).colorScheme.surface),
          label: 'Funcionários',
          selectedIcon: _svgIcon(SvgPath.search.path, Theme.of(context).colorScheme.secondary),
        ),
      if (isAdmin)
        NavigationDestination(
          icon: _svgIcon(SvgPath.book.path, Theme.of(context).colorScheme.surface),
          label: 'Livros',
          selectedIcon: _svgIcon(SvgPath.book.path, Theme.of(context).colorScheme.secondary),
        )
      else
        NavigationDestination(
            icon: _svgIcon(SvgPath.savemark.path, Theme.of(context).colorScheme.surface),
            label: 'Salvos',
            selectedIcon: _svgIcon(SvgPath.savemark.path, Theme.of(context).colorScheme.secondary)),
      NavigationDestination(
          icon: _svgIcon(SvgPath.person.path, Theme.of(context).colorScheme.surface),
          label: isAdmin ? 'Perfil' : 'Meu perfil',
          selectedIcon: _svgIcon(SvgPath.person.path, Theme.of(context).colorScheme.secondary)),
    ];
  }

  Widget _svgIcon(String path, Color color) =>
      SvgPicture.asset(path, colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
}
