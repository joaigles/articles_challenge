import 'package:challenge/feature/articles/domain/entities/article.dart';
import 'package:challenge/feature/articles/presentation/pages/detailed_article_page.dart';
import 'package:challenge/feature/articles/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _navigatorKey,
  initialLocation: HomePage.routeName,
  routes: [
    GoRoute(
      path: HomePage.routeName,
      pageBuilder: (context, state) => _buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: DetailedArticlePage.routeName,
      pageBuilder: (context, state) {
        final article = state.extra as Article;

        return _buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: DetailedArticlePage(article: article),
        );
      },
    ),
  ],
);

CustomTransitionPage _buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) =>
        FadeTransition(opacity: animation, child: child),
  );
}
