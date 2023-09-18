abstract class ConnectivityRepository{

  Future<bool> isMobileNetworkConnected();
  Future<bool> isToWifiNetworkConnected();
  Future<bool> isNotConnectedToAnyNetwork();
  Stream<String> listenToNetworkChanges();

}