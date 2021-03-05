class NotesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: :destroy

  def index
    @user = User.find_by(id: params[:user_id])
    redirect_to root_path if current_user.id != @user.id
    @notes = @user.notes.order('created_at DESC').page(params[:page]).per(15)
  end

  def create
    @note = Note.new(note_params)
    if @note.valid?
      @note.save
      @date = Date.current.strftime('%Y年 %m月 %d日')
      render json: { note: @note, date: @date }
    else
      @error_message = @note.errors.full_messages
      render json: { error_message: @error_message }
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id], user_id: current_user.id)
    @note.destroy
    @note = Note.find_by(id: params[:id], user_id: current_user.id)
    render json: { note: @note }
  end

  private

  def note_params
    params.require(:note).permit(:text).merge(user_id: current_user.id)
  end
end
