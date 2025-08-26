class EventData {
  static const String collectionName = "event_tasks";
  String? eventId;
  String eventTitle;
  String eventDescription;
  String eventCategoryImg;
  String eventCategoryId;
  bool isFavorite;
  DateTime selectedDate;

  EventData({
    this.eventId,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventCategoryImg,
    required this.eventCategoryId,
    this.isFavorite = false,
    required this.selectedDate,
  });
  factory EventData.fromFireStore(Map<String,dynamic> data){
    return EventData(
      eventId: data["eventId"],
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
      "eventTitle": eventTitle,
      "eventDescription": eventDescription,
      "eventCategoryImg": eventCategoryImg,
      "eventCategoryId": eventCategoryId,
      "isFavorite": isFavorite,
      "selectedDate": selectedDate.millisecondsSinceEpoch,
    };
  }
}
