import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // エラー表示がされていれば削除する
    const errorComment = document.getElementById('comment-error');
    if (errorComment != null) {
      errorComment.remove();
    }
    // バリデーションエラー時の処理
    if (`${data.error_message}` == "Text translation missing: ja.activerecord.errors.models.comment.attributes.text.blank") {
      const commentBox = document.querySelector('.comment-box');
      const error = `<div class="error-message" id="comment-error">${data.error_message}</div>`
      commentBox.insertAdjacentHTML('afterbegin', error);
      return null;
    }
    // コメントが正常に保存された場合の処理
    const commentIndicate = document.getElementById('comments-indicate');
    const commentText = document.querySelector('.comment-text');
    // 描画用のHTMLを作成
    const html = `
      <li class="comment">
        <h3 class="comment-user">
          ${data.user.nickname}
        </h3>
        <div>
          ${data.content.text}
        </div>
        <div class="clearfix"></div>
      </li>`;
    // コメント一覧の最初の子要素として描画
    commentIndicate.insertAdjacentHTML('afterbegin', html);
    // 投稿後コメント入力欄を空へする
    commentText.value = '';
  }
});
