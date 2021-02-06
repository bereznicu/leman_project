class TicketEntity {
  String category, details, creator;
  DateTime date;

  TicketEntity({this.category, this.creator, this.date, this.details});

  Map<String, dynamic> toMap() {
    return {
      'categorie': this.category,
      'creator': this.creator,
      'data': this.date,
      'detalii': this.details
    };
  }

  TicketEntity fromMap(Map<String, dynamic> map) {
    DateTime date = map['data'].toDate();
    return TicketEntity(
        category: map['categorie'],
        creator: map['creator'],
        date: date,
        details: map['detalii']);
  }
}
