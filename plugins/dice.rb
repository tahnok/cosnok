class Dice
  include Cinch::Plugin

  match /roll (\d+)d(\d+)/

  def execute(m,count,roll)
    m.reply(count.to_i.times.inject(0) do |sum,i|
      sum = sum + Random.rand(roll.to_i) + 1
    end)
  end

end
