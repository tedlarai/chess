require_relative '../pieces.rb' #[, ], [, ]
require 'spec_helper.rb'

describe Pawn do
  let(:white_pawn) {Pawn.new("white")}#[, ], [, ]
  let(:black_pawn) {Pawn.new("black")}
  context 'when asked about the legality of a move' do
    describe '#move_legal?' do
      it 'returns false if passed an illegal move' do
        expect(white_pawn.move_legal?([2, 3], [5, 3])).to be false#wrong row
        expect(white_pawn.move_legal?([2, 3], [4, 4])).to be false#wrong col
        expect(white_pawn.move_legal?([3, 3], [5, 3])).to be false#moved before and tried to move 2
        expect(black_pawn.move_legal?([7, 3], [4, 3])).to be false#wrong row
        expect(black_pawn.move_legal?([5, 3], [4, 6])).to be false#wrong col
        expect(black_pawn.move_legal?([6, 3], [4, 3])).to be false#moved before and tried to move 2
      end
      it 'returns true if passed a legal move' do
        expect(white_pawn.move_legal?([2, 3], [3, 3])).to be true
        expect(white_pawn.move_legal?([2, 3], [4, 3])).to be true
        expect(white_pawn.move_legal?([5, 3], [6, 3])).to be true
        expect(black_pawn.move_legal?([7, 3], [5, 3])).to be true
        expect(black_pawn.move_legal?([7, 6], [6, 6])).to be true
        expect(black_pawn.move_legal?([6, 3], [5, 3])).to be true
      end
    end
    describe '#capture_legal?' do
      it 'returns true in a legal capture' do
        expect(white_pawn.capture_legal?([2, 2], [3, 3])).to be true
        expect(white_pawn.capture_legal?([4, 3], [5, 2])).to be true
        expect(black_pawn.capture_legal?([2, 1], [1, 2])).to be true
        expect(black_pawn.capture_legal?([4, 3], [3, 2])).to be true
      end
      it 'returns false in an illegal capture' do
        expect(white_pawn.capture_legal?([4, 3], [5, 3])).to be false
        expect(black_pawn.capture_legal?([2, 1], [1, 3])).to be false
      end
    end
  end
end

describe Bishop do
  let(:bishop) {Bishop.new('black')}
    context 'when asked to' do
      describe '#move_legal?' do
        it 'returns true moving on a diagonal' do
          expect(bishop.move_legal?([1, 2], [7, 8])).to be true
          expect(bishop.move_legal?([2, 5], [6, 1])).to be true
        end
        it 'returns false moving outside the diagonal' do
          expect(bishop.move_legal?([1, 3], [7, 8])).to be false
          expect(bishop.move_legal?([2, 5], [5, 1])).to be false
        end
      end
    end
end

describe Knight do
  let(:knight) {Knight.new('white')}
    context 'when asked to' do
      describe '#move_legal?' do
        it 'returns true when move legal' do
          expect(knight.move_legal?([4, 4], [6, 5])).to be true
          expect(knight.move_legal?([4, 4], [6, 3])).to be true
          expect(knight.move_legal?([4, 4], [5, 6])).to be true
          expect(knight.move_legal?([4, 4], [5, 2])).to be true
          expect(knight.move_legal?([4, 4], [3, 6])).to be true
          expect(knight.move_legal?([4, 4], [3, 2])).to be true
          expect(knight.move_legal?([4, 4], [2, 5])).to be true
          expect(knight.move_legal?([4, 4], [2, 3])).to be true
        end
        it 'returns false when move illegal' do
          expect(knight.move_legal?([4, 4], [2, 2])).to be false
          expect(knight.move_legal?([4, 4], [4, 6])).to be false

        end

      end
    end
end

describe Rook do
  let(:rook) {Rook.new('white')}
    context 'when asked to' do
      describe '#move_legal?' do
        it 'returns true when move legal' do
          expect(rook.move_legal?([5, 6], [5, 1])).to be true
          expect(rook.move_legal?([5, 6], [8, 6])).to be true
        end
        it 'returns false when move illegal' do
          expect(rook.move_legal?([5, 6], [3, 1])).to be false
        end
      end
    end
end

describe Queen do
  let(:queen) {Queen.new('white')}
    context 'when asked to' do
      describe '#move_legal?' do
        it 'returns true when move legal' do
          expect(queen.move_legal?([5, 6], [5, 1])).to be true
          expect(queen.move_legal?([5, 6], [8, 6])).to be true
          expect(queen.move_legal?([1, 2], [7, 8])).to be true
          expect(queen.move_legal?([2, 5], [6, 1])).to be true
        end
        it 'returns false when move illegal' do
          expect(queen.move_legal?([5, 6], [3, 1])).to be false
        end
      end
    end
end

describe King do
  let(:king) {King.new('white')}
    context 'when asked to' do
      describe '#move_legal?' do
        it 'returns true when move legal' do
          expect(king.move_legal?([5, 6], [5, 7])).to be true
          expect(king.move_legal?([7, 6], [8, 6])).to be true
          expect(king.move_legal?([1, 2], [2, 1])).to be true
          expect(king.move_legal?([2, 5], [1, 6])).to be true
        end
        it 'returns false when move illegal' do
          expect(king.move_legal?([5, 6], [5, 1])).to be false
          expect(king.move_legal?([5, 6], [8, 6])).to be false
          expect(king.move_legal?([1, 2], [7, 8])).to be false
          expect(king.move_legal?([2, 5], [6, 1])).to be false
        end
      end
    end
end
