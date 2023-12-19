
class EquipItem {
  final String equipName;
  final List slots;
  final String equipType;
  final int equipATK;
  final int equipMATK;
  final int equipSTR;
  final int equipINT;
  final int equipVIT;
  final int equipSPI;
  final int equipDEX;

  EquipItem.fromJson(Map<String, dynamic> json, String name):
        equipName = json[name]['name'],
        slots = json[name]['slot'],
        equipType= json[name]['type'],
        equipATK = json[name]['equipATK'],
        equipMATK = json[name]['equipMATK'],
        equipSTR = json[name]['equipSTR'],
        equipINT = json[name]['equipINT'],
        equipVIT = json[name]['equipVIT'],
        equipSPI = json[name]['equipSPI'],
        equipDEX = json[name]['equipDEX'];
}