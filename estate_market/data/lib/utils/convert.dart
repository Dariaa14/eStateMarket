import 'package:cloud_firestore/cloud_firestore.dart';

Timestamp convertDateTimeToTimestamp(DateTime dateTime) {
  return Timestamp.fromDate(dateTime);
}
