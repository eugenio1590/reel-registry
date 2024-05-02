module Pagination
  extend ActiveSupport::Concern

  def page
    params.fetch(:page, 1)
  end

  def per_page
    params.fetch(:per_page, 10)
  end

  def pagination_info(collection)
    {
      total_pages: collection.total_pages,
      total_count: collection.total_count,
      current_page: collection.current_page,
      per_page: collection.limit_value
    }
  end
end
