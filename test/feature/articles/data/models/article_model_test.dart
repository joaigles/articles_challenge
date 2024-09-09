import 'dart:convert';

import 'package:challenge/feature/articles/data/models/article_model.dart';
import 'package:challenge/feature/articles/domain/entities/article.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  var testArticleModel = ArticleModel(
    id: 0,
    description: 'article description',
    title: 'article title',
    imageUrl: 'https://example.com/image',
  );

  test(
    'should be a subclass of article entity',
    () async {
      expect(testArticleModel, isA<Article>());
    },
  );

  test(
    'should return a valid model from json',
    () async {
      final Map<String, dynamic> jsonMap = json
          .decode(readJson('helpers/dummy_data/dummy_article_response.json'));

      final result = ArticleModel.fromJson(jsonMap);

      expect(result.id, testArticleModel.id);
      expect(result.title, testArticleModel.title);
      expect(result.description, testArticleModel.description);
      expect(result.imageUrl, testArticleModel.imageUrl);
    },
  );

  test(
    'should return a json map containing proper data',
    () async {
      final result = testArticleModel.toJson();

      final expectedJsonMap = {
        'title': 'article title',
        'description': 'article description',
        'urlToImage': 'https://example.com/image',
      };

      expect(result, expectedJsonMap);
    },
  );
}
