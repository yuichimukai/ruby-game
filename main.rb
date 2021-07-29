class Brave
  #attr_readerによりゲッターを省略できる
  attr_reader :name, :hp, :offense, :defense
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

#インスタンスごとにパラメーターを自由に設定できる
brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)

#ヒアドキュメントによる記述
puts <<~TEXT
NAME：#{brave.name}
HP：#{brave.hp}
OFFENSE：#{brave.offense}
DEFENSE：#{brave.defense}
TEXT

brave.hp -= 30
puts "#{brave.name}はダメージをうけた！残りHPは#{brave.hp}だ"