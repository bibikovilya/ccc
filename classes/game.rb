# frozen_string_literal: true

require 'matrix'
require 'bundler'
require 'active_attr'
require 'colorize'
require_relative 'matrix'
require_relative 'image'
require_relative 'case'
require_relative 'helpers'
require_relative '../solutions/level1'
require_relative '../solutions/level2'
require_relative '../solutions/level3'
require_relative '../solutions/level4'

class Game
  include ActiveAttr::Attributes
  include ActiveAttr::MassAssignment

  attribute :cases

  def initialize
    self.cases = {}

    map_all do |level, i|
      cases[level] ||= []
      cases[level] << Case.new(level: level, number: i)
    end
  end

  def solve
    map_all do |level, i|
      output = File.open(output_filepath(level: level, number: i), 'w')
      output.puts(Kernel.const_get("Level#{level}").solve.call(cases[level][i]))
      output.close
    end
  end

  def success?
    print = {}

    map_all do |level, case_number|
      output = File.readlines(output_filepath(level: level, number: case_number)).map{|s| s.split.map(&:to_i)}
      answer = File.readlines(answer_filepath(level: level, number: case_number)).map{|s| s.split.map(&:to_i)}

      print[level] ||= []
      print[level] << {
        case: case_number,
        success: output == answer,
        expect: answer,
        answer: output
      }
    end

    print.each do |level, cases|
      string = String.new("Level #{level}: [")
      cases.each do |_case|
        string << (_case[:success] ? '.'.colorize(:green) : 'F'.colorize(:red))
      end
      puts string << ']'

      cases.each do |_case|
        string = []
        unless _case[:success]
          string << "Case: #{_case[:case]}"
          string << "Expect: #{_case[:expect]}".colorize(:green)
          string << "Got: #{_case[:answer]}".colorize(:red)
          string << '-'*42
        end
        puts string if string
      end
    end
  end

  private

  def map_all
    (1..4).each do |level|
      0.step do |i|
        break unless File.exist? input_filepath(level: level, number: i)

        yield(level, i) if block_given?
      end
    end
  end
end
