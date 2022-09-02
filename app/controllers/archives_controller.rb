class ArchivesController < ApplicationController

  def index
    @entries = Entry.where("user_id = ?", current_user).group_by(&:day)
  end

  def weeks
    if (params[:beg] != nil)
      @entries = Entry.where("created_at >= ? AND created_at < ?", (params[:beg]),( params[:end])) - Entry.where("user_id != ?", current_user)
      @view_date = (params[:beg])
    else
      @entries = Entry.where("created_at >= ? AND created_at < ?  ", Date.current.midnight, Date.current.midnight + 1.day) - Entry.where("user_id != ?", current_user)
      @view_date = Date.current.midnight
    end
  end
end
