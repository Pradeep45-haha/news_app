import 'package:connectivity_plus/connectivity_plus.dart';

class NetStatus {
  final Connectivity _connectivity;
  NetStatus({required Connectivity connectivity})
      : _connectivity = connectivity;

  Future<bool> isMobileNetworkConnected() async {
    return await _connectivity.checkConnectivity() == ConnectivityResult.mobile;
  }

  Future<bool> isNotConnectedToAnyNetwork() async {
    return await _connectivity.checkConnectivity() == ConnectivityResult.none;
  }

  Future<bool> isWifiNetworkConnected() async {
    return await _connectivity.checkConnectivity() == ConnectivityResult.wifi;
  }

  Stream<String> listenToNetworkChanges() async* {
    yield* _connectivity.onConnectivityChanged
        .map((event) => event.name.toString());
  }
}
