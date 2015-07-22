require_relative '../pieces.rb'
require 'spec_helper.rb'

describe Pawn do
  let(:white_pawn) {Pawn.new("white")}#{from_row: , from_col: , to_row: , to_col: }
  let(:black_pawn) {Pawn.new("black")}
  context 'when asked about the legality of a move' do
    describe '#move_legal?' do
      it 'returns false if passed an illegal move' do
        expect(white_pawn.move_legal?({from_row: 2, from_col: 3, to_row: 5, to_col: 3})).to be false#wrong row
        expect(white_pawn.move_legal?({from_row: 2, from_col: 3, to_row: 4, to_col: 4})).to be false#wrong col
        expect(white_pawn.move_legal?({from_row: 3, from_col: 3, to_row: 5, to_col: 3})).to be false#moved before and tried to move 2
        expect(black_pawn.move_legal?({from_row: 7, from_col: 3, to_row: 4, to_col: 3})).to be false#wrong row
        expect(black_pawn.move_legal?({from_row: 5, from_col: 3, to_row: 4, to_col: 6})).to be false#wrong col
        expect(black_pawn.move_legal?({from_row: 6, from_col: 3, to_row: 4, to_col: 3})).to be false#moved before and tried to move 2
      end
    end
  end
end
