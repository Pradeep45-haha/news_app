import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_app/features/daily_news/domain/repository/i_connectivity_repository.dart';

class ConnectivityRepositoryImp implements ConnectivityRepository {
  late Connectivity _connectivity;
  ConnectivityRepositoryImp({required Connectivity connectivity}) {
    _connectivity = connectivity;
  }
  @override
  Future<bool> isMobileNetworkConnected() async {
    return await _connectivity.checkConnectivity() == ConnectivityResult.mobile;
  }

  @override
  Future<bool> isNotConnectedToAnyNetwork() async {
    return await _connectivity.checkConnectivity() == ConnectivityResult.none;
  }

  @override
  Future<bool> isToWifiNetworkConnected() async {
    return await _connectivity.checkConnectivity() == ConnectivityResult.wifi;
  }

  @override
  Stream<String> listenToNetworkChanges() async* {
    _connectivity.onConnectivityChanged.map((event) {
      return event.name.toString();
    });
  }
}
