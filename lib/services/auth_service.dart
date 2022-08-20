import '../models/user.dart';
import 'api.dart';

class AuthService {
  final api = Api();

  Future<User?> register(
    Map<String, dynamic> userdata,
    Function(String) error,
  ) async {
    var tu = await api.register(userdata);
    // xử lý cái tu
    //nếu lỗi
    error('Không register được');
    //không lỗi
    //map user
    return User();
  }
}
