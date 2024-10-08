mysql -u root -p

use db_lesson;


CREATE TABLE departments (
    department_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


ALTER TABLE people
ADD COLUMN department_id INT UNSIGNED NULL AFTER email;

desc people;

INSERT INTO departments (name) VALUES 
    ('営業'),
    ('開発'),
    ('経理'),
    ('人事'),
    ('情報システム');


INSERT INTO people (name, email, age, gender, department_id) VALUES 
    ('佐藤太郎', 'sato@example.com', 30, 1, 1), -- 営業
    ('鈴木花子', 'suzuki@example.com', 27, 2, 1), -- 営業
    ('高橋良介', 'takahashi@example.com', 35, 1, 1), -- 営業
    ('田中茂', 'tanaka@example.com', 28, 1, 2), -- 開発
    ('中村友美', 'nakamura@example.com', 26, 2, 2), -- 開発
    ('山本亮', 'yamamoto@example.com', 32, 1, 2), -- 開発
    ('伊藤真理', 'ito@example.com', 29, 2, 2), -- 開発
    ('小林正樹', 'kobayashi@example.com', 40, 1, 3), -- 経理
    ('加藤英美', 'kato@example.com', 45, 2, 4), -- 人事
    ('松本久美', 'matsumoto@example.com', 33, 2, 5); -- 情報システム


INSERT INTO reports (person_id, content) VALUES
(18, '2024年10月8日の業務内容についての報告です。'),
(19, '新しいプロジェクトの進捗状況を報告します。'),
(20, '本日の会議で決まったことをまとめました。'),
(21, '昨日の業務を振り返り、問題点を整理しました。'),
(22, '本日の営業活動についての詳細を報告します。'),
(23, '開発チームの進捗を報告いたします。'),
(24, '顧客からのフィードバックをまとめました。'),
(25, '今週の業務のハイライトをお伝えします。'),
(26, '新しいシステムのテスト結果についての報告です。'),
(27, '今後の予定と注意事項をまとめました。');


UPDATE people
SET department_id = 1
WHERE department_id IS NULL;


SELECT name, age 
FROM people 
WHERE gender = 1 
ORDER BY age DESC;


peopleテーブルからデータを取得します。
対象となるレコードは department_id が1のものに限定されます（WHERE department_id = 1）。
抽出するカラムは name、email、age の3つです。
結果は created_at カラムを基準に昇順で並べ替えられます。


SELECT 
    `name` 
FROM 
    `people` 
WHERE 
    (`gender` = 2 AND `age` BETWEEN 20 AND 29)
    OR (`gender` = 1 AND `age` BETWEEN 40 AND 49);


SELECT 
    `name`, `age`
FROM 
    `people`
WHERE 
    `department_id` = (
        SELECT `department_id` 
        FROM `departments` 
        WHERE `name` = '営業'
    )
ORDER BY 
    `age` ASC;


SELECT 
    AVG(`age`) AS average_age
FROM 
    `people`
WHERE 
    `department_id` = (
        SELECT `department_id`
        FROM `departments`
        WHERE `name` = '開発'
    )
    AND `gender` = 2;


SELECT 
    people.name, 
    departments.name AS department_name, 
    reports.content AS report_content
FROM 
    people
JOIN 
    departments ON people.department_id = departments.department_id
JOIN 
    reports ON people.person_id = reports.person_id;


SELECT 
    AVG(age) AS average_age
FROM 
    people
JOIN 
    departments ON people.department_id = departments.department_id
WHERE 
    departments.name = '開発' 
    AND people.gender = 2;


SELECT 
    people.name AS person_name,
    departments.name AS department_name,
    reports.content AS report_content
FROM 
    people
JOIN 
    departments ON people.department_id = departments.department_id
JOIN 
    reports ON people.person_id = reports.person_id;


SELECT 
    people.name AS person_name
FROM 
    people
LEFT JOIN 
    reports ON people.person_id = reports.person_id
WHERE 
    reports.person_id IS NULL;


