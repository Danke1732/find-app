# テーブル設計

## users テーブル

| Column                | Type    | Options                   |
| --------------------- | ------- | ------------------------- |
| nickname              | string  | null: false               |
| email                 | string  | null: false, unique: true |
| encrypted_password    | string  | null: false               |

### Association

- has_many :articles
- has_many :comments

## articles テーブル

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| title              | string      | null: false                    |
| text               | text        | null: false                    |
| category_id        | integer     | null: false, foreign_key: true |
| user               | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :category
- has_many :comments
- has_many :articles_tags
- has_many :tags, through: :articles_tags

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

## tags テーブル

| Column         | Type           | Options                        |
| -------------- | -------------  | ------------------------------ |
| name           | string         | null: false, unique: true      |

### Association

- has_many :articles_tags
- has_many :articles, through: :articles_tags

## articles_tags テーブル

| Column         | Type           | Options                        |
| -------------- | -------------  | ------------------------------ |
| article_id     | references     | null: false  foreign_key: true |
| tag_id         | references     | null: false, foreign_key: true |

### Association

- belongs_to :article
- belongs_to :tag