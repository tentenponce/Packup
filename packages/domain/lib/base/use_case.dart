abstract class UseCase<P, R> {
  Future<R> invoke(P param);
}
