module NoteSubmitSupport
  def note_submit
    # メモ投稿フォームがあることを確認する
    expect(page).to have_selector('.memo-form')
    # フォームに内容を入力する
    fill_in 'note[text]', with: @note
    # 送信すると、Noteモデルのカウントが1上がる
    expect do
      find('input[value="メモする"]').click
      sleep 0.5
    end.to change { Note.count }.by(1)
    # フォームに入力した記述がないことを確認する
    value = find('#memo-field')
    expect(value[:value]).to eq ''
  end
end
