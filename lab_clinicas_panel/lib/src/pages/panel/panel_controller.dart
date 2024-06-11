import 'package:lab_clinicas_panel/src/models/panel_checkin_model.dart';
import 'package:lab_clinicas_panel/src/repositories/panel_checkin/panel_checkin_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PanelController {
  PanelController({
    required PanelCheckinRepository panelCheckinRepository,
  }) : _panelCheckinRepository = panelCheckinRepository;

  final PanelCheckinRepository _panelCheckinRepository;

  Function? _socketDispose;
  final panelData = listSignal<PanelCheckinModel>([]);
  Connect? _panelConnect;

  void dispose() {
    _panelConnect?.dispose();

    if (_socketDispose != null) {
      _socketDispose!();
    }
  }

  Future<void> listenerPanel() async {
    final (:channel, :dispose) = _panelCheckinRepository.openChannelSocket();

    _socketDispose = dispose;
    _panelConnect = connect(panelData);

    final panelStream = _panelCheckinRepository.getTodayPanel(channel);

    _panelConnect!.from(panelStream);
  }
}
