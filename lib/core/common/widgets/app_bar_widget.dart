import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/core/utils/string_constants.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String appBattitle;
  final Widget? leading;
  final List<Widget>? actions;
  const AppBarWidget({
    super.key,
    required this.appBattitle,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(appBattitle),
      leading: leading ??
          IconButton(
              onPressed: () {
                context.pop(context);
              },
              icon: Semantics(
                  button: true,
                  label: StringConstants.goback,
                  child: const Icon(Icons.arrow_back_ios))),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
