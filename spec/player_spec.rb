require 'spec_helper'
require_relative '../player.rb'

describe Player do

  describe '#new' do

    let (:player) { Player.new("white") }

    it "returns a player" do
      expect(player).to be_instance_of(Player)
    end
    it "assigns the color" do
      expect(player.color).to eq("White")
    end

  end


  context 'when asked to move' do
    let (:player) { Player.new("white") }
    let (:move) {player.check_move("a1 b1")}

    describe '#prompt_move' do
      it 'prompts the user'do
        expect{player.prompt_move}.to output("White, your move: (ex.: a1 c4)\n").to_stdout
      end
    end

    describe '#check_move' do
      context 'when receives an invalid input'do
        it 'asks again to the user' do
          expect{player.check_move("a1-4")}.to output("Invalid format, try again.\n").to_stdout
        end
      end
#    it 'returns a correctly formated move' {} #not necessarily legal, just {from: tilea, to: tileb}
    end
  end

end
