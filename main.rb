class Brave
  #attr_readerによりゲッターを省略できる
  attr_reader :name, :offense, :defense
  #セッターとゲッターを一括定義
  attr_accessor :hp

  SPECIAL_ATTACK_CONSTANT = 1.5

  #new演算子から渡された引数をハッシュで受け取る
  #引数に**を記述することでハッシュしか受け取れなくなる
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

  #攻撃処理
  def attack(monster)
    puts "#{@name}の攻撃"

    attack_type = decision_attack_type

    damage = calculate_damage(target: monster, attack_type: attack_type)

    cause_damage(target: monster,damage: damage)

    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  private

    def decision_attack_type
      attack_num = rand(4)

      if attack_num == 0
        puts "必殺攻撃"
        "special_attack"
      else
        puts "通常攻撃"
        "normal_attack"
      end
    end

    def calculate_damage(**params)
      #変数に格納することにより後にハッシュのキーに変更がある場合でも変更箇所が少なくて済む
      target = params[:target]
      attack_type = params[:attack_type]

      if attack_type == "special_attack"
        calculate_special_attack - target.defense
      else
        @offense - target.defense
      end
    end

    def cause_damage(**params)
      damage = params[:damage]
      target = params[:target]

      target.hp -= damage

      target.hp = 0 if target.hp < 0

      puts "#{target.name}は#{damage}のダメージをうけた"
    end

    def calculate_special_attack
      @offense * SPECIAL_ATTACK_CONSTANT
    end
end

class Monster
  #値の取り出しのみ可能
  attr_reader  :offense, :defense
  #値の代入・取り出しが可能
  attr_accessor :hp, :name

  POWER_UP_RATE = 1.5

  #HPの半分の値を計算する定数
  CALC_HALF_HP = 0.5

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
    #モンスターが変身したかどうかを判定するフラグ
    @transform_flag = false
    #変身する際の閾値(トリガー)を計算
    @trigger_of_transform = params[:hp] * CALC_HALF_HP
  end

  def attack(brave)
    #HPが半分以下、かつモンスター変身判定フラグがfalseのときに実行
    if @hp <= @trigger_of_transform && @transform_flag == false
      @transform_flag == true
      transform
    end
    puts "#{@name}の攻撃"

    damage = calculate_damage(brave)

    cause_damage(target: brave, damage: damage)

    puts "#{brave.name}の残りのHPは#{brave.hp}だ"
  end

  private

    def calculate_damage(target)
      @offense - target.defense
    end

    def cause_damage(**params)
      damage = params[:damage]
      target = params[:target]

      target.hp -= damage

      #ターゲットのHPがマイナスになるなら0を代入
      target.hp = 0 if target.hp < 0

      puts "#{target.name}は#{damage}のダメージを受けた"
    end

    def transform
      #変身後の名前入
      transform_name = "ドラゴン"

      puts <<~EOS
      #{@name}は起こっている
      #{@name}は#{transform_name}に変身した
      EOS

      #モンスターの攻撃力を1.5倍にする
      @offense *= POWER_UP_RATE
      @name = transform_name
    end
end

#インスタンスごとにパラメーターを自由に設定できる
brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)

#ハッシュ形式でデータを渡すためどういうデータを渡しているのかの把握がしやすい
monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

loop do
  brave.attack(monster)
  break if monster.hp <= 0

  monster.attack(brave)
  break if brave.hp <= 0
end

battle_result = brave.hp > 0

if battle_result
  exp = (monster.offense + monster.defense) * 2
  gold = (monster.offense + monster.defense) * 3
  puts "#{brave.name}はたたかいに勝った"
  puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
else
  puts "#{brave.name}はたたかいに負けた"
  puts "目の前が真っ暗になった"
end
