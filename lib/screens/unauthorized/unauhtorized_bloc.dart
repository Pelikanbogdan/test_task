import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPlayerState {
  final bool firstPlayerToggle;
  final bool secondPlayerToggle;
  VideoPlayerState(this.firstPlayerToggle, this.secondPlayerToggle);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VideoPlayerState &&
        other.firstPlayerToggle == firstPlayerToggle &&
        other.secondPlayerToggle == secondPlayerToggle;
  }

  @override
  int get hashCode => firstPlayerToggle.hashCode ^ secondPlayerToggle.hashCode;
}

abstract class UnauthorizedScreenEvent {}

class FirstPlayerMuteToggle extends UnauthorizedScreenEvent {
  final bool isToggled;
  FirstPlayerMuteToggle(this.isToggled);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FirstPlayerMuteToggle && other.isToggled == isToggled;
  }

  @override
  int get hashCode => isToggled.hashCode;
}

class SecondPlayerMuteToggle extends UnauthorizedScreenEvent {
  final bool isToggled;
  SecondPlayerMuteToggle(this.isToggled);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SecondPlayerMuteToggle && other.isToggled == isToggled;
  }

  @override
  int get hashCode => isToggled.hashCode;
}

class UnauthorizedBloc extends Bloc<UnauthorizedScreenEvent, VideoPlayerState> {
  bool isFirstMuted = false;
  bool isSecondMuted = true;
  UnauthorizedBloc() : super(VideoPlayerState(false, true)) {
    on<FirstPlayerMuteToggle>((event, emit) {
      isFirstMuted = event.isToggled;
      if (!isFirstMuted && !isSecondMuted) {
        isSecondMuted = true;
      }
      emit(VideoPlayerState(isFirstMuted, isSecondMuted));
    });
    on<SecondPlayerMuteToggle>((event, emit) {
      isSecondMuted = event.isToggled;
      if (!isFirstMuted && !isSecondMuted) {
        isFirstMuted = true;
      }

      emit(VideoPlayerState(isFirstMuted, isSecondMuted));
    });
  }
}
