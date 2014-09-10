class CategoriesController < ApplicationController
	def index
    @categories = Category.all.decorate
	end
end
