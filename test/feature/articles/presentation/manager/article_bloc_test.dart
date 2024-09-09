import 'package:challenge/feature/articles/data/models/article_model.dart';
import 'package:challenge/feature/articles/presentation/manager/article_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetArticlesUseCase mockGetArticlesUseCase;
  late ArticleBloc articleBloc;

  setUp(
    () {
      mockGetArticlesUseCase = MockGetArticlesUseCase();
      articleBloc = ArticleBloc(getArticlesUseCase: mockGetArticlesUseCase);
    },
  );

  var testArticleModel = ArticleModel(
    id: 0,
    description: 'article description',
    title: 'article title',
    imageUrl: 'https://example.com/image',
  );

  const articleTitle = 'article title';

  test(
    'initial state should be empty',
    () {
      expect(
        articleBloc.state.runtimeType,
        ArticlesInitial().runtimeType,
      );
    },
  );

  blocTest<ArticleBloc, ArticleState>(
    'should emit [OnLoading, OnGetArticles] when data is gotten successfully',
    build: () {
      when(mockGetArticlesUseCase.call(articleTitle)).thenAnswer(
        (_) async => Right([testArticleModel]),
      );
      return articleBloc;
    },
    act: (bloc) => bloc.add(
      ActionGetArticles(articleTitle),
    ),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      isA<OnLoading>(),
      isA<OnGetArticles>().having((state) => state.articles, 'articles', [testArticleModel]),
    ],
  );
}
