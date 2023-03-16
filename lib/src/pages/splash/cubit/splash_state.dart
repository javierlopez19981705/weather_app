import 'package:geolocator/geolocator.dart';

enum SplashStatus {
  pending,
  servicesDisabled,
  permissionDenied,
  permissionDeniedForever,
  permissionAllow
}

class SplashState {
  SplashState({
    this.status = SplashStatus.pending,
    this.position,
  });
  final SplashStatus status;
  final Position? position;

  copyWith({
    SplashStatus? status,
    Position? position,
  }) {
    return SplashState(
      status: status ?? this.status,
      position: position ?? this.position,
    );
  }
}
