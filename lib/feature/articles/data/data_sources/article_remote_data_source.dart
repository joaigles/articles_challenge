import 'package:challenge/core/services/http_services.dart';
import 'package:challenge/feature/articles/data/models/article_model.dart';
import 'package:challenge/feature/articles/domain/entities/article.dart';

abstract class ArticleRemoteDataSourceBase {
  Future<List<Article>> getArticles(String url);
}

class ArticleRemoteDataSource implements ArticleRemoteDataSourceBase {
  final HttpServiceBase httpService;

  ArticleRemoteDataSource({required this.httpService});

  @override
  Future<List<Article>> getArticles(String url) async {
    try {
      final List<dynamic> jsonList = await httpService.get(url: url);

      return jsonList.map((json) => ArticleModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
