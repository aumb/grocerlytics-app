import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocerlytics/features/common/categories/data/categories_response.dart';

class CategoryModel extends Equatable {
  const CategoryModel({
    required this.id,
    required this.label,
    required this.color,
    required this.iconData,
  });

  factory CategoryModel.fromResponse(CategoryResponse response) =>
      CategoryModel(
        id: response.id,
        label: response.label,
        color: Color(
          int.parse(
            response.color.replaceAll('#', '0xFF'),
          ),
        ),
        iconData: idToIconMap[response.id]!,
      );

  final int id;
  final String label;
  final Color color;
  final IconData iconData;

  @override
  List<Object?> get props => [id, label, color, iconData];
}

final idToIconMap = <int, IconData>{
  1: FontAwesomeIcons.solidLemon,
  2: FontAwesomeIcons.carrot,
  3: FontAwesomeIcons.coins,
  4: FontAwesomeIcons.cow,
  5: FontAwesomeIcons.drumstickBite,
  6: FontAwesomeIcons.fish,
  7: FontAwesomeIcons.cheese,
  8: FontAwesomeIcons.pepperHot,
  9: FontAwesomeIcons.cookieBite,
  10: FontAwesomeIcons.breadSlice,
  11: FontAwesomeIcons.bottleWater,
  12: FontAwesomeIcons.bowlRice,
  13: FontAwesomeIcons.cakeCandles,
  14: FontAwesomeIcons.icicles,
  15: FontAwesomeIcons.pumpSoap,
  16: FontAwesomeIcons.bandage,
  17: FontAwesomeIcons.soap,
  18: FontAwesomeIcons.babyCarriage,
  19: FontAwesomeIcons.paw,
  20: FontAwesomeIcons.plug,
  21: FontAwesomeIcons.ellipsis,
};
