/// Controller から View への更新通知。
enum UpdateNotificationEvent {
  updating,
  updated,
}

/// Controller から未知のイベントを受け取った例外
class UnknownEventException implements Exception {
  final String message;
  UnknownEventException(this.message);
}
