class SearchSendApiModel {
  final String marriageType;
  final String? conditions;
  final String? description;
  final String? nationality;
  final String? countryOfResidence;
  final String? city;
  final String? drinkingHabit;
  final String? smokingHabit;
  final String? exerciseFrequency;
  final List<String>? pets;
  final String? position;
  final String? income;
  final String? education;
  final String? islam;
  final String? perspective;
  final int? age;
  final double? weight;
  final double? height;
  final String? skinColor;
  final String? tribe;
  final bool? acceptNationality;
  final String? martialStatus;
  final String? kids;
  final String? look;
  final String? hair;
  final String? health;
  final bool? verified;
  final int? diamondCount;
  final bool? online;
  final int? messageCount;

  SearchSendApiModel({
    required this.marriageType,
    required this.conditions,
    required this.description,
    required this.nationality,
    required this.countryOfResidence,
    required this.city,
    required this.drinkingHabit,
    required this.smokingHabit,
    required this.exerciseFrequency,
    required this.pets,
    required this.position,
    required this.income,
    required this.education,
    required this.islam,
    required this.perspective,
    required this.age,
    required this.weight,
    required this.height,
    required this.skinColor,
    required this.tribe,
    required this.acceptNationality,
    required this.martialStatus,
    required this.kids,
    required this.look,
    required this.hair,
    required this.health,
    required this.verified,
    required this.diamondCount,
    required this.online,
    required this.messageCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'marriageType': marriageType,
      'conditions': conditions,
      'description': description,
      'nationality': nationality,
      'countryOfResidence': countryOfResidence,
      'city': city,
      'drinkingHabit': drinkingHabit,
      'smokingHabit': smokingHabit,
      'exerciseFrequency': exerciseFrequency,
      'pets': pets,
      'position': position,
      'income': income,
      'education': education,
      'islam': islam,
      'perspective': perspective,
      'age': age,
      'weight': weight,
      'height': height,
      'skinColor': skinColor,
      'tribe': tribe,
      'acceptNationality': acceptNationality,
      'martialStatus': martialStatus,
      'kids': kids,
      'look': look,
      'hair': hair,
      'health': health,
      'verified': verified,
      'diamondCount': diamondCount,
      'online': online,
      'messageCount': messageCount,
    };
  }
}
