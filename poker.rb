class Carta
    attr_reader :naipe, :simbolo
  
    def initialize(simbolo, naipe)
      @simbolo = simbolo
      @naipe = naipe
    end
  
    def show
      simbolos = [nil, "Ás", 2, 3, 4, 5, 6, 7, 8, 9, 10, "Valete", "Rainha", "Rei"]
      {simbolo: simbolos[@simbolo], naipe: @naipe}
    end
  end
  
  class Baralho
    attr_accessor :cartas
  
    def initialize
      @cartas = []
    end
  
    def addCard(carta)
      @cartas << carta
    end
  
    def sort
      @cartas.sort_by! {|carta| carta.simbolo}
    end
  
    def shuffle
      @cartas.shuffle {|carta| carta.simbolo}
    end
  
    def human_index
      for carta in @cartas
        p carta.show
      end
    end
  
    def size
      @cartas.size
    end
  
    def pull
      i = rand(size)
      @cartas[i]
      @cartas.delete_at(i)
    end
  end
  
  class Poker < Baralho
    attr_reader :table_cards, :bet, :stage, :players
  
    def initialize
      super
      @table_cards = []
      @bet = 0
      @stage = 0
      @players = []
    end
  
    def addPlayer(nome)
      jogador = {id: @players.size, nome: nome, dinheiro: 1000, cartas: [pull, pull], jogo: true}
      @players << jogador
    end
  
    def progressStage
      @stage += 1
      if @stage == 1
        @table_cards << pull
        @table_cards << pull
        @table_cards << pull
        @table_cards << pull
        @table_cards << pull
      elsif @stage > 3
        for carta in @table_cards
          addCard(carta)
        end
        @table_cards = []
  
        for player in @players
          player[:jogo] = true
        end
      end
    end
  
    def raisebet(valor, id)
      for jogador in @players
        puts "#{jogador[:nome]}, você quer aumentar a aposta em #{valor} reais? você tem #{jogador[:dinheiro]} reais"
        resposta = gets.chomp
        if resposta == "sim"
          @bet += valor
          jogador[:dinheiro] -= valor
        else
          jogador[:jogo] = false
        end
      end
    end
  
    def showcards
      intervalo = 0..(@stage + 2)
      puts "#{@table_cards[intervalo].map { |carta| carta.show}}"
    end
  
    def winner
      for carta in @table_cards
        addCard(carta)
      end
      @table_cards = []
      @bet = 0
    end
  end
  
  baralho = Poker.new
  
  
  carta_espadas = Carta.new(1, "Espadas")
  carta_2espadas = Carta.new(11, "Espadas")
  carta_3espadas = Carta.new(12, "Espadas")
  carta_4espadas = Carta.new(13, "Espadas")
  baralho.addCard carta_espadas
  baralho.addCard carta_2espadas
  baralho.addCard carta_3espadas
  baralho.addCard carta_4espadas
  
  carta = Carta.new(1, "Paus")
  carta2 = Carta.new(11, "Paus")
  carta3 = Carta.new(12, "Paus")
  carta4 = Carta.new(13, "Paus")
  baralho.addCard carta
  baralho.addCard carta2
  baralho.addCard carta3
  baralho.addCard carta4
  
  carta_ouros = Carta.new(1, "Ouros")
  carta11_ouros = Carta.new(11, "Ouros")
  carta12_ouros = Carta.new(12, "Ouros")
  carta13_ouros = Carta.new(13, "Ouros")
  baralho.addCard carta_ouros
  baralho.addCard carta11_ouros
  baralho.addCard carta12_ouros
  baralho.addCard carta13_ouros
  
  carta_copas = Carta.new(1, "Copas")
  carta11_copas = Carta.new(11, "Copas")
  carta12_copas = Carta.new(12, "Copas")
  carta13_copas = Carta.new(13, "Copas")
  baralho.addCard carta_copas
  baralho.addCard carta11_copas
  baralho.addCard carta12_copas
  baralho.addCard carta13_copas
  
  puts "Mostrando as cartas...\n"
  p baralho.cartas
  puts
  
  puts "Organizando as cartas...\n"
  p baralho.sort
  puts
  
  puts "Embaralhando as cartas...\n"
  p baralho.shuffle
  puts
  
  puts "Mostrando o show de cada carta...\n"
  baralho.human_index
  
  puts
  
  puts "Quantidade de cartas...\n"
  p baralho.size
  puts
  
  puts "Removendo uma carta...\n"
  p baralho.pull
  puts
  
  puts "Jogadores...\n"
  baralho.addPlayer("Player1")
  baralho.addPlayer("Player2")
  p baralho.players
  puts
  
  baralho.raisebet(1000, 1)
  p baralho.players
  p baralho.bet
  
  puts "Mostrando cartas de acordo com o estágio..."
  baralho.progressStage
  baralho.showcards
  
  baralho.winner