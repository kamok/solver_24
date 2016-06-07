require 'spec_helper'

describe Solver_24 do
	let(:solver) { Solver_24.new }

  it 'has a version number' do
    expect(Solver24::VERSION).not_to be nil
  end

  it "starts with an empty array of all_expressions"do
    expect(solver.all_expressions).to be_an(Array)
    expect(solver.all_expressions).to be_empty
  end

  it "starts with an empty array of solutions" do
    expect(solver.solutions).to be_an(Array)
    expect(solver.solutions).to be_empty
  end

  describe '#solve' do
    it "calls make_possible_solutions with get_sets_of_numbers" do
      expect(solver).to receive(:make_possible_solutions).with(solver.get_sets_of_numbers([1,2,3,4]))
      solver.solve([1,2,3,4])
    end
  end

  describe '#get_sets_of_numbers' do
    before(:each) do
      @sets_of_numbers = solver.get_sets_of_numbers([1,2,3,4])
    end

    it "returns an array of 24 arrays" do
      expect(@sets_of_numbers.class).to be(Array)

      expect(@sets_of_numbers.count).to be(24)

      @sets_of_numbers.each do |thing|
        expect(thing.class).to be(Array)
      end
    end

    it "each array it returns comprises of the original input" do
      @sets_of_numbers.each do |array|
        expect(array).to match_array([1,2,3,4])
      end
    end
  end

  describe '#make_possible_solutions' do
    before(:each) do
      sets_of_nums = solver.get_sets_of_numbers([1,2,3,4])
      @possible_solutions = solver.make_possible_solutions(sets_of_nums)
    end
    it "returns variations of expressions" do
      @possible_solutions.each do |possible_solution|
         expect(possible_solution).to include([1.0, "+", "(", 2.0, "/", 3.0, "-", 4.0, ")"],
                                     ["(", 1.0, "-", 2.0, "+", 3.0, ")", "/", 4.0],
                                     [1.0, "/", "(", 3.0, "-", 4.0, "-", 2.0, ")"])
      end
    end
  end

  describe '#find_solutions' do
    it "returns solutions for the problem" do
      solver.solve([1,2,3,4])
      expect(solver.solutions).to_not be_empty
      expect(solver.solutions).to include("( 1.0 + 2.0 + 3.0 ) * 4.0", "( 4.0 * 3.0 ) * ( 2.0 * 1.0 )", "4.0 * ( 2.0 + 1.0 + 3.0 )")
    end
  end
end 
