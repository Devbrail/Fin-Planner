class NoItemsException implements Exception {}

class NotFoundException implements Exception {}

class NotableToAddException implements Exception {}

class NotableToClearException implements Exception {}

class NotableToDeleteException implements Exception {
  final Object error;
  NotableToDeleteException(this.error);
}
