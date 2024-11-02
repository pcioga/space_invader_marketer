# frozen_string_literal: true

require_relative 'invader'
# Loads radar sample and checks for Invaders patterns
class Radar
  FILE_PATH = './samples/radar.txt'

  def initialize
    @invader = Invader.new('invader1')
    @file_path = FILE_PATH
    @radar = read_radar_file.split("\n")
  end

  def scan
    invader_width = @invader.signature.length
    @radar.each_with_index do |row, index_row|
      (0..row.length).each do |column|
        check_for_match(index_row, column) if @invader.signature == row[column, invader_width]
      end
    end
  end

  private

  def check_for_match(row, column)
    p row
    p column
  end

  def read_radar_file
    File.read(@file_path)
  rescue Errno::ENOENT
    raise "Error: File '#{@file_path}' not found"
  rescue SystemCallError => e
    raise "Error reading file: #{e.message}"
  end
end
