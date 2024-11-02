# frozen_string_literal: true

# Loads samples from .txt files
class SampleLoader
  FILE_PATH = './samples/'

  def self.load_sample(file)
    File.read(FILE_PATH + file).split("\n")
  rescue Errno::ENOENT
    raise "Error: File '#{@file_path}' not found"
  rescue SystemCallError => e
    raise "Error reading file: #{e.message}"
  end
end
