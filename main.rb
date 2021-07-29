class Brave
  #attr_readerによりゲッターを省略できる
  attr_reader :name, :offense, :defense
  #セッターとゲッターを一括定義
  attr_accessor :hp

  #new演算子から渡された引数をハッシュで受け取る
  #引数に**を記述することでハッシュしか受け取れなくなる
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

end

class Monster
  #値の取り出しのみ可能
  attr_reader :name, :offense, :defense
  #値の代入・取り出しが可能
  attr_accessor :hp

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end
end

#インスタンスごとにパラメーターを自由に設定できる
brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)

#ハッシュ形式でデータを渡すためどういうデータを渡しているのかの把握がしやすい
monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

#ヒアドキュメントによる記述
puts <<~TEXT
NAME：#{brave.name}
HP：#{brave.hp}
OFFENSE：#{brave.offense}
DEFENSE：#{brave.defense}
TEXT

brave.hp -= 30
puts "#{brave.name}はダメージをうけた！残りHPは#{brave.hp}だ"