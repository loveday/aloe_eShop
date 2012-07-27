class AddQuantityToLineItem < ActiveRecord::Migration
  def self.up
    dd_column :line_items, :quantity, :integer, default: 1
  end

  def self.down
    remove_column :line_items, :quantity
  end
end
