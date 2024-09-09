import 'package:challenge/core/services/http_services.dart';
import 'package:challenge/feature/articles/data/data_sources/article_remote_data_source.dart';
import 'package:challenge/feature/articles/data/repositories/article_repository.dart';
import 'package:challenge/feature/articles/domain/repositories/article_repository_base.dart';
import 'package:challenge/feature/articles/domain/use_case/get_articles_use_case.dart';
import 'package:challenge/feature/articles/presentation/manager/article_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingleton<Client>(Client());

  getIt.registerSingleton<HttpServiceBase>(
    HttpService(httpClient: getIt<Client>()),
  );

  getIt.registerSingleton<ArticleRemoteDataSourceBase>(
    ArticleRemoteDataSource(httpService: getIt<HttpServiceBase>()),
  );

  getIt.registerSingleton<ArticleRepositoryBase>(
    ArticlesRepository(remote: getIt<ArticleRemoteDataSourceBase>()),
  );

  getIt.registerSingleton<GetArticlesUseCase>(
    GetArticlesUseCase(repository: getIt<ArticleRepositoryBase>()),
  );

  getIt.registerSingleton<ArticleBloc>(
    ArticleBloc(
      getArticlesUseCase: getIt<GetArticlesUseCase>(),
    ),
  );
}
