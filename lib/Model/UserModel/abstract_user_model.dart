
abstract class AbstractUserModel{
  int? id;
  String? email;
  String? password;
  String? name;
  String? phoneNumber;

  Future<bool> checkIfExists();

  Future<bool> register();

}