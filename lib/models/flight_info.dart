import 'package:cloud_firestore/cloud_firestore.dart';

class FlightInfo {
  String? aircraft;
  String? airline;
  String? at;
  String? callSign;
  String? capacity;
  String? from;
  String? gateNo;
  String? icao;
  String? name;
  String? status;
  int? statusCode;
  String? to;
  String? image;

  FlightInfo(
      {this.aircraft,
      this.airline,
      this.at,
      this.callSign,
      this.capacity,
      this.from,
      this.gateNo,
      this.icao,
      this.name,
      this.status,
      this.statusCode,
      this.to,
      this.image
      });

  factory FlightInfo.fromDocument(DocumentSnapshot<Map<String,dynamic>> snapshot){
    var d = snapshot.data()!;
    return FlightInfo(
      aircraft: d['aircraft'],
      airline: d['airline'],
      at: d['at'],
      callSign: d['callSign'],
      from: d['from'],
      gateNo: d['gateNo'],
      icao: d['icao'],
      name: d['name'],
      status: d['status'],
      statusCode: d['statusCode'],
      to: d['to'],
      image: d['image']
    );
  }

}
