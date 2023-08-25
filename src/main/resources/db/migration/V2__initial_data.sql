INSERT INTO Users (username, email, password, created_at)
VALUES
('Fedor', 'fedor@mail.ru', 'myPassword', now()),
('Ted', 'ted@mail.ru', 'myPassword', now()),
('Anna', 'anna@mail.ru', 'myPassword', now()),
('Arina', 'arina@mail.ru', 'myPassword', now());

INSERT INTO FriendRequests (sender_id, receiver_id, status, created_at)
VALUES
(1, 2, 'accepted', now()),
(3, 4, 'pending', now());

INSERT INTO Friends (user1_id, user2_id, created_at)
VALUES
(2, 1, now());

INSERT INTO Messages (user1_id, user2_id, text)
VALUES
(1, 2, 'hello||hi/nhow are u||ok');

INSERT INTO Following (user_id, following_user_id, created_at)
VALUES
(1, 2, now()),
(2, 1, now()),
(3, 4, now());

INSERT INTO Posts (user_id, title, text, created_at)
VALUES
(1, 'Fedor first', 'hello everyone', now()),
(4, 'Arina first', 'hi everyone', now()),
(3, 'Anna first', 'hi all', now());


