class StaticPagesService
  def initialize params
    @params = params
  end

  def excecute
    check_params
  end

  private
    def check_params
      case @params[:criteria]
      when "most_view"
        Book.visited_desc.page(@params[:page]).per Settings.paginate.show_16
      when "high_to_low"
        Book.price_desc.page(@params[:page]).per Settings.paginate.show_16
      when "low_to_high"
        Book.price_asc.page(@params[:page]).per Settings.paginate.show_16
      else
        Book.created_desc.page(@params[:page]).per Settings.paginate.show_16
      end
    end
end
