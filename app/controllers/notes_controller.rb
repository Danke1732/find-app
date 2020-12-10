class NotesController < ApplicationController

  def index

  end

  def create
    @note = Note.new(note_params)
    if @note.save
      ActionCable.server.broadcast 'note_channel', content: @note
    end
  end

  private

  def note_params
    params.require(:note).permit(:text).merge(user_id: current_user.id)
  end
end
