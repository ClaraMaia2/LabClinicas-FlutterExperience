// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/documents/scan_confirm/documents_scan_confirm_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DocumentsScanConfirmPage extends StatelessWidget {
  DocumentsScanConfirmPage({super.key});

  late CameraController cameraController;
  final controller = Injector.get<DocumentsScanConfirmController>();

  @override
  Widget build(BuildContext context) {
    controller.pathRemoteStorage.listen(context, () {
      Navigator.of(context).pop();
      Navigator.of(context).pop(controller.pathRemoteStorage.value);
    });

    final sizeOf = MediaQuery.of(context).size;
    final photo = ModalRoute.of(context)!.settings.arguments as XFile;

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
                Image.asset('assets/images/foto_confirm_icon.png'),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  "CONFIRM YOUR PHOTO",
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Verify if your photo is legible and without cuts. Otherwise, click on 'TAKE NEW PHOTO'.",
                  style: LabClinicasTheme.subtitleSmallStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: sizeOf.width * 0.5,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    strokeCap: StrokeCap.square,
                    strokeWidth: 4,
                    dashPattern: const [1, 10, 1, 4],
                    radius: const Radius.circular(16),
                    color: LabClinicasTheme.orangeColor,
                    child: Image.file(
                      File(
                        photo.path,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "TAKE NEW PHOTO",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            final imageBytes = await photo.readAsBytes();
                            final fileName = photo.name;

                            await controller.uploadFile(imageBytes, fileName);
                          },
                          child: const Text(
                            "SAVE",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
