class EventField {
  static final List<String> values = [
    id, valA, valB, valC, distance, checkpoint, emission, time
  ];

  static const String id = 'id';
  static const String valA = 'valA';
  static const String valB = 'valB';
  static const String valC = 'valC';
  static const String distance = 'distance';
  static const String checkpoint = 'checkpoint';
  static const String emission = 'emission';
  static const String time = 'time';
}

class Event {
  final int? id;
  final double valA;
  final double valB;
  final double valC;
  final double distance;
  final DateTime checkpoint;
  final double emission;
  final DateTime time;

  const Event({
    this.id,
    required this.valA,
    required this.valB,
    required this.valC,
    required this.distance,
    required this.checkpoint,
    required this.emission,
    required this.time,
  });

  Event copy({
    int? id,
    double? valA,
    double? valB,
    double? valC,
    double? distance,
    DateTime? checkpoint,
    double? emission,
    DateTime? time,
  }) =>
      Event(
        id: id ?? this.id,
        valA: valA ?? this.valA,
        valB: valB ?? this.valB,
        valC: valC ?? this.valC,
        distance: distance ?? this.distance,
        checkpoint: checkpoint ?? this.checkpoint,
        emission: emission ?? this.emission,
        time: time ?? this.time,
      );

  static Event fromJson(Map<String, Object?> json) => Event(
        id: json[EventField.id] as int?,
        valA: json[EventField.valA] as double,
        valB: json[EventField.valB] as double,
        valC: json[EventField.valC] as double,
        distance: json[EventField.distance] as double,
        checkpoint: json[EventField.checkpoint] as DateTime,
        emission: json[EventField.emission] as double,
        time: json[EventField.time] as DateTime,
      );

  Map<String, Object?> toJson() => {
        EventField.id: id,
        EventField.valA: valA,
        EventField.valB: valB,
        EventField.valC: valC,
        EventField.distance: distance,
        EventField.checkpoint: checkpoint,
        EventField.emission: emission,
        EventField.time: time,
      };
}