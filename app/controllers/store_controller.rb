# Copyright Notice
# We do not hold full Copyright to the codes
# The codes in this App is a combination of code snippets from
# NCI Class Tutorials and the  {Agile Web Development with Rails}
#[http://www.pragprog.com/titles/rails4/agile-web-development-with-rails-4th-edition].
class StoreController < ApplicationController
  #skip_before_filter :authorize

  def index
    @products = Product.order(:name)
    @cart = current_cart
  end

end
