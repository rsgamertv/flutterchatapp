
abstract class AbstractUserModel{
  int? id;
  String? email;
  String? password;
  String? name;
  String? phoneNumber;
  List users = [];

  Future<bool> checkIfExists();

  Future<bool> register();

  Future<void> initializeUsers();
}