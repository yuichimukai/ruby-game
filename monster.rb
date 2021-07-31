require './character'

class Monster < Character

  POWER_UP_RATE = 1.5

  #HPの半分の値を計算する定数
  CALC_HALF_HP = 0.5

  def initialize(**params)
    #キャラクタークラスのinitializeメソッドに処理を渡す
    super(
      name: params[:name],
      hp: params[:hp],
      offense: params[:offense],
      defense: params[:defense]
    )

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

    damage = calculate_damage(brave)
    cause_damage(target: brave, damage: damage)
    attack_message(target: brave)
    damage_message(target: brave, damage: damage)
  end

  private

    def calculate_damage(target)
      @offense - target.defense
    end

    def cause_damage(**params)
      damage = params[:damage]
      target = params[:target]

      target.hp -= damage
      target.hp = 0 if target.hp < 0
    end

    def transform
      #変身後の名前入
      transform_name = "ドラゴン"

      transform_message(origin_name: @name, transform_name: transform_name)

      #モンスターの攻撃力を1.5倍にする
      @offense *= POWER_UP_RATE
      @name = transform_name
    end
end
