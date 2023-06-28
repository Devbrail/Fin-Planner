abstract class Result<T> {
  Iterable<T> all();

  T? find(int id);

  Future<void> add(T data);

  Future<void> update(T data);

  Future<void> delete(int id);

  Future<int> clear();
}
