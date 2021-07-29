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

    #0~3の間でランダムに数字が変わる
    attack_num = rand(4)

    #1/4の確率でspecial_attackを実行
    if attack_num == 0
      puts "必殺攻撃"
      #calculate_special_attackの呼び出し
      #攻撃力の1.5倍の数値が戻り値として帰ってくる
      damage = calculate_special_attack - monster.defense
    else
      puts "通常攻撃"
      damage = @offense - monster.defense
    end

    monster.hp -= damage

    puts "#{monster.name}は#{damage}のダメージをうけた"
    puts "#{monster.name}の残りHPは#{monster.hp}だ"
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

    damage = @offense - brave.defense
    brave.hp -= damage

    puts "#{brave.name}は#{damage}のダメージをうけた"
    puts "#{brave.name}の残りのHPは#{brave.hp}だ"
  end

  private

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
monster = Monster.new(name: "スライム", hp: 200, offense: 200, defense: 100)

brave.attack(monster)
monster.attack(brave)