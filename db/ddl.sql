CREATE TABLE IF NOT EXISTS Utente (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) NOT NULL,
    password CHAR(60) NOT NULL,
    -- output length of the implemented hash function
    cognome VARCHAR(30) NOT NULL,
    nome VARCHAR(30) NOT NULL,
    data_nascita DATE NOT NULL,
    sesso ENUM('M', 'F') NOT NULL,
    email VARCHAR(50) CHECK(email REGEXP '^\w[\w\-\.]+\w@([\w\-]+\.)+[\w]+'),
    telefono VARCHAR(15) CHECK(telefono REGEXP '^[+]?([0-9]{6}[0-9]*)$')
)