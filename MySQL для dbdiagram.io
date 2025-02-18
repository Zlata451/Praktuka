CREATE TABLE Користувачі (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Ім_я VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Пароль VARCHAR(255) NOT NULL,
    Телефон VARCHAR(20),
    Адреса TEXT,
    Роль ENUM('Клієнт', 'Адміністратор') DEFAULT 'Клієнт',
    Дата_створення TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Категорії (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Назва VARCHAR(255) NOT NULL
);

CREATE TABLE Країни_виробники (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Назва VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Товари (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Назва VARCHAR(255) NOT NULL,
    Опис TEXT,
    Ціна DECIMAL(10,2) NOT NULL,
    Кількість INT DEFAULT 0,
    ID_Категорії INT,
    ID_Країни_виробника INT,
    Зображення VARCHAR(255),
    Дата_створення TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Категорії) REFERENCES Категорії(ID) ON DELETE SET NULL,
    FOREIGN KEY (ID_Країни_виробника) REFERENCES Країни_виробники(ID) ON DELETE SET NULL
);

CREATE TABLE Замовлення (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_Користувача INT,
    Сума DECIMAL(10,2),
    Статус ENUM('Очікується', 'Відправлено', 'Доставлено', 'Скасовано') DEFAULT 'Очікується',
    Дата_створення TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Користувача) REFERENCES Користувачі(ID) ON DELETE CASCADE
);

CREATE TABLE Товари_у_замовленні (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_Замовлення INT,
    ID_Товару INT,
    Кількість INT,
    Ціна DECIMAL(10,2),
    FOREIGN KEY (ID_Замовлення) REFERENCES Замовлення(ID) ON DELETE CASCADE,
    FOREIGN KEY (ID_Товару) REFERENCES Товари(ID) ON DELETE CASCADE
);

CREATE TABLE Відгуки (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_Користувача INT,
    ID_Товару INT,
    Оцінка INT CHECK (Оцінка BETWEEN 1 AND 5),
    Коментар TEXT,
    Дата_створення TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Користувача) REFERENCES Користувачі(ID) ON DELETE CASCADE,
    FOREIGN KEY (ID_Товару) REFERENCES Товари(ID) ON DELETE CASCADE
);
