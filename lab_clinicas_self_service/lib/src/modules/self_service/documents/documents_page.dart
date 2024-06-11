import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/documents/widgets/documents_box_widget.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> with MessageViewMixin {
  final selfServiceController = Injector.get<SelfServiceController>();
  @override
  void initState() {
    messageListener(selfServiceController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final documents = selfServiceController.model.documents;
    final carteirinhaTotal = documents?[DocumentType.carteirinha]?.length ?? 0;
    final pedidoMedicoTotal =
        documents?[DocumentType.pedidoMedico]?.length ?? 0;

    return Scaffold(
      appBar: LabClinicasAppbar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              top: 18,
            ),
            padding: const EdgeInsets.all(32),
            width: sizeOf.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: LabClinicasTheme.orangeColor,
              ),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/folder.png'),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  "Add documents",
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Select the documents that you want to add to the form",
                  style: LabClinicasTheme.subtitleSmallStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: sizeOf.width * 0.8,
                  height: 310,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DocumentsBoxWidget(
                        uploaded: carteirinhaTotal > 0,
                        icon: Image.asset('assets/iamges/id_card.png'),
                        labels: 'Carteirinha',
                        filesTotal: carteirinhaTotal,
                        onTap: () async {
                          final filePath = await Navigator.of(context)
                              .pushNamed('/self-service/documents/scan');

                          if (filePath != null && filePath != '') {
                            selfServiceController.registerDocument(
                              DocumentType.pedidoMedico,
                              filePath.toString(),
                            );
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Visibility(
                  visible: pedidoMedicoTotal > 0 || carteirinhaTotal > 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            selfServiceController.clearDocuments();
                            setState(() {});
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            fixedSize: const Size.fromHeight(50),
                            side: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          child: const Text(
                            "Remove all",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LabClinicasTheme.orangeColor,
                            fixedSize: const Size.fromHeight(50),
                          ),
                          onPressed: () async {
                            await selfServiceController.finalize();
                          },
                          child: const Text(
                            "END",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
