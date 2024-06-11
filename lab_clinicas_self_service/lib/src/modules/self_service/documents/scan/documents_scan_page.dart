// ignore_for_file: use_build_context_synchronously

import 'package:asyncstate/asyncstate.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class DocumentsScanPage extends StatefulWidget {
  const DocumentsScanPage({super.key});

  @override
  State<DocumentsScanPage> createState() => _DocumentsScanPageState();
}

class _DocumentsScanPageState extends State<DocumentsScanPage> {
  late CameraController cameraController;
  @override
  void initState() {
    cameraController = CameraController(
      Injector.get<List<CameraDescription>>().first,
      ResolutionPreset.max,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.of(context).size;

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
              border: Border.all(
                color: LabClinicasTheme.orangeColor,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/cam_icon.png'),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  "Take picture",
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(
                  height: 28,
                ),
                const Text(
                  "Hold the document in front of the camera qnd tap on the button to take the picture",
                  style: LabClinicasTheme.subtitleSmallStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: cameraController.initialize(),
                  builder: (context, snapshot) {
                    switch (snapshot) {
                      case AsyncSnapshot(
                          connectionState:
                              ConnectionState.waiting || ConnectionState.active
                        ):
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      case AsyncSnapshot(connectionState: ConnectionState.done):
                        if (cameraController.value.isInitialized) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              width: sizeOf.width * 0.48,
                              child: CameraPreview(
                                cameraController,
                                child: DottedBorder(
                                  radius: const Radius.circular(16),
                                  borderType: BorderType.RRect,
                                  strokeCap: StrokeCap.square,
                                  strokeWidth: 4,
                                  dashPattern: const [1, 10, 1, 4],
                                  color: LabClinicasTheme.orangeColor,
                                  child: const SizedBox.expand(),
                                ),
                              ),
                            ),
                          );
                        }
                    }
                    return const Text("Error trying to initialize camera");
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: sizeOf.width * 0.8,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      final picture =
                          await cameraController.takePicture().asyncLoader();
                      final navigator = Navigator.of(context);

                      navigator.pushNamed(
                        '/self-service/documents/scan/confirm',
                        arguments: picture,
                      );
                    },
                    child: const Text("Take picture"),
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
