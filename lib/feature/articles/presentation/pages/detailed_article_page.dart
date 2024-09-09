import 'package:challenge/core/theme/app_theme.dart';
import 'package:challenge/core/utils/images.dart';
import 'package:challenge/feature/articles/domain/entities/article.dart';
import 'package:challenge/feature/articles/presentation/manager/article_bloc.dart';
import 'package:challenge/feature/articles/presentation/pages/home_page.dart';
import 'package:challenge/feature/articles/presentation/widgets/article_carousel_container.dart';
import 'package:challenge/feature/articles/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class DetailedArticlePage extends StatefulWidget {
  static String routeName = '${HomePage.routeName}/detailed-article';

  final Article article;

  const DetailedArticlePage({
    super.key,
    required this.article,
  });

  @override
  State<DetailedArticlePage> createState() => _DetailedArticlePageState();
}

class _DetailedArticlePageState extends State<DetailedArticlePage> {
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
    final screenSize = MediaQuery.of(context).size;

    return BlocConsumer<ArticleBloc, ArticleState>(
      bloc: articleBloc,
      listener: listener,
      builder: (context, state) => builder(context, screenSize),
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

  Scaffold builder(BuildContext context, Size screenSize) {
    return Scaffold(
      appBar: customAppbar(context),
      body: Stack(
        children: [
          articleImage(screenSize),
          textContainer(screenSize, context),
        ],
      ),
    );
  }

  CustomAppbar customAppbar(BuildContext context) {
    return CustomAppbar(
      title: 'Detalle de Artículo',
      leadingWidget: IconButton(
        onPressed: () => context.go(HomePage.routeName),
        icon: const Icon(
          Icons.arrow_back,
          color: AppTheme.primary,
        ),
      ),
    );
  }

  Column articleImage(Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.article.imageUrl.isEmpty
            ? Image.asset(
                Images.emptyArticleImage,
                fit: BoxFit.cover,
                width: screenSize.width,
                height: 300,
              )
            : Image.network(
                widget.article.imageUrl,
                fit: BoxFit.cover,
                width: screenSize.width,
                height: 300,
              ),
      ],
    );
  }

  Positioned textContainer(Size screenSize, BuildContext context) {
    return Positioned(
      top: 295,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 50,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.article.title,
                  style: AppTheme.articleTitleStyle,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.article.description,
                  style: AppTheme.articleDescriptionStyle,
                ),
              ],
            ),
            const Spacer(),
            listViewBuilder(),
          ],
        ),
      ),
    );
  }

  SizedBox listViewBuilder() {
    return SizedBox(
      height: 150,
      child: AnimationLimiter(
        child: ListView.separated(
          itemCount: articlesList.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final article = articlesList[index];

            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(seconds: 1),
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    context.push(
                      DetailedArticlePage.routeName,
                      extra: article,
                    );
                    articleBloc.add(ActionGetArticles(apiUrl));
                  },
                  child: ArticleCarouselContainer(
                    title: article.title,
                    description: article.description,
                    imageUrl: article.imageUrl,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
