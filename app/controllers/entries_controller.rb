class EntriesController < ApplicationController
  before_action :set_entry, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @entries = Entry.where("created_at >= ? AND user_id = ?", Date.today, current_user)
  end

  def show
  end

  def new
    @friend = current_user.entries.build
  end

  def edit
  end

  def create
    @entry = current_user.entries.build(entry_params)
    respond_to do |format|
      if @entry.save
        format.html { redirect_to entries_path, notice: "Entry was successfully created." }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_url, notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

def correct_user
  @entry = current_user.entries.find_by(id: params[:id])
  redirect_to entries_path, notice: "Not authorized to edit this entry" if @friend.nil?
end

  private
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def entry_params
      params.permit(:meal_type, :calories, :fats, :proteins, :carbohydrates, :user_id)
    end
end
