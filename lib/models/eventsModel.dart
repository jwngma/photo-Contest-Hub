class EventModels {
  String title;
  int eventId;
  String status;
  String type;
  int entryFee;
  String prize;
  String prizeTwo;
  String prizeThree;
  String prizeFour;
  String votingStartDate;
  String resultDate;
  String votingEndDate;
  int totalParticipated;
  String eventImage;
  String time;
  String totalSlots;

  EventModels({this.title,
    this.eventId,
    this.time,
    this.votingStartDate,
    this.votingEndDate,
    this.resultDate,
    this.status,
    this.type,
    this.entryFee,
    this.eventImage,
    this.prize,
    this.prizeTwo,
    this.prizeThree,
    this.prizeFour,
    this.totalParticipated,
    this.totalSlots});

  EventModels.fromMap(Map<String, dynamic> data)
      : this.eventId = data['eventId'],
        this.title = data['title'],
        this.votingStartDate = data['votingStartDate'],
        this.time = data['time'],
        this.votingEndDate = data['votingEndDate'],
        this.resultDate = data['resultDate'],
        this.status = data['status'],
        this.eventImage = data['eventImage'],
        this.type = data['type'],
        this.entryFee = data['entryFee'],
        this.prize = data['prize'],
        this.prizeTwo = data['prizeTwo'],
        this.prizeThree = data['prizeThree'],
        this.prizeFour = data['prizeFour'],
        this.totalParticipated = data['totalParticipated'],
        this.totalSlots = data['totalSlots'];



}
