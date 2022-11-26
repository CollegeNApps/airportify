import 'package:cloud_firestore/cloud_firestore.dart';

class BookingInfo {
  String? serviceType;
  int? adults;
  int? kids;
  int? carryBags;
  int? suitcases;

  String? airline;
  String? at;
  String? capacity;
  String? flightName;
  String? flightStatus;
  int? flightStatusCode;
  String? from;
  String? orderedBy;
  String? pickupTime;
  String? gateNo;

  BookingInfo(
      {this.serviceType,
      this.adults,
      this.kids,
      this.carryBags,
      this.suitcases,
      this.airline,
      this.at,
      this.capacity,
      this.flightName,
      this.flightStatus,
      this.flightStatusCode,
      this.from,
      this.orderedBy,
      this.pickupTime,
      this.gateNo});

  factory BookingInfo.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var d = snapshot.data();
    return BookingInfo(
        adults: d!['adults'],
        serviceType: d['serviceType'],
        kids: d['kids'],
        carryBags: d['carrybags'],
        suitcases: d['suitcases'],
        airline: d['airline'],
        at: d['at'],
        capacity: d['capacity'],
        flightName: d['flightName'],
        flightStatus: d['flightStatus'],
        flightStatusCode: d['flightStatusCode'],
        from: d['from'],
        orderedBy: d['orderedBy'],
        pickupTime: d['pickUpTime'],
        gateNo: d["gateNo"]);
  }
}
