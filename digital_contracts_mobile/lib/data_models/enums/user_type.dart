enum UserType {
  User,
  Business,
}

class UserTypeHelper {
  static UserType getUserFromString(String userType) {
    for (UserType element in UserType.values) {
      if (element.toString().toLowerCase() == userType.toLowerCase()) {
        return element;
      }
    }
    return null;
  }
}
