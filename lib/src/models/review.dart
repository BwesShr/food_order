import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user.dart';

class Review {
  int id;
  String review;
  double rate;
  User user;

  Review.empty();

  Review({
    @required this.id,
    @required this.review,
    @required this.rate,
    @required this.user,
  });

  factory Review.fromJSON(Map<String, dynamic> json) => Review(
        id: json["id"] == null ? null : json["id"],
        review: json["review"] == null ? null : json["review"],
        rate: json["rate"] == null ? 0.0 : json["rate"].toDouble(),
        user: json["user"] == null ? null : User.fromJSON(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "review": review == null ? null : review,
        "rate": rate == null ? null : rate,
        "user": user == null ? null : user.toMap(),
      };
}
