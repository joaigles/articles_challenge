abstract class Failure {
  final String message;

  Failure({required this.message});
}

class UnhandledFailure extends Failure {
  UnhandledFailure({required super.message});
}
