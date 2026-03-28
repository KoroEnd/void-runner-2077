enum WeaponType { pistol, shotgun, plasma }

class Weapon {
  final WeaponType type;
  final String name;
  final double fireRate;
  final double damage;

  Weapon(
      {required this.type,
      required this.name,
      required this.fireRate,
      required this.damage});

  static Weapon pistol() => Weapon(
      type: WeaponType.pistol, name: "Pistol", fireRate: 0.4, damage: 20.0);
  static Weapon shotgun() => Weapon(
      type: WeaponType.shotgun, name: "Shotgun", fireRate: 1.0, damage: 60.0);
  static Weapon plasma() => Weapon(
      type: WeaponType.plasma,
      name: "Plasma Rifle",
      fireRate: 0.1,
      damage: 15.0);
}
