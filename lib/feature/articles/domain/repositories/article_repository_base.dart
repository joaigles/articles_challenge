import 'package:challenge/core/failures/failure.dart';
import 'package:challenge/feature/articles/data/data_sources/article_remote_data_source.dart';
import 'package:challenge/feature/articles/domain/entities/article.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepositoryBase {
  final ArticleRemoteDataSourceBase remote;

  ArticleRepositoryBase({required this.remote});

  Future<Either<Failure, List<Article>>> getArticles(String path);
}
