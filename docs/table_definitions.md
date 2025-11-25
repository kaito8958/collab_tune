#  CollabTune テーブル定義書

このドキュメントは、CollabTune におけるデータベース設計（テーブル構成・カラム情報・リレーション）をまとめたものです。

---

| カラム名               | 型        | 制約                        | 説明                            |
| ------------------ | -------- | ------------------------- | ----------------------------- |
| id                 | bigint   | PK                        | ユーザーID（自動採番）                  |
| nickname           | string   | null: false               | 表示名                           |
| email              | string   | null: false, unique: true | メールアドレス（ログイン用）                |
| encrypted_password | string   | null: false               | パスワード（Devise による暗号化）          |
| introduction       | text     |                           | 自己紹介文                         |
| daw                | string   |                           | 使用しているDAW名                    |
| performance_skill  | json     |                           | 演奏系スキル（複数選択）                  |
| production_skill   | json     |                           | 制作系スキル（複数選択）                  |
| looking_for_skill  | json     |                           | 募集中のスキル（複数選択）                 |
| goal               | text     |                           | やりたいこと・方向性                    |
| links              | json     |                           | YouTube, SoundCloud などの URL 群 |
| genres             | json     |                           | 得意/好きなジャンルのリスト                |
| created_at         | datetime | null: false               | 登録日時                          |
| updated_at         | datetime | null: false               | 更新日時                          |


**アソシエーション**
- has_many :posts  
- has_many :comments  
- has_many :sent_collaborations, class_name: "Collaboration", foreign_key: "requester_id"  
- has_many :received_collaborations, class_name: "Collaboration", foreign_key: "receiver_id"  
- has_many :messages

---

| カラム名                  | 型        | 制約              | 説明                              |
| --------------------- | -------- | --------------- | ------------------------------- |
| id                    | bigint   | PK              | 投稿ID                            |
| user_id               | bigint   | FK, null: false | 投稿者ID（users.id 参照）              |
| title                 | string   | null: false     | 曲のタイトル                          |
| description           | text     |                 | 曲の説明                            |
| genre_ids             | json     |                 | 選択ジャンル（複数）                      |
| looking_for_skill_ids | json     |                 | 募集中スキル（複数）                      |
| recruiting_details    | text     |                 | 募集している内容の詳細                     |
| tempo                 | integer  |                 | BPM（テンポ）                        |
| status                | integer  | default: 0      | enum（0: recruiting / 1: closed） |
| created_at            | datetime | null: false     | 投稿日時                            |
| updated_at            | datetime | null: false     | 更新日時                            |


**アソシエーション**
- belongs_to :user  
- has_many :comments  
- has_many :collaborations  

---

## 💬 comments テーブル

| カラム名 | 型 | 制約 | 説明 |
|-----------|----|------|------|
| id | bigint | PK | コメントID |
| user_id | bigint | FK, null: false | 投稿者ID（users.id 参照） |
| post_id | bigint | FK, null: false | 対象投稿ID（posts.id 参照） |
| body | text | null: false | コメント本文 |
| created_at | datetime | null: false | 投稿日時 |
| updated_at | datetime | null: false | 更新日時 |

**アソシエーション**
- belongs_to :user  
- belongs_to :post  

---

| カラム名         | 型        | 制約                 | 説明                                  |
| ------------ | -------- | ------------------ | ----------------------------------- |
| id           | bigint   | PK                 | コラボ申請ID                             |
| requester_id | bigint   | FK, null: false    | 申請者ID（users.id 参照）                  |
| receiver_id  | bigint   | FK, null: false    | 受信者ID（users.id 参照）                  |
| post_id      | bigint   | FK, null: false    | 対象投稿ID（posts.id 参照）                 |
| status       | string   | default: "pending" | 申請状態（pending / accepted / rejected） |
| message      | text     |                    | コラボ申請メッセージ                          |
| created_at   | datetime | null: false        | 作成日時                                |
| updated_at   | datetime | null: false        | 更新日時                                |


**アソシエーション**
- belongs_to :requester, class_name: "User"  
- belongs_to :receiver, class_name: "User"  
- belongs_to :post  
- has_one :chat_room
---


## chat_rooms テーブル

| カラム名             | 型        | 制約              | 説明                              |
| ---------------- | -------- | --------------- | ------------------------------- |
| id               | bigint   | PK              | チャットルームID                       |
| collaboration_id | bigint   | FK, null: false | 対応するコラボID（collaborations.id 参照） |
| requester_id     | bigint   | FK, null: false | チャットを開始したユーザー（申請者）              |
| receiver_id      | bigint   | FK, null: false | 受信ユーザー（投稿者）                     |
| created_at       | datetime | null: false     | 作成日時                            |
| updated_at       | datetime | null: false     | 更新日時                            |

**アソシエーション**

- belongs_to :collaboration
- belongs_to :requester, class_name: "User"
- belongs_to :receiver, class_name: "User"
- has_many :messages, dependent: :destroy

---

| カラム名         | 型        | 制約              | 説明            |
| ------------ | -------- | --------------- | ------------- |
| id           | bigint   | PK              | メッセージID       |
| chat_room_id | bigint   | FK, null: false | チャットルームID     |
| user_id      | bigint   | FK, null: false | 送信者ID         |
| content      | text     | null: false     | メッセージ本文       |
| read         | boolean  | default: false  | 未読/既読（通知バッジ用） |
| created_at   | datetime | null: false     | 送信日時          |
| updated_at   | datetime | null: false     | 更新日時          |


**アソシエーション**

- belongs_to :chat_room
- belongs_to :user

## 🔗 リレーション図（参考）

```mermaid
erDiagram
  USERS ||--o{ POSTS : "has many"
  USERS ||--o{ COMMENTS : "has many"
  USERS ||--o{ COLLABORATIONS : "sent (requester)"
  USERS ||--o{ COLLABORATIONS : "received (receiver)"
  USERS ||--o{ MESSAGES : "sends"
  POSTS ||--o{ COMMENTS : "has many"
  POSTS ||--o{ COLLABORATIONS : "has many"
  COLLABORATIONS ||--|| CHAT_ROOMS : "has one"
  CHAT_ROOMS ||--o{ MESSAGES : "has many"

