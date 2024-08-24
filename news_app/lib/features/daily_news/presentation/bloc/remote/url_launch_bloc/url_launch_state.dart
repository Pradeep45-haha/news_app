part of 'url_launch_bloc.dart';

@immutable
sealed class UrlLaunchState {}

final class UrlLaunchInitial extends UrlLaunchState {}

class UrlLaunchSuccessState extends UrlLaunchState{

}

class UrlLaunchFailureState extends UrlLaunchState{

}
