module GameOfLife
  class Board
    include Enumerable

    def initialize(*cells)
      @live_cells = cells.uniq
    end

    def each(&block)
      return to_enum(:each) unless block_given?
      @live_cells.each(&block)
    end

    def next_generation
      cells_to_live = select { |cell| cell_will_live? cell }
      p "cells_to_live #{reproducted_cells.inspect}"
      Board.new *(cells_to_live | reproducted_cells)
    end

    def [](x,y)
      @live_cells.include? [x,y]
    end

    def ==(other)
      all? { |cell| other.include? cell } &
      other.all? { |cell| @live_cells.include? cell }
    end

    private

    def neighbours_of(cell)
      [ [cell[0] - 1, cell[1] - 1],
        [cell[0] - 1, cell[1] + 0],
        [cell[0] - 1, cell[1] + 1],

        [cell[0] + 0, cell[1] - 1],
        [cell[0] + 0, cell[1] + 1],

        [cell[0] + 1, cell[1] - 1],
        [cell[0] + 1, cell[1] + 0],
        [cell[0] + 1, cell[1] + 1] ]
    end

    def alive_neighbours_of(cell)
      @live_cells & neighbours_of(cell)
    end

    def cell_will_live?(cell)
      (2..3) === alive_neighbours_of(cell).count
    end

    def reproducted_cells
      possible_cells = flat_map do |live_cell|
        neighbours_of live_cell
      end.uniq
      possible_cells.select do |cell|
        alive_neighbours_of(cell).count == 3
      end
    end
  end
end