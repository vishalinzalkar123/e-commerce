class Products::FilterQuery
  attr_reader :params

  def initialize(scope: Product.all, params = {})
    @scope = scope
    @params = params
  end

  def call
    filtered = @scope
    filtered = filtered.available if params[:available] == "true"
    filtered = filtered.min_price(params[:min_price]) if params[:min_price].present?
    filtered = filtered.max_price(params[:max_price]) if params[:max_price].present?
    filtered
  end
end