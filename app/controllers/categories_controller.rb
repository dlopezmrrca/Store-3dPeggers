class CategoriesController < InheritedResources::Base
  before_action :check_admin_priv, only: %i[ new create edit update destroy ]

  private

    def category_params
      params.require(:category).permit(:name)
    end

end
