import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';

class AuthService {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    return sessionId != null;
  }

  Future<void> login(String login, String password) async {
    final sessionId = await _apiClient.auth(
      username: login,
      password: password,
    );
    final acctounId = await _apiClient.getAccountId(sessionId);
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(acctounId);
  }
}
