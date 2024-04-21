abstract class AbstractChatModel{
  int? id;
  String? email;
  String? name;
  List users = [];

  Future<void> initializeUsers();
}