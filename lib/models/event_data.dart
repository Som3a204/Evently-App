class EventData {
  static const String collectionName = "event_tasks";
  String? eventId;
  String eventTitle;
  String eventDescription;
  String eventCategoryImg;
  String eventCategoryId;
  bool isFavorite;
  DateTime selectedDate;
  double? lat;
  double? long;

  EventData({
    this.eventId,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventCategoryImg,
    required this.eventCategoryId,
    this.isFavorite = false,
    required this.selectedDate,
    this.lat = 0,
    this.long = 0
  });
  factory EventData.fromFireStore(Map<String,dynamic> data){
    return EventData(
      eventId: data["eventId"],
      lat: data["lat"] ?? 0,
      long: data["long"] ?? 0,
      eventTitle: data["eventTitle"],
      eventDescription: data["eventDescription"],
      eventCategoryImg: data["eventCategoryImg"],
      eventCategoryId: data["eventCategoryId"],
      isFavorite: data["isFavorite"],
      selectedDate: DateTime.fromMillisecondsSinceEpoch(data["selectedDate"]),
    );
  }
  Map<String, dynamic> toFireStore(){
    return {
      "eventId": eventId,
      "lat": lat,
      "long": long,
      "eventTitle": eventTitle,
      "eventDescription": eventDescription,
      "eventCategoryImg": eventCategoryImg,
      "eventCategoryId": eventCategoryId,
      "isFavorite": isFavorite,
      "selectedDate": selectedDate.millisecondsSinceEpoch,
    };
  }
}
