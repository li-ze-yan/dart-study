abstract class Character {
  final String name;
  int hp; // 生命值
  int level;

  Character(this.name, {this.hp = 100, this.level = 1});

  /// 抽象：每个职业的攻击方式不同，子类必须实现
  int attack();

  /// 通用：受伤
  void takeDamage(int dmg) {
    hp -= dmg;
    if (hp < 0) hp = 0;
    print('$name 受到 $dmg 伤害，剩余 HP: $hp');
  }

  /// 通用：是否阵亡
  bool get isDead => hp <= 0;

  @override
  String toString() => '$name (Lv.$level, HP:$hp)';
}

class Warrior extends Character {
  Warrior(super.name) : super(hp: 150); // 战士血更厚

  @override
  int attack() {
    final dmg = 20 + level * 3;
    print('$name 挥剑斩击！造成 $dmg 物理伤害');
    return dmg;
  }
}

class Mage extends Character {
  int mp; // 法力值，子类独有字段

  Mage(super.name, {this.mp = 80});

  @override
  int attack() {
    if (mp < 10) {
      print('$name 法力不足，普攻 5 点');
      return 5;
    }
    mp -= 10;
    final dmg = 35 + level * 5;
    print('$name 释放火球术！造成 $dmg 法术伤害（剩余 MP: $mp）');
    return dmg;
  }
}

void main() {
  // 多态：用父类引用持有不同子类
  final List<Character> party = [
    Warrior('阿尔斯'),
    Mage('美琪'),
  ];

  // 模拟一场战斗：每人攻击一个 Boss
  final boss = Warrior('史莱姆王')..hp = 10;

  for (final hero in party) {
    final dmg = hero.attack();
    boss.takeDamage(dmg);
    if (boss.isDead) {
      print('${boss.name} 已被击败！');
      break;
    }
  }
}
