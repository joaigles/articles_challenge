import 'package:challenge/core/theme/app_theme.dart';
import 'package:challenge/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leadingWidget;

  const CustomAppbar({
    super.key,
    required this.title,
    this.leadingWidget,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: AppTheme.appbarBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: AppBar(
        title: Text(
          title,
          style: AppTheme.appBarTitleStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: leadingWidget,
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            thumbIcon: WidgetStateProperty.resolveWith(
              (states) => const Icon(Icons.sunny),
            ),
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
