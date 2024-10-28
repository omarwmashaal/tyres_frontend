import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEnums.dart';

class TyrePositionEntity {
  final enum_TyreDirection direction;
  final enum_TyreSide side;
  final int index;

  TyrePositionEntity({required this.direction, required this.side, required this.index});
}
