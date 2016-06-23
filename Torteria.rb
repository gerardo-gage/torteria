#Torteria

class Torta
  attr_reader :torta_type, :time

  def initialize(torta_type)
    @torta_type = torta_type
    case @torta_type
    when "Pastor" then @time = 12
    when "Milanesa" then @time = 15
    when "Lomo" then @time = 10
    when "Cubana" then @time = 18
    when "Chorizo" then @time = 11
    else "No vendemos esa torta perrito"
    end
  end

  def to_s
  	"La torta que escogiste es de tipo #{@torta_type} y su tiempo de horneado es #{@time} minutos." 
  end

  def cooked?(tiempo_en_el_horno)
    case
    when tiempo_en_el_horno < @time / 2 then "La torta de #{@torta_type} esta cruda"
    when (tiempo_en_el_horno > @time / 2) && (tiempo_en_el_horno < @time) then "La torta de #{@torta_type} está casi lista!!"
    when tiempo_en_el_horno == @time then "La torta de #{@torta_type} esta lista, sácala del horno!"
    else "La torta de #{@torta_type} se quemo :'( ya sacala"
    end
  end
end

class Lote
  attr_reader :bake_time, :torta_arr

  def initialize(tortas_num)
  	puts "Cuantas tortas son necesarias para meter al horno?"
  	@tortas_num = tortas_num
  	@torta_arr = []
  	@bake_time = 0
  end

  def bake?
  	puts (@torta_arr.length == @tortas_num)? "Listo para hornear!" : "Deben ser #{@tortas_num} tortas para poder hornear, hay #{@torta_arr.length}."
  end
  
  def new_torta(tipo)
    @torta_arr << Torta.new(tipo)
  end 
end

class Oven
  attr_reader :lote

  def initialize(lote)
  	@lote = lote
    @baking_time = 0
    @baked_arr = []
  end

  def tiempo_transcurrido(minutes)
  	@baking_time += minutes
  end

  def baked?
  	if @baked_arr == []
      @lote.torta_arr.each do |torta|
        @baked_arr << torta.cooked?(@baking_time)
      end
      @baked_arr
    else
      for i in 0...@lote.torta_arr.length
        @baked_arr[i] = @lote.torta_arr[i].cooked?(@baking_time)
      end
      @baked_arr
    end
  end

  def take_out(tipo)
    @lote.torta_arr.each do |torta| 
      if torta.torta_type == tipo
        @a = @lote.torta_arr.delete(torta)
        @baked_arr.delete(@a.cooked?(@baking_time))
      end
    end
    puts "Sacaste la torta de #{@a.torta_type}, bien!"
    @lote.torta_arr.each {|torta| puts torta.torta_type}
  end
end

puts "Dime, de cuántas tortas va a ser cada lote"
tortas_number = STDIN.gets.chomp.to_i
lote1 = Lote.new(tortas_num)

n = 1
while n < tortas_number + 1
  puts "De qué va a ser la #{n}º torta?"
  torta = STDIN.gets.chomp
  if torta != "" 
    lote1.new_torta(torta)
    lote1.bake? 
    n += 1
  end
end

oven1 = Oven.new(lote1)

while oven1.baked? != []
  oven1.baked?
  puts "Cuánto tiempo ha transcurrido?"
  time = STDIN.gets.chomp.to_i
  oven1.tiempo_transcurrido(time)
  puts "Quieres sacar alguna torta?"
  decition = STDIN.gets.chomp
  if decition == "si"
    puts "Cuál quieres sacar"
    tipo = STDIN.gets.chomp
    oven1.take_out(tipo)
  end	
end

puts "Sacaste todas las tortas del lote!!"







