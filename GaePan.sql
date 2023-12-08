CREATE USER 'geapan'@'%' identified by '!Q2w3e4r';
grant all privileges on GeaPan.* to 'geapan'@'%';
flush PRIVILEGES;

SELECT * FROM gp_board
ORDER BY `bno` DESC;

SELECT * FROM gp_board
WHERE `group` = 'notice';

CREATE TABLE gp_board (
  bno INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  uid VARCHAR(20) NOT NULL,
  title VARCHAR(50),
  content LONGTEXT,
  `group` VARCHAR(20) NOT NULL,
  cate INT NOT NULL,
  `type` INT NOT NULL,
  regIP VARCHAR(50),
  regDate DATETIME NOW(),
  hit INT DEFAULT 0,
  parent INT DEFAULT 0,
  `comment` TEXT
);
/*
CREATE TABLE gp_comment(
	cno INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	uid VARCHAR(20) NOT NULL,
	`comment` TEXT,
	`group` VARCHAR(20),
	parent INT NOT NULL,
	regIP VARCHAR(50),
   regDate DATETIME DEFAULT CURRENT_TIMESTAMP
); 
*/

ALTER TABLE gp_board
MODIFY COLUMN regDate DATETIME DEFAULT NOW();

SELECT * FROM gp_member
ORDER BY `no` DESC;


UPDATE gp_member SET
	`name` = 'null',
	gender = 'null'	
WHERE `no` IN(2,3); 

-- cate type 전체 조회
SELECT DISTINCT
	bt.*,
#	`group`,
	bc.cateName
FROM gp_board_type AS bt
JOIN gp_board_cate AS bc
	ON bt.cate = bc.cate
# JOIN gp_board AS b
#	ON b.`type` = bt.`type`
#WHERE `group` = 'notice'
ORDER BY `type` ASC;


SELECT DISTINCT
    bt.*,
    bc.cateName,
    CASE
        WHEN bt.`type` >= 10 AND bt.`type` < 20 THEN 'notice'
        WHEN bt.`type` >= 20 AND bt.`type` < 30 THEN 'faq'
        WHEN bt.`type` >= 30 AND bt.`type` < 40 THEN 'qna'
        ELSE NULL
    END AS `group`
FROM gp_board_type AS bt
JOIN gp_board_cate AS bc ON bt.cate = bc.cate
ORDER BY bt.`type` ASC;

-- group에 따라 cateName 조회
SELECT DISTINCT
	BC.*,
	B.`group`
FROM gp_board_cate AS BC
JOIN gp_board AS B
	ON BC.cate = B.cate
WHERE `group` = 'notice'
ORDER BY cate ASC;

SELECT DISTINCT `group` FROM gp_board;


-- cate 별로 조회
SELECT 
	b.*,
	bc.cateName
FROM gp_board AS b
JOIN gp_board_cate AS bc
	ON b.cate = bc.cate
WHERE `group` = 'notice'
AND b.cate = 11
ORDER BY bno ;

SELECT * FROM gp_member
WHERE `role` IN(2,3)
ORDER BY `no` DESC;


SELECT 
	B.*, 
	BT.typeName,
	M.nick
FROM gp_board B
JOIN gp_board_type AS BT
ON B.`type` = BT.`type`
JOIN gp_member AS M
ON B.uid = M.uid
WHERE bno = 169;



INSERT INTO gp_board
VALUES(NULL, 'phone', '이게뭔가요?', '그러게요', 'faq', 21, 23, '127.0.0.1', NOW(), 0, 0, NULL);

-- 가장 최근에 insert된 auto-increment 값을 반환
-- 바로 직전에 insert된 행의 pk값을 가져옴
SELECT LAST_INSERT_ID();

UPDATE gp_board SET 
parent = LAST_INSERT_ID()
WHERE bno = LAST_INSERT_ID();

UPDATE gp_board SET
	title = 'notice 수정',
	content = '이수정',
	`group` = 'notice',
	cate = 12,
	`type` = 16
WHERE bno = 166;

	
INSERT INTO gp_board SET
	uid = 'admin',
	`group` = 'notice',
	cate = 12,
	`type`= 15,
	`comment` =  '댓글 테스트';
	
UPDATE gp_board SET 
	`comment` = '댓글 수정 테스트'
WHERE bno = 181;	
	
	
SELECT 
	b.*,
	c.bno,
	m.nick,
	c.`comment`,
	c.regDate
FROM gp_board AS b
LEFT JOIN gp_board AS c
ON b.bno = c.parent
JOIN gp_member AS m
ON c.uid = m.uid
WHERE b.bno = 36;
	

UPDATE gp_board SET 
parent = LAST_INSERT_ID()
WHERE bno = LAST_INSERT_ID();

SELECT COUNT(*) from gp_board
WHERE parent = 36;

SELECT
   b.*,
   COUNT(c.bno) AS commentCount
FROM gp_board AS b
LEFT JOIN gp_board AS c
   ON b.bno = c.parent
WHERE b.bno = 36;

SELECT * from gp_board
WHERE `group` = 'faq';


/*
<select id="selectPostIn" resultType="domain.blog.Post">
  SELECT *
  FROM POST P
  WHERE ID in
  <foreach item="member" index="index" collection="list"
      open="(" separator="," close=")">
        #{member.no}
  </foreach>
</select>
*/


