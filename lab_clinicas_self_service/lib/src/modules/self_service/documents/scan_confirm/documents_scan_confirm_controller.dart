import 'dart:typed_data';
import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_self_service/src/repositories/documents/documents_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DocumentsScanConfirmController with MessageStateMixin {
  DocumentsScanConfirmController({required this.documentsRepository});

  final DocumentsRepository documentsRepository;
  final pathRemoteStorage = signal<String?>(null);

  Future<void> uploadFile(Uint8List imageBytes, String fileName) async {
    final result = await documentsRepository
        .uploadFile(imageBytes, fileName)
        .asyncLoader();

    switch (result) {
      case Right(value: final pathImage):
        pathRemoteStorage.value = pathImage;
      case Left():
        showError("Error trying to upload file");
    }
  }
}
