abstract class NetworkInfo {
  Future<bool> get isConnected;
}


class NetworkInfoImpl implements NetworkInfo {
  // final DataConnectionChecker dataConnectionChecker;

  NetworkInfoImpl();

  @override
  Future<bool> get isConnected => Future.value(true);

}