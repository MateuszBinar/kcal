require "dry/transaction"
class FetchWeeks
  include Dry::Transaction
  step :fetch, catch: ActiveRecord::ActiveRecordError

  def fetch (params)
    if params[:beg]
      Success(entries: Entry.where("created_at >= ? AND created_at < ?", (params[:beg]),( params[:end])), view_date: params[:beg])
    else
      Success(entries: Entry.where("created_at >= ? AND created_at < ?", Date.current.midnight, Date.current.midnight + 1.day), view_date: Date.current.midnight)
    end
  end
end