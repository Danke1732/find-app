# Find it.

## アプリケーションの概要

Find it.では、記事の投稿、一覧表示、編集、削除、メモ機能、記事検索、記事のブックマーク登録を行うことができます。

## App URL
 [https://find-it2020.herokuapp.com/](https://find-it2020.herokuapp.com/ "Find it.")

 ### BASIC認証
ユーザー名 : danke

パスワード : 3110

## 制作背景
日常の中で、よりよく人生を歩めるような豆知識や情報、取り入れたいことを自分なりに記録するツールが欲しいと思いこのアプリケーションを作成しました。

メモ特化型の情報サイトを目指しています。


## ターゲット層
新しい情報を逃さず入手したいと思っている20代前半の方をターゲット層としてアプリケーションを作成してみました。


## テスト用アカウント
email : test@test1 

password : test11

## 利用方法
- ### 登録ユーザー

    記事の投稿、記事へのブックマーク、記事へのコメント、サイドバーからメモの記録、記事の検索(ユーザー登録未でも可)を行うことができます。

- ### 記事の投稿者

    本人が投稿した記事の編集、削除、コメントの削除を行うことができます。

## 目指した課題解決
- ユーザーが記事の情報からすぐに控えることができるようにサイドバーにメモ機能を設けました。

## 洗い出した要件
- ### メモ機能
  
  記事を閲覧している中でユーザーが大事な情報や気づきを記録できるようにします。

- ### コメント機能

  コメント機能を設けることでユーザーが記事に対して質問や感想等のコミュニケーションを取ることでよりよい記事投稿に繋がります。

- ### ブックマーク機能

  ユーザー自身が投稿記事にブックマーク登録をすることで何度も閲覧したいと思った時に印をつけることで記事の管理がしやすくなります。

- ### 検索機能

  ユーザーが簡単により早く目当ての記事を検索できるようにします。

- ### カテゴリー検索機能

  ユーザーが簡単により早く目当ての記事を探せるようにカテゴリー検索ができるようにします。

- ### ページネーション機能

  記事一覧表示画面の記事数を固定して表示させることにより、サイト内をまとめることでユーザーがサイト内を巡回しやすくします。
  
- ### ユーザープロフィール機能

  ユーザーのプロフィール一覧を設けることで趣味趣向の合うユーザーと繋がりやすくすることで目当ての記事を探せるようにします。

## 実装した機能

- ### メモ機能
  
  サイドバーにメモ欄を設けました。

  サイドバーのメモ欄にメモを記述し「メモする」をクリックするとメモを記録することができるようにしました。

  基本的には登録フォーム以外(記事投稿・ログイン・新規登録)であれば、サイドバーから保存することができます。

  メモはサイドバーのノートタブをクリックするとこれまでのメモ内容を確認することができます。削除ボタンで削除も可能です。

  [![メモ機能](https://i.gyazo.com/6ec7a03b4fd4033b5978fc168701a1e6.gif)](メモ機能の挙動)

- ### コメント機能

  記事詳細画面のコメント入力欄にコメントを入力し、「コメントする」ボタンを押すとコメントとできるようにしました。

  削除ボタンをクリックすることで、削除することも可能です。

  [![コメント機能](https://i.gyazo.com/68aba622245723cfbe0541606ef6eb7b.gif)](コメント機能の挙動)

- ### ブックマーク機能

  記事詳細画面のブックマークボタンを設けました。

  ブックマークボタンをクリックすることでお気に入り登録をすることができるようにしました。再度クリックするとブックマーク登録が外れるようになっています。

  サイドバーのブックマークタブをクリックするとブックマーク記事一覧を確認できます。

  [![ブックマーク機能](https://i.gyazo.com/76ba95c14061f27d6fed7012a5c67d45.gif)](ブックマーク機能の挙動)

- ### 検索機能

  サイドバーの検索欄から検索することができ、複数単語検索と記事タイトルと本文の両方から探せるようにしました。

  [![検索機能](https://i.gyazo.com/2e989ab2fadc99d63055ff42956627c0.gif)](検索機能の挙動)

- ### カテゴリー検索機能
  サイドバーの「カテゴリー一覧」からカテゴリー一覧画面へ遷移できるようにして各カテゴリーを選択するとカテゴリーに該当する記事を表示できるようにしました。

  [![カテゴリー検索機能](https://i.gyazo.com/e2cfb53b9235358dc0416d59cf78bba2.gif)](カテゴリー検索機能の挙動)

- ### ページネーション機能

  記事一覧及びブックマーク記事一覧、ログインユーザー（本人）投稿記事一覧、メモ一覧へそれぞれページネーション機能を設けました。

  メモ一覧のページネーション機能

  [![ページネーション機能メモ](https://i.gyazo.com/42921081216cf0860cb1c4b5782b7202.gif)](ページネーション機能の挙動2)

- ### ユーザープロフィール機能

  サイドバーのユーザー一覧から各ユーザーの「プロフィールを見る」リンクからそのユーザーのプロフィールを確認することができるようにしました。

  [![プロフィール一覧](https://i.gyazo.com/0a5a1d5990f3c165861f94130f6bc1a6.gif)](プロフィール一覧)

## 実装予定の機能

今後はユーザーがより早く記事を探すことができるように記事にタグ付け機能を設けるようにし、実装していきたいと考えています。


# データベース設計

## users テーブル

| Column                | Type    | Options                   |
| --------------------- | ------- | ------------------------- |
| nickname              | string  | null: false               |
| email                 | string  | null: false, unique: true |
| encrypted_password    | string  | null: false               |

### Association

- has_many :articles
- has_many :comments, dependent: :destroy
- has_many :bookmarks, dependent: :destroy
- has_many :article_marks, through: :bookmarks, source: :article
- has_many :notes
- has_one  :profile

## articles テーブル

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| title              | string      | null: false                    |
| text               | text        | null: false                    |
| category           | references  | null: false, foreign_key: true |
| user               | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one_attached :image
- belongs_to :category
- has_many :comments, dependent: :destroy
- has_many :bookmarks, dependent: :destroy
- has_many :users, through: :bookmarks

## comments テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| text           | text       | null: false                    |
| user           | references | null: false, foreign_key: true |
| article        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :article

## categories テーブル

| Column         | Type           | Options                        |
| -------------- | -------------  | ------------------------------ |
| name           | string         | null: false, unique: true      |
| ancestry       | string         | null: false                    |

### Association

- has_many :articles
- has_ancestry

## bookmarks テーブル

| Column         | Type           | Options                        |
| -------------- | -------------  | ------------------------------ |
| name           | string         | null: false, unique: true      |
| user           | references     | null: false, foreign_key: true |
| article        | references     | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :article

## notes テーブル

| Column         | Type           | Options                        |
| -------------- | -------------  | ------------------------------ |
| text           | text           | null: false                    |
| user           | references     | null: false, foreign_key: true |

## profiles テーブル

| Column         | Type           | Options                        |
| -------------- | -------------  | ------------------------------ |
| hobby          | string         |                                |
| favorite_word  | string         |                                |
| introduction   | text           |                                |
| user           | references     | null: false, foreign_key: true |

### Association

- belongs_to :user

## 動作環境
- ruby 2.6.5
- Rails 6.0.3.4
- Bundler 2.1.4