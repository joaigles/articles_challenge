import 'package:challenge/feature/articles/data/models/article_model.dart';
import 'package:challenge/feature/articles/domain/use_case/get_articles_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetArticlesUseCase getArticlesUseCase;
  late MockArticlesRepository mockArticlesRepository;

  setUp(() {
    mockArticlesRepository = MockArticlesRepository();
    getArticlesUseCase = GetArticlesUseCase(repository: mockArticlesRepository);
  });

  var testArticlesDetail = [
    ArticleModel(
      id: 0,
      description: 'article description',
      title: 'article title',
      imageUrl: 'https://example.com/image',
    )
  ];

  var testArticleDescription = 'article description';

  test(
    'should get articles from the repository',
        () async {
      when(mockArticlesRepository.getArticles(testArticleDescription)).thenAnswer(
            (_) async => Right(testArticlesDetail),
      );

      final result = await getArticlesUseCase.call(testArticleDescription);

      expect(result, Right(testArticlesDetail));
    },
  );
}
