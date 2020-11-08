# frozen_string_literal: true

# Recipe has a description and name
class Recipe
  attr_reader :name, :description

  def initialize(name, description)
    @name = name
    @description = description
  end
end
