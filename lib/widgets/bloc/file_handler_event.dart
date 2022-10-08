part of 'file_handler_bloc.dart';

@immutable
abstract class FileHandlerEvent {}

class OpenOptions extends FileHandlerEvent {
  final String type;

  OpenOptions(this.type);
}

class PickImage extends FileHandlerEvent {
  final ImageSource source;
  final String type;

  PickImage(this.source, this.type);
}

class PickFile extends FileHandlerEvent {
  final String type;

  PickFile(this.type);
}

class OpenCamera extends FileHandlerEvent {}

class PageRenderFileBloc extends FileHandlerEvent {}
