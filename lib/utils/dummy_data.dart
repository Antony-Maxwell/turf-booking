import 'dart:convert';

// TimeSlot model
class TimeSlot {
  final String id;
  final String time;
  final bool isAvailable;
  final bool isBooked;

  TimeSlot({
    required this.id,
    required this.time,
    required this.isAvailable,
    required this.isBooked,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['id'],
      time: json['time'],
      isAvailable: json['isAvailable'],
      isBooked: json['isBooked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'isAvailable': isAvailable,
      'isBooked': isBooked,
    };
  }
}

// Turf model
class Turf {
  final String id;
  final String name;
  final String price;
  final String currency;
  final String priceUnit;
  final String duration;
  final String durationUnit;
  final String type;
  final String capacity;
  final List<TimeSlot> timeSlots;

  Turf({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.priceUnit,
    required this.duration,
    required this.durationUnit,
    required this.type,
    required this.capacity,
    required this.timeSlots,
  });

  factory Turf.fromJson(Map<String, dynamic> json) {
    return Turf(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      currency: json['currency'],
      priceUnit: json['priceUnit'],
      duration: json['duration'],
      durationUnit: json['durationUnit'],
      type: json['type'],
      capacity: json['capacity'],
      timeSlots: (json['timeSlots'] as List)
          .map((slot) => TimeSlot.fromJson(slot))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'currency': currency,
      'priceUnit': priceUnit,
      'duration': duration,
      'durationUnit': durationUnit,
      'type': type,
      'capacity': capacity,
      'timeSlots': timeSlots.map((slot) => slot.toJson()).toList(),
    };
  }

  // Helper method to get formatted price string
  String get formattedPrice => '$currency$price / $priceUnit • $duration $durationUnit';
}

// TurfBookingData class to handle the entire data structure
class TurfBookingData {
  final List<Turf> turfs;

  TurfBookingData({required this.turfs});

  factory TurfBookingData.fromJson(Map<String, dynamic> json) {
    return TurfBookingData(
      turfs: (json['turfs'] as List)
          .map((turf) => Turf.fromJson(turf))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'turfs': turfs.map((turf) => turf.toJson()).toList(),
    };
  }

  // Helper methods
  List<Turf> getTurfsByType(String type) {
    return turfs.where((turf) => turf.type == type).toList();
  }

  Turf? getTurfById(String id) {
    try {
      return turfs.firstWhere((turf) => turf.id == id);
    } catch (e) {
      return null;
    }
  }
}

// Sample data class
class TurfDataService {
  static String get sampleJsonData => '''
{
  "turfs": [
    {
      "id": "1",
      "name": "7's Turf",
      "price": "100",
      "currency": "₹",
      "priceUnit": "person",
      "duration": "60",
      "durationUnit": "mins",
      "type": "7s",
      "capacity": "14",
      "timeSlots": [
        {
          "id": "1",
          "time": "12:00 pm",
          "isAvailable": false,
          "isBooked": true
        },
        {
          "id": "2",
          "time": "01:00 pm",
          "isAvailable": true,
          "isBooked": false
        },
        {
          "id": "3",
          "time": "02:00 pm",
          "isAvailable": false,
          "isBooked": true
        },
        {
          "id": "4",
          "time": "03:00 pm",
          "isAvailable": true,
          "isBooked": false
        }
      ]
    },
    {
      "id": "2",
      "name": "5's Turf",
      "price": "80",
      "currency": "₹",
      "priceUnit": "person",
      "duration": "45",
      "durationUnit": "mins",
      "type": "5s",
      "capacity": "10",
      "timeSlots": [
        {
          "id": "1",
          "time": "12:35 pm",
          "isAvailable": true,
          "isBooked": false
        },
        {
          "id": "2",
          "time": "12:45 pm",
          "isAvailable": true,
          "isBooked": false
        },
        {
          "id": "3",
          "time": "01:30 pm",
          "isAvailable": true,
          "isBooked": false
        },
        {
          "id": "4",
          "time": "02:15 pm",
          "isAvailable": false,
          "isBooked": true
        }
      ]
    },
    {
      "id": "3",
      "name": "12's Turf",
      "price": "150",
      "currency": "₹",
      "priceUnit": "person",
      "duration": "60",
      "durationUnit": "mins",
      "type": "7s",
      "capacity": "14",
      "timeSlots": [
        {
          "id": "1",
          "time": "05:00 pm",
          "isAvailable": true,
          "isBooked": false
        },
        {
          "id": "2",
          "time": "06:00 pm",
          "isAvailable": true,
          "isBooked": false
        },
        {
          "id": "3",
          "time": "07:00 pm",
          "isAvailable": true,
          "isBooked": false
        },
        {
          "id": "4",
          "time": "04:00 pm",
          "isAvailable": true,
          "isBooked": false
        }
      ]
    },
    {
      "id": "4",
      "name": "6's Turf",
      "price": "100",
      "currency": "₹",
      "priceUnit": "person",
      "duration": "60",
      "durationUnit": "mins",
      "type": "7s",
      "capacity": "14",
      "timeSlots": [
        {
          "id": "1",
          "time": "08:00 pm",
          "isAvailable": false,
          "isBooked": true
        },
        {
          "id": "2",
          "time": "09:00 pm",
          "isAvailable": true,
          "isBooked": false
        },
        {
          "id": "3",
          "time": "10:00 pm",
          "isAvailable": true,
          "isBooked": false
        },
        {
          "id": "4",
          "time": "11:00 pm",
          "isAvailable": true,
          "isBooked": false
        }
      ]
    }
  ]
}
''';

  static TurfBookingData getSampleData() {
    final Map<String, dynamic> jsonData = json.decode(sampleJsonData);
    return TurfBookingData.fromJson(jsonData);
  }
}