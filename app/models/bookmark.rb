class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :article

  def self.status(bookmark_status)
    if bookmark_status
      @bookmark = 'true'
      @bookmark_check = '外す'
    else
      @bookmark = 'false'
      @bookmark_check = 'する'
    end
    [@bookmark, @bookmark_check]
  end

  def self.like_ajax(bookmark_after)
    if bookmark_after
      '外す'
    else
      'する'
    end
  end
end
