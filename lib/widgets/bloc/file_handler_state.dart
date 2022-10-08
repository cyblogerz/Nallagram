part of 'file_handler_bloc.dart';

@immutable
abstract class FileHandlerState {}

class FileHandlerInitial extends FileHandlerState {}

class ImagePicked extends FileHandlerState {
  final XFile image;

  ImagePicked(this.image);
}

class FilePicked extends FileHandlerState {
  final PlatformFile platformFile;
  final File file;

  FilePicked(this.platformFile, this.file);
}

class OptionsPopupOpened extends FileHandlerState {
  final String type;

  OptionsPopupOpened(this.type);
}

class RenderPageFileBloc extends FileHandlerState {}
