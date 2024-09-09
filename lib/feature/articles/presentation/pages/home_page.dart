import 'package:challenge/feature/articles/domain/entities/article.dart';
import 'package:challenge/feature/articles/presentation/manager/article_bloc.dart';
import 'package:challenge/feature/articles/presentation/pages/detailed_article_page.dart';
import 'package:challenge/feature/articles/presentation/widgets/article_list_container.dart';
import 'package:challenge/feature/articles/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home-page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String apiUrl =
      'https://run.mocky.io/v3/2965bc60-fcaa-4e6e-b8e9-3a81b4182e55';
  final articleBloc = GetIt.instance<ArticleBloc>();
  List<Article> articlesList = [];

  @override
  void initState() {
    super.initState();
    articleBloc.add(ActionGetArticles(apiUrl));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState>(
      bloc: articleBloc,
      listener: listener,
      builder: builder,
    );
  }

  Widget builder(context, state) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Lista de Artículos',
      ),
      body: (state is OnLoading)
          ? const Center(child: CircularProgressIndicator())
          : listViewBuilder(),
    );
  }

  AnimationLimiter listViewBuilder() {
    return AnimationLimiter(
      child: ListView.separated(
        itemCount: articlesList.length,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final article = articlesList[index];

          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(seconds: 1),
            child: FadeInAnimation(
              child: GestureDetector(
                onTap: () {
                  context.go(
                    DetailedArticlePage.routeName,
                    extra: article,
                  );
                },
                child: ArticleListContainer(
                  title: article.title,
                  description: article.description,
                  imageUrl: article.imageUrl,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void listener(context, state) {
    switch (state.runtimeType) {
      case const (OnGetArticles):
        articlesList = state.articles;
        break;
      case const (OnGetArticlesFailure):
        SnackBar(content: Text(state.failure.message));
        break;
      default:
    }
  }
}
