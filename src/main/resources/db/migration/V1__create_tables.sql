--Пользователи
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY, --Уникальный идентификатор записи
    username VARCHAR(30), --уникальное имя пользователя
    email VARCHAR NOT NULL, --уникальный адрес электронной почты
    password VARCHAR(100) NOT NULL, --хэшированный пароль
	created_at TIMESTAMP NOT NULL DEFAULT NOW() --дата и время регистрации
);

--Посты
CREATE TABLE Posts (
    post_id SERIAL PRIMARY KEY, --Уникальный идентификатор записи
    user_id BIGINT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE, --автор поста
    title VARCHAR(255), --заголовок поста
	text TEXT NOT NULL, --текст поста
	image_url VARCHAR(255), --ссылка на изображение
	created_at TIMESTAMP NOT NULL DEFAULT NOW() --дата и время создания поста
);

--Заявки в друзья
CREATE TABLE FriendRequests (
    request_id SERIAL PRIMARY KEY, --Уникальный идентификатор записи
    sender_id BIGINT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE, --отправитель заявки
    receiver_id  BIGINT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE, --получатель заявки
	status VARCHAR(10) NOT NULL CHECK (status IN ('pending', 'rejected', 'accepted')), --статус заявки (ожидается/отклонено/принято)
	created_at TIMESTAMP NOT NULL DEFAULT NOW() --дата и время создания заявки
);

--Друзья
CREATE TABLE Friends (
    friendship_id SERIAL PRIMARY KEY, --Уникальный идентификатор записи
    user1_id BIGINT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE, --первый друг
    user2_id BIGINT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE, --второй друг
	created_at TIMESTAMP NOT NULL DEFAULT NOW() --дата и время когда стали друзьями
);

--Сообщения (упрощенно, так как чата создано не будет)
CREATE TABLE Messages (
    message_id SERIAL PRIMARY KEY, --Уникальный идентификатор записи
    user1_id BIGINT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE, --первый пользователь с доступом к этому чату
    user2_id  BIGINT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE, --второй пользователь с доступом к этому чату
	text TEXT NOT NULL --текст всех сообщений чата где разделителем сообщений пользователей будет выступать ||
);

--Подписки (на кого подписан пользователь)
CREATE TABLE Following (
    following_id SERIAL PRIMARY KEY NOT NULL, --Уникальный идентификатор записи
    user_id BIGINT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE, --пользователь
    following_user_id BIGINT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE, --на кого подписан пользователь
    created_at  TIMESTAMP NOT NULL DEFAULT NOW() --дата и время начала подписки
);
