import 'package:bloc/bloc.dart';
import 'package:challenge/core/failures/failure.dart';
import 'package:challenge/feature/articles/domain/entities/article.dart';
import 'package:challenge/feature/articles/domain/use_case/get_articles_use_case.dart';
import 'package:meta/meta.dart';

part 'article_event.dart';

part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticlesUseCase getArticlesUseCase;

  ArticleBloc({
    required this.getArticlesUseCase,
  }) : super(ArticlesInitial()) {
    on<ActionGetArticles>(_getArticles);
  }

  Future<void> _getArticles(
    ActionGetArticles event,
    Emitter<ArticleState> emit,
  ) async {
    emit(OnLoading());
    final result = await getArticlesUseCase.call(event.path);

    result.fold(
      (l) => emit(OnGetArticlesFailure(failure: l)),
      (r) => emit(OnGetArticles(articles: r)),
    );
  }
}
