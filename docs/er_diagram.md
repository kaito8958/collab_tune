## ER図
```mermaid
erDiagram
  %% 横方向に展開
  direction LR

  USERS {
    bigint id PK
    string nickname
    string email
    string encrypted_password
    text introduction
    string daw
    json performance_skill
    json production_skill
    json looking_for_skill
    text goal
    json links
    json genres
    datetime created_at
    datetime updated_at
  }

  POSTS {
    bigint id PK
    bigint user_id FK
    string title
    text description
    json genre_ids
    json looking_for_skill_ids
    text recruiting_details
    integer tempo
    integer status
    datetime created_at
    datetime updated_at
  }

  COMMENTS {
    bigint id PK
    bigint user_id FK
    bigint post_id FK
    text body
    datetime created_at
    datetime updated_at
  }

  COLLABORATIONS {
    bigint id PK
    bigint requester_id FK
    bigint receiver_id FK
    bigint post_id FK
    string status
    text message
    datetime created_at
    datetime updated_at
  }

  CHAT_ROOMS {
    bigint id PK
    bigint collaboration_id FK
    bigint requester_id FK
    bigint receiver_id FK
    datetime created_at
    datetime updated_at
  }

  MESSAGES {
    bigint id PK
    bigint chat_room_id FK
    bigint user_id FK
    text content
    boolean read
    datetime created_at
    datetime updated_at
  }

  USERS ||--o{ POSTS : "has many"
  USERS ||--o{ COMMENTS : "writes"
  USERS ||--o{ COLLABORATIONS : "as requester"
  USERS ||--o{ COLLABORATIONS : "as receiver"
  USERS ||--o{ MESSAGES : "sends"
  POSTS ||--o{ COMMENTS : "has many"
  POSTS ||--o{ COLLABORATIONS : "has many"
  COLLABORATIONS ||--|| CHAT_ROOMS : "has one"
  CHAT_ROOMS ||--o{ MESSAGES : "has many"
