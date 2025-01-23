import 'dart:convert';
import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cinefouine/data/entities/quizz/quizz_info.dart';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';

part 'quizz_signalr_service.g.dart';

@Riverpod(keepAlive: true)
QuizSignalRService quizSignalRService(QuizSignalRServiceRef ref) {
  final dioClient = ref.watch(dioClientProvider(
    url: "https://ms-quizz-c3cfeyfqdccfdec4.francecentral-01.azurewebsites.net/api",
  ));
  final service = QuizSignalRService(dioClient: dioClient);
  ref.onDispose(() {
    service.dispose();
  });
  return service;
}

class QuizSignalRService {
  QuizSignalRService({required this.dioClient}) {
    _initializeConnection();
  }

  final DioClient dioClient;
  final String hubUrl = 'https://ms-quizz-c3cfeyfqdccfdec4.francecentral-01.azurewebsites.net/quizhub';
  late HubConnection _connection;
  final StreamController<Map<String, String>> _quizReadyController =
      StreamController<Map<String, String>>.broadcast();

  Stream<Map<String, String>> get quizReadyStream => _quizReadyController.stream;

  void _initializeConnection() {
    print("DEBUG Initializing connection to QuizHub");
    _connection = HubConnectionBuilder()
        .withUrl(
          hubUrl,
          options: HttpConnectionOptions(
            // transport: HttpTransportType.WebSockets,
            // skipNegotiation: false,
            // headers: {
            //   'Content-Type': 'application/json',
            // },
            // logger: (level, message) => print('DEBUG log signalr: $message'),
          ),
        )
        .withAutomaticReconnect()
        .build();

    _setConnectionHandlers();
    _startConnection();
  }

  void _setConnectionHandlers() {
    _connection.on("QuizReady", _handleQuizReady);
  }

  void _handleQuizReady(List<Object?>? arguments) {
    print("DEBUG QuizReady signal received");
    if (arguments != null && arguments.length >= 2) {
      final filmId = arguments[0]?.toString() ?? '';
      final titreDuFilm = arguments[1]?.toString() ?? '';
      
      if (filmId.isNotEmpty && titreDuFilm.isNotEmpty) {
        _quizReadyController.add({
          'filmId': filmId,
          'titreDuFilm': titreDuFilm,
        });
      }
    }
  }

  Future<void> _startConnection() async {
    if (_connection.state == HubConnectionState.Disconnected) {
      try {
        await _connection.start();
        print("DEBUG Connected to QuizHub successfully");
      } catch (e) {
        print("DEBUG Error connecting to MS Quizz: $e");
        await Future.delayed(const Duration(seconds: 5));
        await _startConnection();
      }
    } else {
      print("DEBUG Connection already in progress or connected");
    }
  }

Future<Quizz?> getQuizzForFilm(int filmId, String titreDuFilm) async {
  print("DEBUG Fetching quiz for film $filmId");
  try {
    final response = await dioClient.post<Quizz>(
      '/quiz',
      data: {
        "filmId": filmId.toString(),
        "titreDuFilm": titreDuFilm,
      },
      deserializer: (json) => Quizz.fromJson(json as Map<String, dynamic>), // Conversion explicite
    );
    print('DEBUG Quiz fetched: $response');
    return response;
  } catch (e) {
    print("DEBUG Error fetching quiz for film $filmId: $e");
    return null;
  }
}


  void dispose() {
    if (_connection.state == HubConnectionState.Connected) {
      _connection.stop();
    }
    _quizReadyController.close();
  }
}