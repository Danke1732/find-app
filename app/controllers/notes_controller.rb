class NotesController < ApplicationController

  def index

  end

  def create
    @note = Note.new(note_params)
    if @note.valid?
      @note.save
      render json: { note: @note }
    else
      @error_message = @note.errors.full_messages
      render json: { error_message: @error_message }
    end
  end

  private

  def note_params
    params.require(:note).permit(:text).merge(user_id: current_user.id)
  end
end
