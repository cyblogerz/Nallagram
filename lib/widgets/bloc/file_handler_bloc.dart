import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'file_handler_event.dart';
part 'file_handler_state.dart';

class FileHandlerBloc extends Bloc<FileHandlerEvent, FileHandlerState> {
  FileHandlerBloc() : super(FileHandlerInitial()) {
    on<PickImage>(_pickImage);
    on<PickFile>(_pickFile);
    on<OpenOptions>(_openOptions);
    on<PageRenderFileBloc>(_pageRender);
  }
  _pickImage(PickImage event, Emitter<FileHandlerState> emit) async {
    //Gallery/Camera
    try {
      final image = await ImagePicker().pickImage(source: event.source);
      if (image == null) return;

      emit(ImagePicked(image));
    } on PlatformException catch (e) {
      log('Failed to pick Image: $e');
    }
  }

  _pickFile(PickFile event, Emitter<FileHandlerState> emit) async {
    var dir = await getApplicationDocumentsDirectory();
    try {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        initialDirectory: dir.path,
        allowedExtensions: ['pdf', 'jpeg', 'jpg', 'png'],
      );
      if (file == null) return;

      emit(
        FilePicked(
          file.files.first,
          File(file.files.single.path),
        ),
      );
    } on PlatformException catch (e) {
      log('Failed to pick Image: $e');
    }
  }

  _openOptions(OpenOptions event, Emitter<FileHandlerState> emit) async {
    emit(OptionsPopupOpened(event.type));
  }

  _pageRender(PageRenderFileBloc event, Emitter<FileHandlerState> emit) async {
    emit(RenderPageFileBloc());
  }
}
