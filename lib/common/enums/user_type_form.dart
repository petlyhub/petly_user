enum UserTypeForm {
  saudi,
  resident,
}

String getUserType(UserTypeForm type) {
  return type.name; // saudi / resident
}