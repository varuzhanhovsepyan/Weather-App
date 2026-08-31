import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

class AdvancedPlaygroundScreen extends StatefulWidget {
  const AdvancedPlaygroundScreen({super.key});

  @override
  State<AdvancedPlaygroundScreen> createState() =>
      _AdvancedPlaygroundScreenState();
}

// EXPANDO
class User {
  final String name;

  User(this.name);
}

class _AdvancedPlaygroundScreenState
    extends State<AdvancedPlaygroundScreen> {
  final List<String> logs = [];
  // EXPANDO
  final Expando<String> userMetadata = Expando<String>();

  // EXPANDO
  void runExpandoExample() {
    final user1 = User('Alex');
    final user2 = User('Bob');

    userMetadata[user1] = 'Admin';
    userMetadata[user2] = 'Guest';

    addLog('${user1.name}: ${userMetadata[user1]}');
    addLog('${user2.name}: ${userMetadata[user2]}');
  }

  // Schedule Microtask example
  void runEventLoopExample() {
    addLog('--- start ---');

    Future(() {
      addLog('Future');
    });

    scheduleMicrotask(() {
      addLog(' Schedule Microtask');
    });

    Future.microtask(() {
      addLog('Future.microtask');
    });

    addLog('--- end ---');
  }
 
  // Zone example
  void runZoneExample() {
    runZonedGuarded(
      () {
        print('Hello from Zone');

        Future.delayed(const Duration(milliseconds: 100), () {
          throw Exception('Test error');
        });
      },
      (error, stackTrace) {
        addLog('Caught: $error');
      },
    );
  }

  // Isolate example
  Future<void> runIsolateExample() async {
    addLog('Main isolate: started');

    final receivePort = ReceivePort();

    await Isolate.spawn(
      isolateTask,
      receivePort.sendPort,
    );

    final result = await receivePort.first;

    addLog('Main isolate: result = $result');
  }

  void isolateTask(SendPort sendPort) {
    addLog('Worker isolate: started');
    sendPort.send('Hello from isolate');
  }

  void addLog(String message) {
    setState(() {
      logs.add(message);
    });
  }

  // Future example
  Future<String> loadWeather() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Yerevan: 25°C';
  }

  // Stream example
  Stream<int> temperatureStream() async* {
    for (var temperature = 25; temperature <= 29; temperature++) {
      await Future.delayed(const Duration(seconds: 1));
      yield temperature;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Playground'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Future example
          FutureBuilder<String>(
          future: loadWeather(),
          builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
              return Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              return Text(snapshot.data ?? 'No data');
            },
          ),
          // Stream example
          StreamBuilder<int>(
            stream: temperatureStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
              return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                );
              }

              return Text(
                '${snapshot.data}°C',
                style: const TextStyle(fontSize: 30),
              );
            },
          ),
          FilledButton(
            onPressed: () {
              addLog('Hello from playground');
            },
            child: const Text('Run'),
          ),
          FilledButton(
            onPressed: runEventLoopExample,
            child: const Text('Event Loop'),
          ),
          FilledButton(
            onPressed: runZoneExample,
            child: const Text('Zone'),
          ),
          FilledButton(
            onPressed: runIsolateExample,
            child: const Text('Isolate'),
          ),
          FilledButton(
            onPressed: runExpandoExample,
            child: const Text('Expando'),
          ),
          // Hit Test example
          GestureDetector(
            onTap: () {
              addLog('Tap');
            },
            onHorizontalDragStart: (_) {
              addLog('Horizontal drag');
            },
            onVerticalDragStart: (_) {
              addLog('Vertical drag');
            },
            child: Container(
              height: 250,
              alignment: Alignment.center,
              child: const Text(
                'Tap or drag me',
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...logs.map(
            (log) => Text(log),
          ),
        ],
      ),
    );
  }
}