class ArchivesController < ApplicationController

  def index
    @entries = Entry.where("user_id = ?", current_user).group_by(&:day)
  end

  def weeks
    fetch_weeks = FetchWeeks.new
    fetch_weeks.call(params) do |r|
      r.success { |output| render :weeks, locals: { entries: output[:entries], view_date: output[:view_date] } }
      r.failure { |output| render :weeks}
    end
  end

  def week
    fetch_weeks = FetchWeeks.new
    fetch_weeks.call(params) do |r|
      r.success { |output| render :week, locals: { entries: output[:entries], view_date: output[:view_date] } }
      r.failure { |output| render :week}
    end
    # render :week, locals: { entries: Entry.where("user_id = ?", current_user) }
  end
end
 