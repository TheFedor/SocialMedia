--создание новой записи в таблице "Following" при добавлении записи в таблицу "FriendRequests"
CREATE OR REPLACE FUNCTION create_following_on_friend_request()
    RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Following (user_id, following_user_id, created_at)
    VALUES (NEW.sender_id, NEW.receiver_id, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_create_following_on_friend_request
    AFTER INSERT ON FriendRequests
    FOR EACH ROW
EXECUTE FUNCTION create_following_on_friend_request();

--Создание новых записей в таблицах "Friends" и "Following" при изменение статуса в таблице "FriendRequests" на "принято"
CREATE OR REPLACE FUNCTION create_following_and_friends_on_accepted_request()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'accepted' AND OLD.status = 'pending' THEN
        INSERT INTO Following (user_id, following_user_id, created_at)
        VALUES (NEW.receiver_id, NEW.sender_id, NOW());

        INSERT INTO Friends (user1_id, user2_id, created_at)
        VALUES (NEW.sender_id, NEW.receiver_id, NOW());
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_create_following_and_friends_on_accepted_request
    AFTER UPDATE ON FriendRequests
    FOR EACH ROW
EXECUTE FUNCTION create_following_and_friends_on_accepted_request();
