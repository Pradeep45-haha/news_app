part of 'url_launch_bloc.dart';

@immutable
sealed class UrlLaunchEvent {}

class OpenUrlEvent extends UrlLaunchEvent {
  final String url;
  OpenUrlEvent({required this.url});
}
