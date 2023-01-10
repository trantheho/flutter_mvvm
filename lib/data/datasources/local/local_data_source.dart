abstract class LocalDataSource{

  Future<String> getAccessToken();

  Future<void> saveAccessToken(String token);

  Future<void> removeAccessToken();

  Future<void> saveLocale(String languageCode);

  Future<String> getLocale();

  Future<bool> getFirstLogin();

  Future<void> updateFirstLogin(bool value);
}