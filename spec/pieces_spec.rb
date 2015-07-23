require_relative '../pieces.rb' #{from_row: , from_col: , to_row: , to_col: }
require 'spec_helper.rb'

describe Pawn do
  let(:white_pawn) {Pawn.new("white")}#{from_row: , from_col: , to_row: , to_col: }
  let(:black_pawn) {Pawn.new("black")}
  context 'when asked about the legality of a move' do
    describe '#move_legal?' do
      it 'returns false if passed an illegal move' do
        expect(white_pawn.move_legal?([[2, 3], [5, 3]])).to be false#wrong row
        expect(white_pawn.move_legal?([[2, 3], [4, 4]])).to be false#wrong col
        expect(white_pawn.move_legal?([[3, 3], [5, 3]])).to be false#moved before and tried to move 2
        expect(black_pawn.move_legal?([[7, 3], [4, 3]])).to be false#wrong row
        expect(black_pawn.move_legal?([[5, 3], [4, 6]])).to be false#wrong col
        expect(black_pawn.move_legal?([[6, 3], [4, 3]])).to be false#moved before and tried to move 2
      end
      it 'returns true if passed a legal move' do
        expect(white_pawn.move_legal?({from: {row: 2, col: 3}, to: {row: 3, col: 3}})).to be true
        expect(white_pawn.move_legal?({from: {row: 2, col: 3}, to: {row: 4, col: 3}})).to be true
        expect(white_pawn.move_legal?({from: {row: 5, col: 3}, to: {row: 6, col: 3}})).to be true
        expect(black_pawn.move_legal?({from: {row: 7, col: 3}, to: {row: 5, col: 3}})).to be true
        expect(black_pawn.move_legal?({from: {row: 7, col: 6}, to: {row: 6, col: 6}})).to be true
        expect(black_pawn.move_legal?({from: {row: 6, col: 3}, to: {row: 5, col: 3}})).to be true
      end
    end
    describe '#capture_legal?' do
      it 'returns true in a legal capture' do
        expect(white_pawn.capture_legal?({from_row: 2, from_col: 2, to_row: 3, to_col: 3})).to be true
        expect(white_pawn.capture_legal?({from_row: 4, from_col: 3, to_row: 5, to_col: 2})).to be true
        expect(black_pawn.capture_legal?({from_row: 2, from_col: 1, to_row: 1, to_col: 2})).to be true
        expect(black_pawn.capture_legal?({from_row: 4, from_col: 3, to_row: 3, to_col: 2})).to be true
      end
      it 'returns false in an illegal capture' do
        expect(white_pawn.capture_legal?({from_row: 4, from_col: 3, to_row: 5, to_col: 3})).to be false
        expect(black_pawn.capture_legal?({from_row: 2, from_col: 1, to_row: 1, to_col: 3})).to be false
      end
    end
  end
end

describe Bishop do
  let(:bishop) {Bishop.new('black')}
    context 'when asked to' do
      describe '#move_legal?' do
        it 'returns true moving on a diagonal' do
          expect(bishop.move_legal?({from_row: 1, from_col: 2, to_row: 7, to_col: 8})).to be true
          expect(bishop.move_legal?({from_row: 2, from_col: 5, to_row: 6, to_col: 1})).to be true
        end
        it 'returns false moving outside the diagonal' do
          expect(bishop.move_legal?({from_row: 1, from_col: 3, to_row: 7, to_col: 8})).to be false
          expect(bishop.move_legal?({from_row: 2, from_col: 5, to_row: 5, to_col: 1})).to be false
        end
      end
    end
end

describe Knight do
  let(:knight) {Knight.new('white')}
    context 'when asked to' do
      describe '#move_legal?' do
        it 'returns true when move legal' do
          expect(knight.move_legal?({from_row: 4, from_col: 4, to_row: 6, to_col: 5})).to be true
          expect(knight.move_legal?({from_row: 4, from_col: 4, to_row: 6, to_col: 3})).to be true
          expect(knight.move_legal?({from_row: 4, from_col: 4, to_row: 5, to_col: 6})).to be true
          expect(knight.move_legal?({from_row: 4, from_col: 4, to_row: 5, to_col: 2})).to be true
          expect(knight.move_legal?({from_row: 4, from_col: 4, to_row: 3, to_col: 6})).to be true
          expect(knight.move_legal?({from_row: 4, from_col: 4, to_row: 3, to_col: 2})).to be true
          expect(knight.move_legal?({from_row: 4, from_col: 4, to_row: 2, to_col: 5})).to be true
          expect(knight.move_legal?({from_row: 4, from_col: 4, to_row: 2, to_col: 3})).to be true
        end
        it 'returns false when move illegal' do
          expect(knight.move_legal?({from_row: 4, from_col: 4, to_row: 2, to_col: 2})).to be false
          expect(knight.move_legal?({from_row: 4, from_col: 4, to_row: 4, to_col: 6})).to be false

        end

      end
    end
end

describe Rook do
  let(:rook) {Rook.new('white')}
    context 'when asked to' do
      describe '#move_legal?' do
        it 'returns true when move legal' do
          expect(rook.move_legal?({from_row: 5, from_col: 6, to_row: 5, to_col: 1})).to be true
          expect(rook.move_legal?({from_row: 5, from_col: 6, to_row: 8, to_col: 6})).to be true
        end
        it 'returns false when move illegal' do
          expect(rook.move_legal?({from_row: 5, from_col: 6, to_row: 3, to_col: 1})).to be false
        end
      end
    end
end

describe Queen do
  let(:queen) {Queen.new('white')}
    context 'when asked to' do
      describe '#move_legal?' do
        it 'returns true when move legal' do
          expect(queen.move_legal?({from_row: 5, from_col: 6, to_row: 5, to_col: 1})).to be true
          expect(queen.move_legal?({from_row: 5, from_col: 6, to_row: 8, to_col: 6})).to be true
          expect(queen.move_legal?({from_row: 1, from_col: 2, to_row: 7, to_col: 8})).to be true
          expect(queen.move_legal?({from_row: 2, from_col: 5, to_row: 6, to_col: 1})).to be true
        end
        it 'returns false when move illegal' do
          expect(queen.move_legal?({from_row: 5, from_col: 6, to_row: 3, to_col: 1})).to be false
        end
      end
    end
end

describe King do
  let(:king) {King.new('white')}
    context 'when asked to' do
      describe '#move_legal?' do
        it 'returns true when move legal' do
          expect(king.move_legal?({from_row: 5, from_col: 6, to_row: 5, to_col: 7})).to be true
          expect(king.move_legal?({from_row: 7, from_col: 6, to_row: 8, to_col: 6})).to be true
          expect(king.move_legal?({from_row: 1, from_col: 2, to_row: 2, to_col: 1})).to be true
          expect(king.move_legal?({from_row: 2, from_col: 5, to_row: 1, to_col: 6})).to be true
        end
        it 'returns false when move illegal' do
          expect(king.move_legal?({from_row: 5, from_col: 6, to_row: 5, to_col: 1})).to be false
          expect(king.move_legal?({from_row: 5, from_col: 6, to_row: 8, to_col: 6})).to be false
          expect(king.move_legal?({from_row: 1, from_col: 2, to_row: 7, to_col: 8})).to be false
          expect(king.move_legal?({from_row: 2, from_col: 5, to_row: 6, to_col: 1})).to be false
        end
      end
    end
end
