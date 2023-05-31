class VoteModel {
  final String name;
  final int count;
  final int id;

  VoteModel(this.name, this.count,this.id );

  factory VoteModel.fromJson(jsonData) {
    return VoteModel(
      jsonData['name'],
      jsonData['count'],
      jsonData['id'],
    );
  }
}
