class User {
  final int id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber = '',
  });
}

class UserState {
  // Singleton instance
  static final UserState _instance = UserState._internal();

  factory UserState() {
    return _instance;
  }

  UserState._internal();

  // Store the current user
  User _currentUser = User(
    id: 0,
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    phoneNumber: '',
  );

  // Getter for the current user
  User get currentUser => _currentUser;

  // Method to update the user
  void updateUser({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    String? phoneNumber,
  }) {
    _currentUser = User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber ?? _currentUser.phoneNumber,
    );
  }
}
