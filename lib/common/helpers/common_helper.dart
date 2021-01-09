import 'package:uuid/uuid.dart';

String generateUniqueId() {
  // Create uuid object
  var uuid = Uuid();

  // Generate a v1 (time-based) id
  var uniqueId = uuid.v1();
  return uniqueId;
}

void showAddOrUpdateWordModalDialog() {}
