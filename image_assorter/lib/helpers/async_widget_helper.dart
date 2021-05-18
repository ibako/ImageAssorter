import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_assorter/data/update_notification_event.dart';

typedef WidgetGenerator = Widget Function();

/// Controller から更新通知を受け取る View を作成します。
/// 複数回、Controller から通知を受ける可能性がある場合に最適です。
/// 初期化の非同期処理のみが必要な場合は [createFutureBuilder] を利用してください。
StreamBuilder<UpdateNotificationEvent> createStreamBuilder(
    Stream<UpdateNotificationEvent> stream, {
      WidgetGenerator? defaultWidget, WidgetGenerator? noDataWidget,
      WidgetGenerator? updatingWidget, WidgetGenerator? updatedWidget }) {
  return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return noDataWidget?.call() ?? defaultWidget!.call();
        }

        final data = snapshot.data;
        if (data is! UpdateNotificationEvent) {
          throw UnknownEventException('unknown event: ${snapshot.data}');
        }

        if (data == UpdateNotificationEvent.updating) {
          return updatingWidget?.call() ?? defaultWidget!.call();
        } else if (data == UpdateNotificationEvent.updated) {
          return updatedWidget?.call() ?? defaultWidget!.call();
        } else {
          throw UnknownEventException('unknown event: $data}');
        }
      },
  );
}

/// 初期化を非同期処理する View を作成します。
/// 複数回、Controller から通知を受ける場合は [createStreamBuilder] を利用してください。
FutureBuilder createFutureBuilder<T extends Widget>({
  required Future<T> heavyWidgetGenerator,
  required WidgetGenerator updatingWidget}) =>
    FutureBuilder(
        future: heavyWidgetGenerator,
        builder: (context, snapshot) => snapshot.hasData
            ? snapshot.data! : updatingWidget(),
    );
