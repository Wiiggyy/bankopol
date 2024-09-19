import 'package:bankopol/infrastructure/repository.dart';
import 'package:bankopol/models/event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_provider.g.dart';

@riverpod
Stream<E> event<E extends Event>(EventRef<E> ref) async* {
  await for (final event
      in ref.watch(repositoryProvider.notifier).streamEvents().whereType<E>()) {
    yield event;
  }
}

extension<E> on Stream<E> {
  Stream<T> whereType<T>() {
    return where((e) => e is T).cast();
  }
}
