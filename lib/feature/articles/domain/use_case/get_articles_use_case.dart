
import 'package:challenge/core/failures/failure.dart';
import 'package:challenge/core/use_case/use_case_base.dart';
import 'package:challenge/feature/articles/domain/entities/article.dart';
import 'package:challenge/feature/articles/domain/repositories/article_repository_base.dart';
import 'package:dartz/dartz.dart';

class GetArticlesUseCase extends UseCaseBase<List<Article>, String> {
  final ArticleRepositoryBase repository;

  GetArticlesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Article>>> call(String params) async {
    return await repository.getArticles(params);
  }
}