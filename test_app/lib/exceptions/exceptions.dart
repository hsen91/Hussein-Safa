class NoInternetException implements Exception {
  String message;
  NoInternetException(this.message);
}
 
class NoServiceFoundException implements Exception {
  String message;
  NoServiceFoundException(this.message);
}
 
class InvalidFormatException implements Exception {
  String message;
  InvalidFormatException(this.message);
}
 
class UnknownException implements Exception {
  String message;
  UnknownException(this.message);
}