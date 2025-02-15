class MetaModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const MetaModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  MetaModel.fromJson(Map<String, dynamic> json)
      : currentPage = json['pageNumber'] as int,
        lastPage = json['totalPages'] as int,
        perPage = int.parse(json['pageSize'].toString()),
        total = json['totalPages'] as int;

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'last_page': lastPage,
        'per_page': perPage,
        'total': total
      };

  factory MetaModel.getEmptyOne() {
    return const MetaModel(currentPage: 0, lastPage: 0, perPage: 0, total: 0);
  }
}
