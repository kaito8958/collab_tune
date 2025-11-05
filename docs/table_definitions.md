#  CollabTune テーブル定義書

このドキュメントは、CollabTune におけるデータベース設計（テーブル構成・カラム情報・リレーション）をまとめたものです。

---

## 🧩 users テーブル

| カラム名 | 型 | 制約 | 説明 |
|-----------|----|------|------|
| id | bigint | PK | ユーザーID（自動採番） |
| nickname | string | null: false | 表示名 |
| email | string | null: false, unique: true | メールアドレス（ログイン用） |
| encrypted_password | string | null: false | パスワード（Deviseによる暗号化） |
| profile | text |  | 自己紹介文 |
| avatar | string |  | プロフィール画像（ActiveStorage） |
| instrument | string |  | 得意な楽器・担当パート |
| genre | string |  | 好きな音楽ジャンル |
| created_at | datetime | null: false | 登録日時 |
| updated_at | datetime | null: false | 更新日時 |

**アソシエーション**
- has_many :posts  
- has_many :comments  
- has_many :sent_collaborations, class_name: "Collaboration", foreign_key: "requester_id"  
- has_many :received_collaborations, class_name: "Collaboration", foreign_key: "receiver_id"  

---

## 📝 posts テーブル

| カラム名 | 型 | 制約 | 説明 |
|-----------|----|------|------|
| id | bigint | PK | 投稿ID |
| user_id | bigint | FK, null: false | 投稿者ID（users.id 参照） |
| title | string | null: false | 曲のタイトル |
| description | text |  | 曲の説明・コラボ募集内容 |
| audio_file | string |  | 音源ファイル（ActiveStorage） |
| genre | string |  | 曲のジャンル |
| tempo | integer |  | BPM（テンポ） |
| created_at | datetime | null: false | 投稿日時 |
| updated_at | datetime | null: false | 更新日時 |

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

## 🤝 collaborations テーブル

| カラム名 | 型 | 制約 | 説明 |
|-----------|----|------|------|
| id | bigint | PK | コラボ申請ID |
| requester_id | bigint | FK, null: false | 申請者ID（users.id 参照） |
| receiver_id | bigint | FK, null: false | 受信者ID（users.id 参照） |
| post_id | bigint | FK | 対象投稿ID（posts.id 参照） |
| status | string | default: "pending" | 申請状態（pending/accepted/rejected） |
| message | text |  | コラボ申請メッセージ |
| created_at | datetime | null: false | 作成日時 |
| updated_at | datetime | null: false | 更新日時 |

**アソシエーション**
- belongs_to :requester, class_name: "User"  
- belongs_to :receiver, class_name: "User"  
- belongs_to :post  

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

## messages テーブル

| カラム名         | 型        | 制約              | 説明                          |
| ------------ | -------- | --------------- | --------------------------- |
| id           | bigint   | PK              | メッセージID                     |
| chat_room_id | bigint   | FK, null: false | チャットルームID（chat_rooms.id 参照） |
| user_id      | bigint   | FK, null: false | 送信者ID（users.id 参照）          |
| content      | text     | null: false     | メッセージ本文                     |
| created_at   | datetime | null: false     | 送信日時                        |
| updated_at   | datetime | null: false     | 更新日時                        |

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

