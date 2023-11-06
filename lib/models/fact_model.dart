import 'dart:convert';

FactModel factModelFromJson(String str) => FactModel.fromJson(json.decode(str));

String factModelToJson(FactModel data) => json.encode(data.toJson());

class FactModel {
  final String? summary;
  final List<Fact>? facts;

  FactModel({
    this.summary,
    this.facts,
  });

  FactModel copyWith({
    String? summary,
    List<Fact>? facts,
  }) =>
      FactModel(
        summary: summary ?? this.summary,
        facts: facts ?? this.facts,
      );

  factory FactModel.fromJson(Map<String, dynamic> json) => FactModel(
        summary: json["summary"],
        facts: json["facts"] == null
            ? []
            : List<Fact>.from(json["facts"]!.map((x) => Fact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "summary": summary,
        "facts": facts == null
            ? []
            : List<dynamic>.from(facts!.map((x) => x.toJson())),
      };
}

class Fact {
  final String? fact;
  final String? source;

  Fact({
    this.fact,
    this.source,
  });

  Fact copyWith({
    String? fact,
    String? source,
  }) =>
      Fact(
        fact: fact ?? this.fact,
        source: source ?? this.source,
      );

  factory Fact.fromJson(Map<String, dynamic> json) => Fact(
        fact: json["fact"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "fact": fact,
        "source": source,
      };
}

String dummyData = jsonEncode({
  "summary": "The fact is true",
  "facts": [
    {
      "fact":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      "source": "The Hindu"
    },
    {
      "fact":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      "source": "Times of India"
    }
  ]
});
