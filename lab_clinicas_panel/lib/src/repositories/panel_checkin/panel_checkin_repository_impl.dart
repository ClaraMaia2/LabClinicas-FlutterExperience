import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_panel/src/core/env.dart';
import 'package:lab_clinicas_panel/src/models/panel_checkin_model.dart';
import 'package:lab_clinicas_panel/src/repositories/panel_checkin/panel_checkin_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class PanelCheckinRepositoryImpl implements PanelCheckinRepository {
  PanelCheckinRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Stream<List<PanelCheckinModel>> getTodayPanel(
      WebSocketChannel channel) async* {
    yield await requestData();

    yield* channel.stream.asyncMap((_) async => requestData());
  }

  @override
  ({WebSocketChannel channel, Function dispose}) openChannelSocket() {
    final channel = WebSocketChannel.connect(
      Uri.parse('${Env.webSocketBackEndBaseURL}?tables=panelCheckin'),
    );

    return (
      channel: channel,
      dispose: () {
        channel.sink.close();
      }
    );
  }

  Future<List<PanelCheckinModel>> requestData() async {
    final dateFormat = DateFormat('y-MM-dd');
    final Response(:List data) = await restClient.auth.get(
      '/panelCheckin',
      queryParameters: {
        'time_called': dateFormat.format(
          DateTime.now(),
        ),
      },
    );

    return data.reversed
        .take(7)
        .map((e) => PanelCheckinModel.fromJson(e))
        .toList();
  }
}
