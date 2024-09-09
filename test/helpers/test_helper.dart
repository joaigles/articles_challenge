import 'package:challenge/feature/articles/data/repositories/article_repository.dart';
import 'package:challenge/feature/articles/domain/use_case/get_articles_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  ArticlesRepository,
  GetArticlesUseCase,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
