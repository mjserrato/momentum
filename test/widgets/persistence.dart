import 'package:flutter/material.dart';

import 'package:momentum/momentum.dart';

import '../components/dummy/dummy.controller.dart';
import '../components/persist-test/index.dart';
import '../utility.dart';

Momentum persistedApp({
  bool noPersistSave = false,
  bool noPersistGet = false,
}) {
  return Momentum(
    child: PersistedApp(),
    controllers: [
      DummyController(),
      PersistTestController()..config(),
    ],
    enableLogging: true,
    services: [
      InMemoryStorage<String>(),
    ],
    persistSave: noPersistSave
        ? null
        : (context, key, value) async {
            var storage = InMemoryStorage.of<String>(context);
            var result = await storage.save(key, value);
            return result;
          },
    persistGet: noPersistGet
        ? null
        : (context, key) async {
            var storage = InMemoryStorage.of<String>(context);
            var result = storage.getValue(key);
            return result;
          },
  );
}

class PersistedApp extends StatefulWidget {
  const PersistedApp({
    Key key,
  }) : super(key: key);

  @override
  _PersistedAppState createState() => _PersistedAppState();
}

class _PersistedAppState extends MomentumState<PersistedApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Async App',
      home: Scaffold(
        body: SizedBox(),
      ),
    );
  }
}