abstract class Result<T> {
  Iterable<T> all();

  T? single(int id);

  Future<void> add(T data);

  Future<void> delete(int id);

  Future<void> update(T data);
}
