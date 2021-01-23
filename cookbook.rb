# frozen_string_literal: true

require 'csv'
require_relative 'recipe'

# This is the recipes repository
class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @filepath = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_to_csv
  end

  # def find_recipe(recipe_index)
  #   @recipes[recipe_index]
  # end

  def mark_recipe_as_done(recipe_index)
    recipe = @recipes[recipe_index]
    recipe.mark_as_done!
    save_to_csv
  end

  private

  def load_csv
    return if @filepath.nil?

    CSV.foreach(@filepath, headers: :first_row, header_converters: :symbol) do |row|
      row[:done] = row[:done] == "true"
      @recipes << Recipe.new(row)
    end
  end

  def save_to_csv
    return if @filepath.nil?

    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@filepath, "wb", csv_options) do |csv|
      csv << ["name", "description", "rating", "prep_time" "done"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end
