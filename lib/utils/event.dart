import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  Event({
    required this.eid,
    required this.start,
    required this.end,
    required this.slota,
    required this.slotb,
    required this.slotc,
  });

  String eid;
  String start;
  String end;
  double slota;
  double slotb;
  double slotc;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        eid: json["eid"],
        start: json["start"],
        end: json["end"],
        slota: json["slota"],
        slotb: json["slotb"],
        slotc: json["slotc"],
      );

  Map<String, dynamic> toJson() => {
        "eid": eid,
        "start": start,
        "end": end,
        "slota": slota,
        "slotb": slotb,
        "slotc": slotc,
      };
}
