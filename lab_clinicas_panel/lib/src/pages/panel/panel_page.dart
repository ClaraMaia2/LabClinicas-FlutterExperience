import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_panel/src/models/panel_checkin_model.dart';
import 'package:lab_clinicas_panel/src/pages/panel/panel_controller.dart';
import 'package:lab_clinicas_panel/src/pages/panel/widgets/main_panel_widget.dart';
import 'package:lab_clinicas_panel/src/pages/panel/widgets/password_tile_widget.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PanelPage extends StatefulWidget {
  const PanelPage({super.key});

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  final controller = Injector.get<PanelController>();

  @override
  void initState() {
    controller.listenerPanel();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.of(context).size;
    final PanelCheckinModel? current;
    final PanelCheckinModel? lastCall;
    final List<PanelCheckinModel> others;
    final listPanel = controller.panelData.watch(context);

    current = listPanel.firstOrNull;

    if (listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }

    lastCall = listPanel.firstOrNull;

    if (listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }

    others = listPanel;

    return Scaffold(
      appBar: LabClinicasAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                lastCall != null
                    ? SizedBox(
                        width: sizeOf.width * 0.4,
                        child: MainPanelWidget(
                          passwordLabel: "Previous Password",
                          password: lastCall.password,
                          deskNumber:
                              lastCall.attendantDesk.toString().padLeft(2, '0'),
                          labelColor: LabClinicasTheme.blueColor,
                          buttonColor: LabClinicasTheme.orangeColor,
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 22,
                ),
                current != null
                    ? SizedBox(
                        width: sizeOf.width * 0.4,
                        child: MainPanelWidget(
                          passwordLabel: "Current Password",
                          password: current.password,
                          deskNumber:
                              current.attendantDesk.toString().padLeft(2, '0'),
                          labelColor: LabClinicasTheme.orangeColor,
                          buttonColor: LabClinicasTheme.blueColor,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            const Divider(
              color: LabClinicasTheme.orangeColor,
              thickness: 1,
            ),
            const Text(
              "Password History",
              style: TextStyle(
                color: LabClinicasTheme.orangeColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: others
                  .map(
                    (p) => PasswordTileWidget(
                      password: p.password,
                      deskNumber: p.attendantDesk.toString(),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
