import 'package:challenge/core/failures/failure.dart';
import 'package:challenge/feature/articles/domain/entities/article.dart';
import 'package:challenge/feature/articles/domain/repositories/article_repository_base.dart';
import 'package:dartz/dartz.dart';

class ArticlesRepository extends ArticleRepositoryBase {
  ArticlesRepository({required super.remote});

  @override
  Future<Either<Failure, List<Article>>> getArticles(String path) async {
    try {
      final response = await remote.getArticles(path);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnhandledFailure(message: '$e'));
    }
  }
}
