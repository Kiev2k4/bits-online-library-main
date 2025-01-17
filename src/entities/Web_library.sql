-- muốn chạy database và load infile file csv to the database thì trc hết phải theo chỉ dẫn
-- I was having a hard time finding the Program Data folder on my local disk, so for others who might be having the same issue
-- here's a solution on Windows that worked for me: Click your disk, click the 3 dots next to view, click options, click view, 
-- and then click Show hidden files, folders, and drives. After I did that, the Program Data folder showed up!
-- sau đó paste file csv vào cái địa chỉ C:\ProgramData\MySQL\MySQL Server 8.0\Uploads đã hiện ra sau khi hidden file Program Data show up
-- run it, the dataset will be loaded into the database
DROP DATABASE IF EXISTS Web_Library;
CREATE DATABASE Web_Library;
USE Web_Library;

-- create tables
CREATE TABLE Genre (
    Genre_ID INT PRIMARY KEY AUTO_INCREMENT,
    Genre_name VARCHAR(255) NOT NULL UNIQUE,
    FULLTEXT (Genre_name)
);

CREATE TABLE Resource_type (
    Resource_type_ID INT PRIMARY KEY AUTO_INCREMENT,
    Resource_type_name VARCHAR(255) NOT NULL UNIQUE,
    FULLTEXT (Resource_type_name)
);

CREATE TABLE Publisher (
    Publisher_ID INT PRIMARY KEY AUTO_INCREMENT,
    Publisher_name VARCHAR(255) NOT NULL,
    Publisher_address VARCHAR(255),
    Contact_details VARCHAR(255),
    FULLTEXT (Publisher_name, Publisher_address, Contact_details)
);

CREATE TABLE Author (
    Author_ID INT PRIMARY KEY AUTO_INCREMENT,
    Author_name VARCHAR(255) NOT NULL,
    Date_of_birth DATE,
    Nationality VARCHAR(255),
    FULLTEXT (Author_name)
);

CREATE TABLE Book (
    Book_ID INT PRIMARY KEY AUTO_INCREMENT,
    ISBN VARCHAR(255) NOT NULL UNIQUE,
    Book_title TEXT NOT NULL,
    Book_description TEXT NOT NULL,
    Publisher_ID INT,
    Publication_date DATE NOT NULL,
    Resource_type_ID INT NOT NULL,
    FOREIGN KEY (Publisher_ID) REFERENCES Publisher (Publisher_ID) ON DELETE NO ACTION,
    FOREIGN KEY (Resource_type_ID) REFERENCES Resource_type (Resource_type_ID) ON DELETE RESTRICT,
    FULLTEXT (ISBN, Book_title)
);

CREATE TABLE Books_Author (
    Books_Author_ID INT PRIMARY KEY AUTO_INCREMENT,
    Book_ID INT NOT NULL,
    Author_ID INT NOT NULL,
    FOREIGN KEY (Book_ID) REFERENCES Book (Book_ID) ON DELETE CASCADE,
    FOREIGN KEY (Author_ID) REFERENCES Author (Author_ID) ON DELETE CASCADE,
    UNIQUE (Book_ID, Author_ID)
);

CREATE TABLE Books_Genre (
    Books_Genre_ID INT PRIMARY KEY AUTO_INCREMENT,
    Book_ID INT NOT NULL,
    Genre_ID INT NOT NULL,
    FOREIGN KEY (Book_ID) REFERENCES Book (Book_ID) ON DELETE CASCADE,
    FOREIGN KEY (Genre_ID) REFERENCES Genre (Genre_ID) ON DELETE CASCADE,
    UNIQUE (Book_ID, Genre_ID)
);

CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY AUTO_INCREMENT,
    Staff_fullname VARCHAR(255) NOT NULL,
    Staff_email VARCHAR(255),
    Staff_mobile VARCHAR(255),
    Staff_username VARCHAR(255) NOT NULL UNIQUE,
    Staff_password VARCHAR(255) NOT NULL
);

CREATE TABLE Reader (
    Reader_ID INT PRIMARY KEY AUTO_INCREMENT,
    Reader_fullname VARCHAR(255) NOT NULL,
    Reader_email VARCHAR(255),
    Reader_username VARCHAR(255) NOT NULL UNIQUE,
    Reader_password VARCHAR(255) NOT NULL
);

CREATE TABLE Bookmark (
    Bookmark_ID INT PRIMARY KEY AUTO_INCREMENT,
    Book_ID INT NOT NULL,
    Reader_ID INT NOT NULL,
    Created_date DATE NOT NULL,
    FOREIGN KEY (Book_ID) REFERENCES Book (Book_ID) ON DELETE CASCADE,
    FOREIGN KEY (Reader_ID) REFERENCES Reader (Reader_ID) ON DELETE CASCADE,
    UNIQUE (Book_ID, Reader_ID)
);

-- Load the data
-- LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Resource_type.csv' 
-- INTO TABLE Resource_type
-- FIELDS TERMINATED BY ";"
-- IGNORE 1 LINES
-- (Resource_type_name);

-- LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Genre.csv' 
-- INTO TABLE Genre
-- FIELDS TERMINATED BY ";"
-- IGNORE 1 LINES
-- (Genre_name);

-- add staffs
INSERT INTO Staff	( Staff_fullname, Staff_email, Staff_username, Staff_password)
VALUES				 ( 'Van Pham','van.phamthithanh@rmit.edu.vn', 'abc', '123');

-- add genre
INSERT INTO Genre(Genre_name) VALUES ('Fiction');
INSERT INTO Genre(Genre_name) VALUES ('Business');
INSERT INTO Genre(Genre_name) VALUES ('Biography');
INSERT INTO Genre(Genre_name) VALUES ('Comics');
INSERT INTO Genre(Genre_name) VALUES ('History');
INSERT INTO Genre(Genre_name) VALUES ('Body');
INSERT INTO Genre(Genre_name) VALUES ('Medical');
INSERT INTO Genre(Genre_name) VALUES ('Juvenile Fiction');
INSERT INTO Genre(Genre_name) VALUES ('Art');
INSERT INTO Genre(Genre_name) VALUES ('Cooking');
INSERT INTO Genre(Genre_name) VALUES ('Family');
INSERT INTO Genre(Genre_name) VALUES ('Drama');
INSERT INTO Genre(Genre_name) VALUES ('Fantasy');
INSERT INTO Genre(Genre_name) VALUES ('Economics');
INSERT INTO Genre(Genre_name) VALUES ('Classics');
INSERT INTO Genre(Genre_name) VALUES ('Action');
INSERT INTO Genre(Genre_name) VALUES ('Mystery');
INSERT INTO Genre(Genre_name) VALUES ('General');
INSERT INTO Genre(Genre_name) VALUES ('Dystopian');
INSERT INTO Genre(Genre_name) VALUES ('Crime');
INSERT INTO Genre(Genre_name) VALUES ('FairyTales');
INSERT INTO Genre(Genre_name) VALUES ('ScienceFiction');
INSERT INTO Genre(Genre_name) VALUES ('LGBT');
INSERT INTO Genre(Genre_name) VALUES ('Autobiography');
INSERT INTO Genre(Genre_name) VALUES ('Thrillers');
INSERT INTO Genre(Genre_name) VALUES ('Horror');
INSERT INTO Genre(Genre_name) VALUES ('AlternativeHistory');
INSERT INTO Genre(Genre_name) VALUES ('GraphicNovels');
INSERT INTO Genre(Genre_name) VALUES ('Modern');
INSERT INTO Genre(Genre_name) VALUES ('Mind');
INSERT INTO Genre(Genre_name) VALUES ('InternalMedicine');
INSERT INTO Genre(Genre_name) VALUES ('ComingofAge');
INSERT INTO Genre(Genre_name) VALUES ('PopularCulture');
INSERT INTO Genre(Genre_name) VALUES ('Courses');
INSERT INTO Genre(Genre_name) VALUES ('Relationships');
INSERT INTO Genre(Genre_name) VALUES ('HumorousStories');
INSERT INTO Genre(Genre_name) VALUES ('Mystery&Detective');
INSERT INTO Genre(Genre_name) VALUES ('Comic');
INSERT INTO Genre(Genre_name) VALUES ('Shakespeare');
INSERT INTO Genre(Genre_name) VALUES ('Adventure');
INSERT INTO Genre(Genre_name) VALUES ('Detective');
INSERT INTO Genre(Genre_name) VALUES ('Entrepreneurship');
INSERT INTO Genre(Genre_name) VALUES ('ConsumerBehavior');
INSERT INTO Genre(Genre_name) VALUES ('Corporate');
INSERT INTO Genre(Genre_name) VALUES ('Industries');
INSERT INTO Genre(Genre_name) VALUES ('PublicFinance');
INSERT INTO Genre(Genre_name) VALUES ('Management');
INSERT INTO Genre(Genre_name) VALUES ('FolkTales');
INSERT INTO Genre(Genre_name) VALUES ('Gay');
INSERT INTO Genre(Genre_name) VALUES ('Businesses');
INSERT INTO Genre(Genre_name) VALUES ('E-Commerce');
INSERT INTO Genre(Genre_name) VALUES ('PersonalSuccess');
INSERT INTO Genre(Genre_name) VALUES ('Contemporary');
INSERT INTO Genre(Genre_name) VALUES ('Environmentalists');
INSERT INTO Genre(Genre_name) VALUES ('Epic');
INSERT INTO Genre(Genre_name) VALUES ('OrganizationalBehavior');
INSERT INTO Genre(Genre_name) VALUES ('TimeManagement');
INSERT INTO Genre(Genre_name) VALUES ('Motivational');
INSERT INTO Genre(Genre_name) VALUES ('Decision-Making');
INSERT INTO Genre(Genre_name) VALUES ('Accounting');
INSERT INTO Genre(Genre_name) VALUES ('OrganizationalDevelopment');
INSERT INTO Genre(Genre_name) VALUES ('Superheroes');
INSERT INTO Genre(Genre_name) VALUES ('20thCentury');
INSERT INTO Genre(Genre_name) VALUES ('BusinessCommunication');
INSERT INTO Genre(Genre_name) VALUES ('CustomerRelations');
INSERT INTO Genre(Genre_name) VALUES ('Spirit');
INSERT INTO Genre(Genre_name) VALUES ('Paranormal');
INSERT INTO Genre(Genre_name) VALUES ('Investments');
INSERT INTO Genre(Genre_name) VALUES ('PersonalMemoirs');
INSERT INTO Genre(Genre_name) VALUES ('Sales');
INSERT INTO Genre(Genre_name) VALUES ('Leadership');
INSERT INTO Genre(Genre_name) VALUES ('Humorous');
INSERT INTO Genre(Genre_name) VALUES ('Suspense');
INSERT INTO Genre(Genre_name) VALUES ('DarkFantasy');
INSERT INTO Genre(Genre_name) VALUES ('Entertainment');
INSERT INTO Genre(Genre_name) VALUES ('Dishes');
INSERT INTO Genre(Genre_name) VALUES ('PersonalFinance');
INSERT INTO Genre(Genre_name) VALUES ('Friendship');
INSERT INTO Genre(Genre_name) VALUES ('Medical(incl.Patients)');
INSERT INTO Genre(Genre_name) VALUES ('Sports');
INSERT INTO Genre(Genre_name) VALUES ('Advertising');
INSERT INTO Genre(Genre_name) VALUES ('Manga');
INSERT INTO Genre(Genre_name) VALUES ('Nonfiction');
INSERT INTO Genre(Genre_name) VALUES ('BusinessMathematics');
INSERT INTO Genre(Genre_name) VALUES ('Historical');
INSERT INTO Genre(Genre_name) VALUES ('AmateurSleuth');
INSERT INTO Genre(Genre_name) VALUES ('BusinessHistory');
INSERT INTO Genre(Genre_name) VALUES ('PoliceProcedural');
INSERT INTO Genre(Genre_name) VALUES ('Computers');
INSERT INTO Genre(Genre_name) VALUES ('Traditional');
INSERT INTO Genre(Genre_name) VALUES ('Hard-Boiled');
INSERT INTO Genre(Genre_name) VALUES ('Legends');
INSERT INTO Genre(Genre_name) VALUES ('Collections');
INSERT INTO Genre(Genre_name) VALUES ('Naturalists');
INSERT INTO Genre(Genre_name) VALUES ('ProblemSolving');
INSERT INTO Genre(Genre_name) VALUES ('Financial');
INSERT INTO Genre(Genre_name) VALUES ('Inspiration');
INSERT INTO Genre(Genre_name) VALUES ('Securities');
INSERT INTO Genre(Genre_name) VALUES ('PrivateInvestigators');
INSERT INTO Genre(Genre_name) VALUES ('NewThought');
INSERT INTO Genre(Genre_name) VALUES ('Theory');
INSERT INTO Genre(Genre_name) VALUES ('Selling');
INSERT INTO Genre(Genre_name) VALUES ('InternationalMystery');
INSERT INTO Genre(Genre_name) VALUES ('OnlineTrading');
INSERT INTO Genre(Genre_name) VALUES ('PerformingArts');
INSERT INTO Genre(Genre_name) VALUES ('Cookies');
INSERT INTO Genre(Genre_name) VALUES ('Meetings');
INSERT INTO Genre(Genre_name) VALUES ('Promotion');
INSERT INTO Genre(Genre_name) VALUES ('InformationTechnology');
INSERT INTO Genre(Genre_name) VALUES ('Mythology');
INSERT INTO Genre(Genre_name) VALUES ('Anthologies');
INSERT INTO Genre(Genre_name) VALUES ('PersonalGrowth');
INSERT INTO Genre(Genre_name) VALUES ('Stocks');
INSERT INTO Genre(Genre_name) VALUES ('Presentations');


-- add authors
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Peter V. Brett','1970-01-01','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Dan Ariely','1971-02-02','Israeli');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('J. R. R. Tolkien','1972-03-03','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('George R.R. Martin','1973-04-04','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Robin Hobb','1974-05-05','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Agatha Christie','1975-06-06','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Mark Lawrence','1976-07-07','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Peter Newman','1977-08-08','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Alex Lake','1978-09-09','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('B A Paris','1979-10-10','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Steven D. Levitt','1980-11-11','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('T. Harv Eker','1981-12-12','Canadian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Robert B. Cialdini,  PhD','1982-01-13','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jim Collins','1983-02-14','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Brian McGilloway','1984-03-15','Irish');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Rolf Dobelli','1985-04-16','Swiss');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jason Schreier','1986-05-17','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('William J. O''Neil','1987-06-18','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('David Ulrich','1988-07-19','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Matthew Walker','1989-08-20','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jason Fried','1990-09-21','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Elizabeth Adler','1991-10-22','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Michael A. Stackpole','1992-11-23','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Ernest Cline','1993-12-24','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Douglas Adams','1994-01-25','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('David Baldacci','1995-02-26','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jeffrey Archer','1996-03-27','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Dorothy Gilman','1997-04-28','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Lorenzo Carcaterra','1998-05-29','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Ari Marmell','1999-06-30','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Pierce Brown','2000-07-31','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Timothy Zahn','2001-08-01','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('James S. A. Corey','2002-09-02','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Brent Weeks','2003-10-03','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('André Aciman','2004-11-04','Egyptian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Brent Schlender','2005-12-05','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('David Lagercrantz','2006-01-06','Swedish');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('John Grisham','2007-02-07','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Geoffrey G. Parker','2008-03-08','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Vanessa Van Edwards','2009-04-09','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Faith Hunter','2010-05-10','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Lee Child','2011-06-11','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Madeleine Roux','2012-07-12','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Sir Arthur Conan Doyle','2013-08-13','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Greta Thunberg','2014-09-14','Swedish');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Clive Cussler','2015-10-15','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Philip K. Dick','2016-11-16','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('George R. R. Martin','2017-12-17','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Doug Johnstone','2018-01-18','Scottish');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Patrick Rothfuss','2019-02-19','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Charles Duhigg','2020-03-20','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Garrard Conley','2021-04-21','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('David Allen','2022-05-22','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('David J. Schwartz','2023-06-23','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Simon Sinek','2024-07-24','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Tony Robbins','2025-08-25','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Zoe Ferraris','2026-09-26','Saudi Arabian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Bob Cinnamon','2027-10-27','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Laura Levine','2028-11-28','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Barbara Allan','2029-12-29','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Katherine Crowley','2030-01-30','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Robert Maurer','2031-02-20','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Brian Staveley','2032-03-01','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Mark Millar','2033-04-02','Scottish');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jonathan Maberry','2034-05-03','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Brian Michael Bendis','2035-06-04','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Dan Slott','2036-07-05','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Paul S. Kemp','2037-08-06','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Timothy Snyder','2038-09-07','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Edward Fields','2039-10-08','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Renee Evenson','2040-11-09','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Brian Tracy','2041-12-10','Canadian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Stephen Guise','2042-01-11','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Blake Pierce','2043-02-12','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Robert Anthony','2044-03-13','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jim Butcher','2045-04-14','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Rhys Bowen','2046-05-15','Welsh');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jason Kelly','2047-06-16','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Sue Grafton','2048-07-17','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Chimamanda Ngozi Adichie','2049-08-18','Nigerian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Blake Crouch','2050-09-19','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Brandon Sanderson','2051-10-20','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Edward Snowden','2052-11-21','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Linda Castillo','2053-12-22','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Judith E. Tintinalli','2054-01-23','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jonathan Hickman','2055-02-24','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jim Starlin','2056-03-25','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Cullen Bunn','2057-04-26','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('J. M. DeMatteis','2058-05-27','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Natahan Edmondson','2059-06-28','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Kelly Sue Deconnick','2060-07-29','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Tom Taylor','2061-08-30','Australian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jason Aaron','2062-09-30','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Al Ewing','2063-10-31','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Grant Morrison','2064-11-01','Scottish');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Frank Miller','2065-12-02','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Geoff Johns','2066-01-03','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Brian Azzarello','2067-02-04','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Ed Brubaker','2068-03-05','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Derek Fridolfs','2069-04-06','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Art Baltazar','1980-05-07','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Scott Snyder','1981-06-08','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Peter J. Tomasi','1982-07-09','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('David R. Hawkins,  M.D./Ph.D.','1983-08-10','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Gregory David Roberts','1984-09-11','Australian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('M. J. Arlidge','1985-10-12','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Dale Carnegie','1986-11-13','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Michael Connelly','1987-12-14','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Rhonda Byrne','1989-01-15','Australian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Michael E. Porter','1990-02-16','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Zig Ziglar','1991-03-17','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('John C. Maxwell','1992-04-18','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Shirley Wells','1993-05-19','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Robert Jordan','1994-06-20','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Michael Sincere','1995-07-21','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Terry Hayes','1996-08-22','Australian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jack Canfield','1997-09-23','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('The Awkward Yeti','1998-10-24','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Mary Higgins Clark','1999-11-25','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Rachel Renee Russell','2000-12-26','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Holly Black','2002-01-27','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Martina Cole','2003-02-28','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Andrzej Sapkowski','2004-03-29','Polish');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Derren Brown','2005-04-30','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Alvin Hall','2006-05-31','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jen Sincero','2007-06-01','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Gerald Seymour','2008-07-02','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Julie Andrews','2009-08-03','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Edgar Allan Poe','2010-09-04','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Leo Tolstoy','2011-10-05','Russian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Arthur Conan Doyle','2012-11-06','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Voltaire','2013-12-07','French');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Ray Dalio','2015-01-08','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Stephen King','2016-02-09','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Nintendo','2017-03-10','Japanese');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Matthew Mercer','2018-04-11','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Georges Simenon','2019-05-12','Belgian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Editors of Martha Stewart Living','2020-06-13','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('James Fries','2021-07-14','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Nir Eyal','2022-08-15','Israeli');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Adam Kay','2023-09-16','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Billy Connolly','2024-10-17','Scottish');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('James Milner','2025-11-18','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Shannon Messenger','2026-12-19','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Michael Hyatt','2027-01-20','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Thomas Ittelson','2028-02-21','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Robert Kirkman','2029-03-22','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Hajime Isayama','2030-04-23','Japanese');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Joanne Fluke','2031-05-24','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Sara Rosett','2032-06-25','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Ian Flynn','1980-07-27','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Sun Tzu','1981-08-28','Chinese');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Napoleon Hill','1982-09-29','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Morgan Rice','1983-10-30','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Story by FUSE','1984-11-30','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jeff Kinney','1985-12-31','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Yevgeny Zamyatin','1987-01-01','Russian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Alan Moore','1988-02-02','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Dylan Young','1989-03-03','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('J.M. Barlog','1990-04-04','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Michaella McCollum','1991-05-05','Irish');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Sue Watson','1992-06-06','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Nicola Marsh','1993-07-07','Australian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Stuart Sim','1994-08-08','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Robert Greene','1995-09-09','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Cora Seton','1996-10-10','Canadian');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Denise Grover Swank','1997-11-11','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Jana DeLeon','1998-12-12','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Michael G. Manning','2000-01-13','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Mathias Weske','2001-02-14','German');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('H. P. Lovecraft','2002-03-15','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Sallie Stone','2003-04-16','American');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('William Shakespeare','2004-05-17','British');
INSERT INTO Author(Author_name,Date_of_birth,Nationality) VALUES ('Sigmund Freud','2005-06-18','Austrian');

-- add publishers
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('HarperCollins UK','123 Fake Street, London, UK','+44 20 1234 5678');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Harper Collins','456 Fiction Avenue, New York, USA','+1 212 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('HarperCollins','789 Imaginary Lane, Sydney, Australia','+61 2 1234 5678');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('McGraw Hill Professional','321 Phony Boulevard, Toronto, Canada','+1 416 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Penguin UK','654 Sham Road, Manchester, UK','+44 161 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Currency','987 Pretend Place, Dublin, Ireland','+353 1 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Island Books','654 Counterfeit Court, Auckland, New Zealand','+64 9 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Del Rey','321 Bogus Boulevard, Los Angeles, USA','+1 213 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Broadway Books','258 Dummy Drive, Chicago, USA','+1 312 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Pan Macmillan','741 Fabricated Freeway, Johannesburg, South Africa','+27 11 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Ballantine Books','963 Make-believe Mall, Boston, USA','+1 617 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Hachette UK','852 Faux Field, Edinburgh, UK','+44 131 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Farrar, Straus and Giroux','369 Imitation Isle, San Francisco, USA','+1 415 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Crown Business','147 Deceptive Dell, Dallas, USA','+1 214 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Vintage Crime/Black Lizard','258 Hoax Highway, Houston, USA','+1 713 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Doubleday','741 Sham Street, Seattle, USA','+1 206 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('W. W. Norton & Company','963 Phony Place, Philadelphia, USA','+1 215 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Penguin','321 Fake Freeway, Phoenix, USA','+1 602 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Dell','147 Bogus Boulevard, Baltimore, USA','+1 410 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Courier Corporation','369 Imitation Isle, Indianapolis, USA','+1 317 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Houghton Mifflin Harcourt','852 Faux Field, Jacksonville, USA','+1 904 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Bantam','147 Deceptive Dell, San Francisco, USA','+1 415 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Faber & Faber','963 Make-believe Mall, Columbus, USA','+1 614 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Random House','258 Dummy Drive, Charlotte, USA','+1 704 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Simon and Schuster','741 Fabricated Freeway, Detroit, USA','+1 313 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Kogan Page Publishers','963 Pretend Place, Memphis, USA','+1 901 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Kensington Books','321 Bogus Boulevard, Boston, USA','+1 617 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Kensington Publishing Corp.','654 Sham Road, Seattle, USA','+1 206 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Workman Publishing','987 Counterfeit Court, Denver, USA','+1 303 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Macmillan','321 Phony Boulevard, Baltimore, USA','+1 410 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Marvel Entertainment','654 Fake Field, Nashville, USA','+1 615 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Wizards of the Coast','987 Imitation Isle, Milwaukee, USA','+1 414 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Tim Duggan Books','321 Make-believe Mall, Las Vegas, USA','+1 702 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('AMACOM','654 Counterfeit Court, Albuquerque, USA','+1 505 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Selective Entertainment LLC','258 Hoax Highway, Louisville, USA','+1 502 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Blake Pierce','741 Sham Street, Portland, USA','+1 503 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Penguin Group','963 Phony Place, Oklahoma City, USA','+1 405 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Vintage','321 Fake Freeway, Tucson, USA','+1 520 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Tor Books','147 Bogus Boulevard, Fresno, USA','+1 559 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Metropolitan Books','369 Imitation Isle, Sacramento, USA','+1 916 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Minotaur Books','852 Faux Field, Long Beach, USA','+1 562 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('DC','147 Deceptive Dell, Kansas City, USA','+1 816 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('DC Comics','963 Make-believe Mall, Mesa, USA','+1 480 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Hay House, Inc','258 Dummy Drive, Virginia Beach, USA','+1 757 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('HarperCollins Leadership','741 Fabricated Freeway, Atlanta, USA','+1 404 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Harlequin','963 Pretend Place, Colorado Springs, USA','+1 719 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Tor Fantasy','321 Bogus Boulevard, Raleigh, USA','+1 919 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Andrews McMeel Publishing','654 Sham Road, Omaha, USA','+1 402 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Bonnier Zaffre Ltd.','987 Counterfeit Court, Miami, USA','+1 305 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Open Road Media','321 Phony Boulevard, Oakland, USA','+1 510 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Dark Horse Comics','654 Fake Field, Minneapolis, USA','+1 612 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Clarkson Potter','987 Imitation Isle, Tulsa, USA','+1 918 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('EDITORA BIBLIOMUNDI SERVI√áOS DIGITAIS LTDA','321 Make-believe Mall, Wichita, USA','+1 316 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Bloomsbury Publishing','654 Counterfeit Court, New Orleans, USA','+1 504 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Red Wheel/Weiser','258 Hoax Highway, Arlington, USA','+1 817 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Berrett-Koehler Publishers','741 Sham Street, Tampa, USA','+1 813 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Image Comics, Inc.','963 Phony Place, Honolulu, USA','+1 808 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Kodansha Comics','321 Fake Freeway, Aurora, USA','+1 303 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Archie Comic Publications','147 Bogus Boulevard, Anaheim, USA','+1 714 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Morgan Rice','369 Imitation Isle, Santa Ana, USA','+1 714 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Kodansha America LLC','852 Faux Field, St. Louis, USA','+1 314 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Abrams','147 Deceptive Dell, Pittsburgh, USA','+1 412 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Pan','963 Make-believe Mall, Corpus Christi, USA','+1 361 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Bookouture','258 Dummy Drive, Lexington, USA','+1 859 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Titan Books','741 Fabricated Freeway, Stockton, USA','+1 209 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Kings Road Publishing','963 Pretend Place, Cincinnati, USA','+1 513 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Icon Books','321 Bogus Boulevard, Saint Paul, USA','+1 651 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Profile Books','654 Sham Road, Toledo, USA','+1 419 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('One Acre Press','987 Counterfeit Court, Newark, USA','+1 973 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('DGS','321 Phony Boulevard, Greensboro, USA','+1 336 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Jana DeLeon','654 Fake Field, Plano, USA','+1 972 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Michael Manning','987 Imitation Isle, Henderson, USA','+1 702 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('Springer Science & Business Media','321 Make-believe Mall, Lincoln, USA','+1 402 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('BookRix','654 Counterfeit Court, Buffalo, USA','+1 716 123 4567');
INSERT INTO Publisher(Publisher_name,Publisher_address,Contact_details) VALUES ('e-artnow','963 Make-believe Mall, Corpus Christi, USA','+1 361 123 4567');


-- add reader
INSERT INTO Reader ( Reader_fullname, Reader_email, Reader_username, Reader_password  )
VALUES 				( 'Nguyen Huynh Gia Khang', 'giakhang25069@gmail.com', 'giakhang2601', '$2b$10$LgCFJ92WJ1VXoYw9QX/JgeBphi2o.8mVGB4eo.wC5OzvfMniEmE7m');

INSERT INTO Staff ( Staff_fullname, Staff_email, Staff_username, Staff_password  )
VALUES 				( 'Hoang Nam', 'nam271000@gmail.com', 'nam271000', '$2b$10$LgCFJ92WJ1VXoYw9QX/JgeBphi2o.8mVGB4eo.wC5OzvfMniEmE7m');

-- add resource types
INSERT INTO Resource_type (Resource_type_name) VALUES ('Books');
INSERT INTO Resource_type (Resource_type_name) VALUES ('Articles');
INSERT INTO Resource_type (Resource_type_name) VALUES ('Journels');
INSERT INTO Resource_type (Resource_type_name) VALUES ('Book Reviews');
INSERT INTO Resource_type (Resource_type_name) VALUES ('Newspaper Articles');
INSERT INTO Resource_type (Resource_type_name) VALUES ('Web Resources');
INSERT INTO Resource_type (Resource_type_name) VALUES ('Patents');
 
-- add books
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Painted Man (The Demon Cycle, Book 1)','The stunning debut fantasy novel from author Peter V. Brett.   The Painted Man, book one of the Demon Cycle, is a captivating and thrilling fantasy adventure, pulling the reader into a world of demons, darkness and heroes.  AS DARKNESS FALLS, THE DEMONS RISE For hundreds of years these creatures have terrorized the night, slowly culling the human population. It was not always this way. Men and women did not always cower behind protective magical wards and hope to see the dawn. Once, they battled the demons on equal terms, but those days, and skills, are gone. Arlen Bales lives with his parents on their isolated farmstead until a demon attack shatters their world. He learns a savage lesson that day: that people, as well as magic, can let you down. Rejecting the fear that kills as efficiently as the creatures, Arlen risks another path in order to offer humanity a last, fleeting chance of survival.',1,1,9780007287758,'2009-01-08');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Predictably Irrational: The Hidden Forces that Shape Our Decisions','Why do smart people make irrational decisions every day? The answers will surprise you. Predictably Irrational is an intriguing, witty and utterly original look at why we all make illogical decisions. Why can a 50p aspirin do what a 5p aspirin can''t? If an item is "free" it must be a bargain, right? Why is everything relative, even when it shouldn''t be? How do our expectations influence our actual opinions and decisions? In this astounding book, behavioural economist Dan Ariely cuts to the heart of our strange behaviour, demonstrating how irrationality often supplants rational thought and that the reason for this is embedded in the very structure of our minds. Predicatably Irrational brilliantly blends everyday experiences with a series of illuminating and often surprising experiments, that will change your understanding of human behaviour. And, by recognising these patterns, Ariely shows that we can make better decisions in business, in matters of collective welfare, and in our everyday lives from drinking coffee to losing weight, buying a car to choosing a romantic partner.',1,1,9780007319923,'2009-03-06');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Lord of the Rings: The Fellowship of the Ring, The Two Towers, The Return of the King','All three parts of the epic masterpiece The Lord of the Rings – The Fellowship of the Ring, The Two Towers & The Return of the King – available as one download, featuring the definitive edition of the text, hyperlinked footnotes and page references, and 3 maps including a detailed map of Middle-earth. Sauron, the Dark Lord, has gathered to him all the Rings of Power – the means by which he intends to rule Middle-earth. All he lacks in his plans for dominion is the One Ring – the ring that rules them all – which has fallen into the hands of the hobbit, Bilbo Baggins. In a sleepy village in the Shire, young Frodo Baggins finds himself faced with an immense task, as the Ring is entrusted to his care. He must leave his home and make a perilous journey across the realms of Middle-earth to the Crack of Doom, deep inside the territories of the Dark Lord. There he must destroy the Ring forever and foil the Dark Lord in his evil purpose. Since it was first published in 1954, ‘The Lord of the Rings’ has been a book people have treasured. Steeped in unrivalled magic and otherworldliness, its sweeping fantasy has touched the hearts of young and old alike.',1,1,9780007322596,'2009-04-20');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('A Feast for Crows (A Song of Ice and Fire, Book 4)','HBO’s hit series A GAME OF THRONES is based on George R. R. Martin’s internationally bestselling series A SONG OF ICE AND FIRE, the greatest fantasy epic of the modern age. A FEAST FOR CROWS is the fourth volume in the series. The Lannisters are in power on the Iron Throne. The war in the Seven Kingdoms has burned itself out, but in its bitter aftermath new conflicts spark to life. The Martells of Dorne and the Starks of Winterfell seek vengeance for their dead. Euron Crow’s Eye, as black a pirate as ever raised a sail, returns from the smoking ruins of Valyria to claim the Iron Isles. From the icy north, where Others threaten the Wall, apprentice Maester Samwell Tarly brings a mysterious babe in arms to the Citadel. As plots, intrigue and battle threaten to engulf Westeros, victory will go to the men and women possessed of the coldest steel and the coldest hearts.',1,1,9780007369218,'2011-02-24');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Assassin’s Apprentice (The Farseer Trilogy, Book 1)','‘Fantasy as it ought to be written’ George R.R. Martin  The kingdom of the Six Duchies is on the brink of civil war when news breaks that the crown prince has fathered a bastard son and is shamed into abdication. The child’s name is Fitz, and he is despised. Raised in the castle stables, only the company of the king’s fool, the ragged children of the lower city, and his unusual affinity with animals provide Fitz with any comfort. To be useful to the crown, Fitz is trained as an assassin; and to use the traditional magic of the Farseer family. But his tutor, allied to another political faction, is determined to discredit, even kill him. Fitz must survive: for he may be destined to save the kingdom.',1,1,9780007374038,'2011-09-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('And Then There Were None','Agatha Christie’s world-famous mystery thriller, reissued with a striking cover designed to appeal to the latest generation of Agatha Christie fans and book lovers. Ten strangers, apparently with little in common, are lured to an island mansion off the coast of Devon by the mysterious U.N.Owen. Over dinner, a record begins to play, and the voice of an unseen host accuses each person of hiding a guilty secret. That evening, former reckless driver Tony Marston is found murdered by a deadly dose of cyanide. The tension escalates as the survivors realise the killer is not only among them but is preparing to strike again... and again...',1,1,9780007422135,'2010-10-14');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Mysterious Affair at Styles (Poirot)','Agatha Christie’s first ever murder mystery. With impeccable timing Hercule Poirot, the renowned Belgian detective, makes his dramatic entrance on to the English crime stage. Recently, there had been some strange goings on at Styles St Mary. Evelyn, constant companion to old Mrs Inglethorp, had stormed out of the house muttering something about ‘a lot of sharks’. And with her, something indefinable had gone from the atmosphere. Her presence had spelt security; now the air seemed rife with suspicion and impending evil. A shattered coffee cup, a splash of candle grease, a bed of begonias... all Poirot required to display his now legendary powers of detection.',1,1,9780007422586,'2010-10-14');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Prince of Thorns (The Broken Empire, Book 1)','From the publisher that brought you Game of Thrones... Prince of Thorns is the first volume in a powerful epic fantasy trilogy, original, absorbing and challenging. Before the thorns taught me their sharp lessons and bled weakness from me I had but one brother, and I loved him well. But those days are gone and what is left of them lies in my mother''s tomb. Now I have many brothers, quick with knife and sword, and as evil as you please. We ride this broken empire and loot its corpse. They say these are violent times, the end of days when the dead roam and monsters haunt the night. All that''s true enough, but there''s something worse out there, in the dark. Much worse. From being a privileged royal child, raised by a loving mother, Jorg Ancrath has become the Prince of Thorns, a charming, immoral boy leading a grim band of outlaws in a series of raids and atrocities. The world is in chaos: violence is rife, nightmares everywhere. Jorg has the ability to master the living and the dead, but there is still one thing that puts a chill in him. Returning to his father''s castle Jorg must confront horrors from his childhood and carve himself a future with all hands turned against him. Mark Lawrence''s debut novel tells a tale of blood and treachery, magic and brotherhood and paints a compelling and brutal, and sometimes beautiful, picture of an exceptional boy on his journey toward manhood and the throne.',1,1,9780007423309,'2011-08-04');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Red Signal: An Agatha Christie Short Story','A classic Agatha Christie short story, available individually for the first time as an ebook. Sir Alington, a venerable expert of the mental condition is being pestered by the pretty, but fairly dotty Mrs. Eversleigh about the importance of the sixth sense. Soon the young man Dermot is drawn in and tells both of having something like a sixth sense, what he calls the red signal that spells danger. He is about to tell them about the last time he had the feeling, the red signal, when he stops himself, the last time he had the signal was not then, it was earlier that very evening. But how could there be danger at a simple gathering of old friends? Will the evening’s entertainment of a medium bring forth whatever impending danger that Dermot senses?',1,1,9780007452170,'2011-09-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Mysterious Affair at Styles','Agatha Christie’s first ever murder mystery. Includes an introduction by Christie archivist John Curran, and the original unpublished courtroom chapter as an alternate ending to the novel. ‘Beware! Peril to the detective who says: “It is so small – it does not matter...” Everything matters.’ After the Great War, life can never be the same again. Wounds need healing, and the horror of violent death banished into memory. Captain Arthur Hastings is invited to the rolling country estate of Styles to recuperate from injuries sustained at the Front. It is the last place he expects to encounter murder. Fortunately he knows a former detective, a Belgian refugee, who has grown bored of retirement ... The first Hercule Poirot mystery, now published with a previously deleted chapter and introduced by Agatha Christie expert Dr John Curran.',1,1,9780007463497,'2013-01-17');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('A Game of Thrones: The Story Continues Books 1-5: A Game of Thrones, A Clash of Kings, A Storm of Swords, A Feast for Crows, A Dance with Dragons (A Song of Ice and Fire)','HBO’s hit series A GAME OF THRONES is based on George R R Martin’s internationally bestselling series A SONG OF ICE AND FIRE, the greatest fantasy epic of the modern age. George R. R. Martin''s A Song of Ice and Fire series has set the benchmark for contemporary epic fantasy. Labelled by Time magazine as one of the top 100 most influential people in the world, Martin has conjured a world as complex and vibrant as that of J.R.R. Tolkien’s, populated by a huge cast of fascinating, complex characters, and boasting a history that stretches back twelve thousand years. Three great storylines weave through the books, charting the civil war for control of the Seven Kingdoms; the defence of the towering Wall of ice in the uttermost north against the unearthly threat of the Others; and across the Narrow Sea the rise to power of Daenerys Targaryen and the last live dragons in the world. This collection includes: A GAME OF THRONES
A CLASH OF KINGS
A STORM OF SWORDS, 1: STEEL AND SNOW
A STORM OF SWORDS, 2: BLOOD AND GOLD
A FEAST FOR CROWS
A DANCE WITH DRAGONS, 1: DREAMS AND DUST
A DANCE WITH DRAGONS, 2: AFTER THE FEAST
Preview chapter of THE WINDS OF WINTER',1,1,9780007482931,'2012-03-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Vagrant (The Vagrant Trilogy)','The Vagrant is his name. He has no other. Years have passed since humanity’s destruction emerged from the Breach. Friendless and alone he walks across a desolate, war-torn landscape. As each day passes the world tumbles further into depravity, bent and twisted by the new order, corrupted by the Usurper, the enemy, and his infernal horde. His purpose is to reach the Shining City, last bastion of the human race, and deliver the only weapon that may make a difference in the ongoing war. What little hope remains is dying. Abandoned by its leader, The Seven, and its heroes, The Seraph Knights, the last defences of a once great civilisation are crumbling into dust. But the Shining City is far away and the world is a very dangerous place.',1,1,9780007593101,'2015-04-23');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('After Anna','No.1 EBOOK BESTSELLER. A SUNDAY TIMES TOP 10 PAPERBACK BESTSELLER. A USA TODAY PAPERBACK BESTSELLER.   The real nightmare starts when her daughter is returned...   A bone-chilling psychological thriller that will suit fans of Gone Girl, The Couple Next Door and The Girl on the Train.  A girl is missing. Five years old, taken from outside her school. She has vanished, traceless. The police are at a loss; her parents are beyond grief. Their daughter is lost forever, perhaps dead, perhaps enslaved. But the biggest mystery is yet to come: one week after she was abducted, their daughter is returned. She has no memory of where she has been. And this, for her mother, is just the beginning of the nightmare.',1,1,9780008150907,'2015-07-30');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Bring Me Back','The million-copy bestselling author returns with a breathtaking thriller – now with exclusive new chapters to see how the story could have ended. This Sunday Times Top 10 bestseller has been updated with bonus chapters from B A Paris showing how she originally planned that ending.  ‘We’re in a new Golden Age of suspense writing now, because of amazing books like Bring Me Back’ Lee Child  Finn and Layla: young and in love, their whole lives ahead of them. Driving back from a holiday in France one night, Finn pulls in to a service station, leaving Layla alone in the car. When he returns, minutes later, Layla has vanished, never to be seen again. That’s the story Finn tells the police. It’s the truth – but not the whole truth. Twelve years later, Finn has built a new life with Ellen, Layla’s sister, when he receives a phone call. Someone has seen Layla. But is it her – or someone pretending to be her? If it is her, what does she want? And what does she know about the night she disappeared? Bring Me Back is the utterly compelling, white-knuckle thriller from Sunday Times bestseller B A Paris. ‘An addictive new voice in suspense fiction’ Sophie Hannah ‘Just finished this BRILLIANT book...Clever, addictive and twisty, I couldn’t sleep until I found out the truth...The twist floored me! Utterly compelling from beginning to end’ Claire Douglas ‘Made me stay up way beyond my bedtime! BA Paris has a knack for getting into your head.’ Jane Corry ‘A page-turning masterpiece’ Amanda Prowse ‘A tale of dark secrets, with mystery and intrigue building up and up to an ending with a fabulous twist. I devoured it – I couldn’t turn the pages quick enough.’ Mel Sherratt ‘This book is compulsive reading from start to finish. A perfectly crafted work of art, seamless and mesmerising. I envy those yet to read it for the pleasure they have in store.’ Amanda Robson ‘A cracking page turner with a killer twist.'' Camilla Way ‘An incredibly pacy, heart-pounding thriller – the twist at the end left me reeling. B A Paris does it again in this exhilarating exploration of love, jealousy and betrayal. A must read for 2018!’ Phoebe Morgan',1,1,9780008244880,'2018-03-08');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Freakonomics Rev Ed: A Rogue Economist Explores the Hidden Side of Everything','One of the greatest young American thinkers offers his provocative and intriguing insights into basic life issues—from cheating to child rearing—in this highly readable and challenging new work Which is more dangerous, a gun or a swimming pool? Which should be feared more: snakes or french fries? Who really deserves credit for the recent drop in crime? In this groundbreaking book, leading economist Steven Levitt—Professor of Economics at the University of Chicago and winner of the American Economic Association’s 2004 John Bates Clark medal for the economist under 40 who has made the greatest contribution to the discipline—reveals that the answers to such questions lie in economic theory, a field he is revolutionizing. Joined by acclaimed author Stephen J. Dubner, Levitt offers his most compelling ideas as he explores the basic questions of everyday life, reaching conclusions that have turned conventional wisdom on its head. Brilliantly reasoned, told in compelling, forthright language, and filled with keen insight, What Do Schoolteachers and Sumo Wrestlers Have in Common? remind us that economics is ultimately the study of incentives and competition—how people get what they want, or need, when others want or need the same thing.',2,1,9780061792809,'2010-02-17');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Secrets of the Millionaire Mind: Mastering the Inner Game of Wealth','Secrets of the Millionaire Mind reveals the missing link between wanting success and achieving it!Have you ever wondered why some people seem to get rich easily, while others are destined for a life of financial struggle? Is the difference found in their education, intelligence, skills, timing, work habits, contacts, luck, or their choice of jobs, businesses, or investments?The shocking answer is: None of the above!In his groundbreaking Secrets of the Millionaire Mind, T. Harv Eker states: "Give me five minutes, and I can predict your financial future for the rest of your life!" Eker does this by identifying your "money and success blueprint." We all have a personal money blueprint ingrained in our subconscious minds, and it is this blueprint, more than anything, that will determine our financial lives. You can know everything about marketing, sales, negotiations, stocks, real estate, and the world of finance, but if your money blueprint is not set for a high level of success, you will never have a lot of money—and if somehow you do, you will most likely lose it! The good news is that now you can actually reset your money blueprint to create natural and automatic success.Secrets of the Millionaire Mind is two books in one. Part I explains how your money blueprint works. Through Eker''s rare combination of street smarts, humor, and heart, you will learn how your childhood influences have shaped your financial destiny. You will also learn how to identify your own money blueprint and "revise" it to not only create success but, more important, to keep and continually grow it.In Part II you will be introduced to seventeen "Wealth Files," which describe exactly how rich people think and act differently than most poor and middle-class people. Each Wealth File includes action steps for you to practice in the real world in order to dramatically increase your income and accumulate wealth.If you are not doing as well financially as you would like, you will have to change your money blueprint. Unfortunately your current money blueprint will tend to stay with you for the rest of your life, unless you identify and revise it, and that''s exactly what you will do with the help of this extraordinary book. According to T. Harv Eker, it''s simple. If you think like rich people think and do what rich people do, chances are you''ll get rich too!',2,1,9780061793660,'2009-10-13');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Influence: The Psychology of Persuasion','Influence, the classic book on persuasion, explains the psychology of why people say "yes"—and how to apply these understandings. Dr. Robert Cialdini is the seminal expert in the rapidly expanding field of influence and persuasion. His thirty-five years of rigorous, evidence-based research along with a three-year program of study on what moves people to change behavior has resulted in this highly acclaimed book. You''ll learn the six universal principles, how to use them to become a skilled persuader—and how to defend yourself against them. Perfect for people in all walks of life, the principles of Influence will move you toward profound personal change and act as a driving force for your success.Some images that appeared in the print edition of this book are unavailable in the electronic edition due to rights reasons.',2,1,9780061899874,'2009-06-02');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Good to Great: Why Some Companies Make the Leap...And Others Don''t','The Challenge 
Built to Last, the defining management study of the nineties, showed how great companies triumph over time and how long-term sustained performance can be engineered into the DNA of an enterprise from the verybeginning. But what about the company that is not born with great DNA? How can good companies, mediocre companies, even bad companies achieve enduring greatness? The Study 
For years, this question preyed on the mind of Jim Collins. Are there companies that defy gravity and convert long-term mediocrity or worse into long-term superiority? And if so, what are the universal distinguishing characteristics that cause a company to go from good to great? The Standards 
Using tough benchmarks, Collins and his research team identified a set of elite companies that made the leap to great results and sustained those results for at least fifteen years. How great? After the leap, the good-to-great companies generated cumulative stock returns that beat the general stock market by an average of seven times in fifteen years, better than twice the results delivered by a composite index of the world''s greatest companies, including Coca-Cola, Intel, General Electric, and Merck.The Comparisons 
The research team contrasted the good-to-great companies with a carefully selected set of comparison companies that failed to make the leap from good to great. What was different? Why did one set of companies become truly great performers while the other set remained only good? Over five years, the team analyzed the histories of all twenty-eight companies in the study. After sifting through mountains of data and thousands of pages of interviews, Collins and his crew discovered the key determinants of greatness -- why some companies make the leap and others don''t. The Findings
 The findings of the Good to Great study will surprise many readers and shed light on virtually every area of management strategy and practice. The findings include:Level 5 Leaders: The research team was shocked to discover the type of leadership required to achieve greatness. The Hedgehog Concept (Simplicity within the Three Circles): To go from good to great requires transcending the curse of competence. A Culture of Discipline: When you combine a culture of discipline with an ethic of entrepreneurship, you get the magical alchemy of great results. Technology Accelerators: Good-to-great companies think differently about the role of technology. The Flywheel and the Doom Loop: Those who launch radical change programs and wrenching restructurings will almost certainly fail to make the leap.“Some of the key concepts discerned in the study,” comments Jim Collins, "fly in the face of our modern business culture and will, quite frankly, upset some people.” Perhaps, but who can afford to ignore these findings?',2,1,9780062119209,'2011-07-19');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Think Like a Freak: The Authors of Freakonomics Offer to Retrain Your Brain','The New York Times bestselling Freakonomics changed the way we see the world, exposing the hidden side of just about everything. Then came SuperFreakonomics, a documentary film, an award-winning podcast, and more.Now, with Think Like a Freak, Steven D. Levitt and Stephen J. Dubner have written their most revolutionary book yet. With their trademark blend of captivating storytelling and unconventional analysis, they take us inside their thought process and teach us all to think a bit more productively, more creatively, more rationally—to think, that is, like a Freak.Levitt and Dubner offer a blueprint for an entirely new way to solve problems, whether your interest lies in minor lifehacks or major global reforms. As always, no topic is off-limits. They range from business to philanthropy to sports to politics, all with the goal of retraining your brain. Along the way, you’ll learn the secrets of a Japanese hot-dog-eating champion, the reason an Australian doctor swallowed a batch of dangerous bacteria, and why Nigerian e-mail scammers make a point of saying they’re from Nigeria.Some of the steps toward thinking like a Freak:  First, put away your moral compass—because it’s hard to see a problem clearly if you’ve already decided what to do about it.  Learn to say “I don’t know”—for until you can admit what you don’t yet know, it’s virtually impossible to learn what you need to.  Think like a child—because you’ll come up with better ideas and ask better questions.  Take a master class in incentives—because for better or worse, incentives rule our world.  Learn to persuade people who don’t want to be persuaded—because being right is rarely enough to carry the day.  Learn to appreciate the upside of quitting—because you can’t solve tomorrow’s problem if you aren’t willing to abandon today’s dud.Levitt and Dubner plainly see the world like no one else. Now you can too. Never before have such iconoclastic thinkers been so revealing—and so much fun to read.',2,1,9780062218360,'2014-05-12');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Little Girl Lost: A Lucy Black Thriller','This New York Times bestseller is perfect for fans of Tana French and Dennis Lehane.Midwinter. A child is found wandering through the snowy woods, her hands covered in someone else''s blood. And she cannot—or will not—speak, not even to share her name.Who is this little girl lost? The only adult she seems to trust is the young officer who found her, Detective Lucy Black. Before long, Lucy manages to connect her case to that of a missing teenager, the kidnapped daughter of a local real estate tycoon. As the investigation twists and turns, Lucy is forced to question not only a range of dangerous suspects, but also everything she thought she knew about her own past.',2,1,9780062336583,'2014-02-18');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Art of Thinking Clearly','Have you ever . . .  Invested time in something that, in hindsight, just wasn''t worth it?  Paid too much in an eBay auction?  Continued to do something you knew was bad for you?  Sold stocks too late, or too early?  Taken credit for success, but blamed failure on external circumstances?  Backed the wrong horse?These are examples of what the author calls cognitive biases, simple errors all of us make in day-to-day thinking. But by knowing what they are and how to identify them, we can avoid them and make better choices: whether in dealing with personal problems or business negotiations, trying to save money or earn profits, or merely working out what we really want in life—and strategizing the best way to get it.Already an international bestseller, The Art of Thinking Clearly distills cutting-edge research from behavioral economics, psychology, and neuroscience into a clever, practical guide for anyone who''s ever wanted to be wiser and make better decisions. A novelist, thinker, and entrepreneur, Rolf Dobelli deftly shows that in order to lead happier, more prosperous lives, we don''t need extra cunning, new ideas, shiny gadgets, or more frantic hyperactivity—all we need is less irrationality.Simple, clear, and always surprising, this indispensable book will change the way you think and transform your decision making—at work, at home, every day. From why you shouldn''t accept a free drink to why you should walk out of a movie you don''t like, from why it''s so hard to predict the future to why you shouldn''t watch the news, The Art of Thinking Clearly helps solve the puzzle of human reasoning.',2,1,9780062359803,'2014-05-06');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Blood, Sweat, and Pixels: The Triumphant, Turbulent Stories Behind How Video Games Are Made','NATIONAL BESTSELLERDeveloping video games—hero''s journey or fool''s errand? The creative and technical logistics that go into building today''s hottest games can be more harrowing and complex than the games themselves, often seeming like an endless maze or a bottomless abyss. In Blood, Sweat, and Pixels, Jason Schreier takes readers on a fascinating odyssey behind the scenes of video game development, where the creator may be a team of 600 overworked underdogs or a solitary geek genius. Exploring the artistic challenges, technical impossibilities, marketplace demands, and Donkey Kong-sized monkey wrenches thrown into the works by corporate, Blood, Sweat, and Pixels reveals how bringing any game to completion is more than Sisyphean—it''s nothing short of miraculous.Taking some of the most popular, bestselling recent games, Schreier immerses readers in the hellfire of the development process, whether it''s RPG studio Bioware''s challenge to beat an impossible schedule and overcome countless technical nightmares to build Dragon Age: Inquisition; indie developer Eric Barone''s single-handed efforts to grow country-life RPG Stardew Valley from one man''s vision into a multi-million-dollar franchise; or Bungie spinning out from their corporate overlords at Microsoft to create Destiny, a brand new universe that they hoped would become as iconic as Star Wars and Lord of the Rings—even as it nearly ripped their studio apart. Documenting the round-the-clock crunches, buggy-eyed burnout, and last-minute saves, Blood, Sweat, and Pixels is a journey through development hell—and ultimately a tribute to the dedicated diehards and unsung heroes who scale mountains of obstacles in their quests to create the best games imaginable.',3,1,9780062651242,'2017-09-05');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('How to Make Money in Stocks: A Winning System in Good Times and Bad, Fourth Edition: Edition 4','THE NATIONAL BESTSELLER! Anyone can learn to invest wisely with this bestselling investment system! Through every type of market, William J. O’Neil’s national bestseller, How to Make Money in Stocks, has shown over 2 million investors the secrets to building wealth. O’Neil’s powerful CAN SLIM® Investing System—a proven 7-step process for minimizing risk and maximizing gains—has influenced generations of investors. Based on a major study of market winners from 1880 to 2009, this expanded edition gives you:  Proven techniques for finding winning stocks before they make big price gains Tips on picking the best stocks, mutual funds, and ETFs to maximize your gains 100 new charts to help you spot today’s most profitable trends  PLUS strategies to help you avoid the 21 most common investor mistakes! “I dedicated the 2004 Stock Trader’s Almanac to Bill O’Neil: ‘His foresight, innovation, and disciplined approach to stock market investing will influence investors and traders for generations to come.’”
 —Yale Hirsch, publisher and editor, Stock Trader’s Almanac and author of Let’s Change the World Inc. “Investor’s Business Daily has provided a quarter-century of great financial journalism and investing strategies.”
 —David Callaway, editor-in-chief, MarketWatch “How to Make Money in Stocks is a classic. Any investor serious about making money in the market ought to read it.”
 —Larry Kudlow, host, CNBC’s "The Kudlow Report"',4,1,9780071614146,'2009-04-12');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('HR from the Outside In: Six Competencies for the Future of Human Resources','“This definitive work on HR competencies provides ideas and tools that help HR professionals develop their career and make their organization effective.”
 —Edward E. Lawler III, Professor, University of Southern California “This book is a crucial blueprint of what it takes to succeed. A must have for every HR professional.”
 —Lynda Gratton, Professor, London Business School “One single concept changed the HR world forever: ‘HR business partner’. Through consistent cycles of research and practical application, Dave and his team have produced and update the most comprehensive set of HR competencies ever.”
 —Horacio Quiros, President, World Federation of People Management Associations "Packed with facts, evidence, and prescriptive advice. It is about being a business leader first, and an HR professional second.”
 —Randy MacDonald, Senior Vice President, Human Resources, IBM Corporation "The concepts and competencies presented in this book provide HR leaders with new insights."
 —Gina Qiao, Senior Vice President, HR Lenovo “Powerful, relevant and timely! Defines "new HR" in a pragmatic way. This book is a must for leaders and HR folks who seek to create sustainable competitive advantage.”
 —Satish Pradhan, Chief, Group Human Resources, Tata Sons Limited “You can’t argue with the data! This book is a definitive and practical guide to learning the HR competencies for success.”
 —John Lynch, Senior Vice President, HR, General Electric “A must read for any HR executive. This research-based competency model is particularly compelling because it is informed by the perspective of non-HR executives and stakeholders.”
 —Sue Meisinger, Distinguished speaker and author, former CEO of SHRM "Read this book for a unique long-term perspective on where HR competencies have brought us and must take us in future."
 —John Boudreau, Professor, University of Southern California and Research Director, Center for Effective Organizations',4,1,9780071802673,'2012-07-20');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Why We Sleep: The New Science of Sleep and Dreams','''Astonishing ... an amazing book ... absolutely chocker full of things that we need to know'' Chris Evans

''Matthew Walker is probably one of the most influential people on the planet'' Evening Standard

THE #1 SUNDAY TIMES BESTSELLER
TLS, OBSERVER, SUNDAY TIMES, FT, GUARDIAN, DAILY MAIL AND EVENING STANDARD BOOKS OF THE YEAR 2017Sleep is one of the most important aspects of our life, health and longevity and yet it is increasingly neglected in twenty-first-century society, with devastating consequences: every major disease in the developed world - Alzheimer''s, cancer, obesity, diabetes - has very strong causal links to deficient sleep.In this book, the first of its kind written by a scientific expert, Professor Matthew Walker explores twenty years of cutting-edge research to solve the mystery of why sleep matters. Looking at creatures from across the animal kingdom as well as major human studies, Why We Sleep delves into everything from what really happens during REM sleep to how caffeine and alcohol affect sleep and why our sleep patterns change across a lifetime, transforming our appreciation of the extraordinary phenomenon that safeguards our existence.''Startling, vital ... a life-raft'' Guardian''A top sleep scientist argues that sleep is more important for our health than diet or exercise'' The Times

''Passionate, urgent . . . it had a powerful effect on me'' Observer',5,1,9780141983776,'2017-09-28');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Rework','Rework shows you a better, faster, easier way to succeed in business. 

Most business books give you the same old advice: Write a business plan, study the competition, seek investors, yadda yadda. If you''re looking for a book like that, put this one back on the shelf.

Read it and you''ll know why plans are actually harmful, why you don''t need outside investors, and why you''re better off ignoring the competition. The truth is, you need less than you think. You don''t need to be a workaholic. You don''t need to staff up. You don''t need to waste time on paperwork or meetings. You don''t even need an office. Those are all just excuses. 

 What you really need to do is stop talking and start working. This book shows you the way. You''ll learn how to be more productive, how to get exposure without breaking the bank, and tons more counterintuitive ideas that will inspire and provoke you.

With its straightforward language and easy-is-better approach, Rework is the perfect playbook for anyone who’s ever dreamed of doing it on their own. Hardcore entrepreneurs, small-business owners, people stuck in day jobs they hate, victims of "downsizing," and artists who don’t want to starve anymore will all find valuable guidance in these pages.',6,1,9780307463760,'2010-03-09');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Now or Never: A Novel','She can keep the doors locked.  The lights on.  Her fingers crossed.   But she can''t stop the memories of a terrifying crime.  Or keep it from happening again.

The murderer took his time choosing his pretty victims.  Then he took his time killing them.  What was left when he finished made even veteran Boston cop Harry Jordan feel sick.  But this time the killer made a mistake.  His victim was found alive.

Armed with a police sketch of the man, Harry wanted national publicity, the kind he could get from Mallory Malone, the "TV detective."  Her top-rated show reenacted heinous crimes and often jogged witnesses'' memories enough to shake loose the clue that could break the case.  

But not this time.

This case was different for self-made career woman Mallory Malone.  This cop was different.  The case scared her; the cop was falling in love with her.  Her instincts told her to run.  But the killer already knew her name.  Her address.  And a secret that could destroy them both.

Elizabeth Adler was born in Yorkshire, England.  She is married to an American lawyer and has one daughter.  They have lived in Brazil, England, France, and Ireland and currently live in California.  She is the internationally acclaimed author of Léonie, Peach, The Rich Shall Inherit, The Property of a Lady, Fortune Is a Woman, and The Secret of the Villa Mimosa.',7,1,9780307574961,'2010-07-07');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Wedge''s Gamble: Star Wars Legends (X-Wing)','Sleek, swift, and deadly, they are the X-wing fighters. And as the battle against the Empire rages across the vastness of space, the pilots risk both their lives and their machines for the cause of the Rebel Alliance. Now they must embark on a dangerous espionage mission, braving betrayal and death on the Imperial homeworld to smash the power of a ruthless foe!

It is the evil heart of a battered and reeling Empire: Coruscant, the giant city-world from whose massive towers the Imperial High Command directs the war. The Rebels will invade this mighty citadel in a daring move to bring the Empire to its knees. But first Wedge Antilles and his X-wing pilots must infiltrate
Coruscant to gain vital intelligence information. Capture means death, or worse--enslavement by the vicious leader known as "Iceheart," Ysanne Isard, now
Emperor in all but name. And one of Rogue Squadron''s own is already her slave, a traitor hidden behind a mask of innocence, working to betray both colleagues and the Rebellion itself.

Features a bonus section following the novel that includes a primer on the Star Wars expanded universe, and over half a dozen excerpts from some of the most popular Star Wars books of the last thirty years!',8,1,9780307796226,'2011-06-28');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Ready Player One','Nominated as one of America’s best-loved novels by PBS’s The Great American Read

The worldwide bestseller—now a major motion picture directed by Steven Spielberg.

In the year 2045, reality is an ugly place. The only time teenage Wade Watts really feels alive is when he''s jacked into the virtual utopia known as the OASIS. Wade''s devoted his life to studying the puzzles hidden within this world''s digital confines—puzzles that are based on their creator''s obsession with the pop culture of decades past and that promise massive power and fortune to whoever can unlock them. But when Wade stumbles upon the first clue, he finds himself beset by players willing to kill to take this ultimate prize. The race is on, and if Wade''s going to survive, he''ll have to win—and confront the real world he''s always been so desperate to escape.',9,1,9780307887450,'2011-08-16');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Hitchhiker''s Guide to the Galaxy: 42nd Anniversary Edition','The intergalactic adventures of Arthur Dent begin in the first volume of the ''trilogy of five'', Douglas Adams'' comedy sci-fi classic The Hitchhiker''s Guide to the Galaxy. This edition, with a metallic sheen cover, includes exclusive bonus material from the Douglas Adams archives, and an introduction by former Doctor Who showrunner, Russell T Davies.On 12 October 1979 the most remarkable book ever to come out of the great publishing corporations of Ursa Minor (and Earth) was made available to humanity - The Hitchhiker''s Guide to the Galaxy.

It''s an ordinary Thursday lunchtime for Arthur Dent until his house gets demolished. The Earth follows shortly afterwards to make way for a new hyperspace express route, and his best friend has just announced that he''s an alien. At this moment, they''re hurtling through space with nothing but their towels and an innocuous-looking book inscribed, in large friendly letters, with the words: DON''T PANIC. The weekend has only just begun . . .Follow Arthur Dent''s galactic (mis)adventures in the rest of the trilogy with five parts: The Restaurant at the End of the Universe, Life, the Universe and Everything, So Long, and Thanks for All the Fish, and Mostly Harmless.',10,1,9780330513081,'2009-09-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Total Control','Total Control is a breathtaking thrill-ride on a roller-coaster of non-stop action and suspense from David Baldacci, one of the world''s favourite storytellers.Jason Archer is a rising young executive at Triton Global, the world''s leading technology conglomerate. Determined to give his family the best of everything, he has secretly entered into a deadly game of cat and mouse. He is about to disappear, leaving behind a wife who must sort out his lies from his truths; an air-crash investigation team that wants to know why the plane he was booked on suddenly fell from the sky; and a veteran FBI agent who leaves no stone unturned.Soon the startling truth behind Jason Archer''s disappearance explodes into a sinister plot involving the murder of the country''s single most powerful individual. And Archer''s wife, Sidney, is plunged straight into the violence, now faced with trail of dead bodies and shocking, exposed secrets.',10,1,9780330523332,'2011-11-04');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Shall We Tell the President?','Shall We Tell the President is an enthralling, fast-paced thriller from the bestselling author of Kane and Abel, Jeffrey Archer.6 days, 13 hours and 37 minutes to go . . . At the end of The Prodigal Daughter, Florentyna Kane is elected President – the first woman President of the United States. At 7.30 one evening the FBI learn of a plot to kill her – the 1572nd such threat of the year. At 8.30 five people know all the details. By 9.30 four of them are dead. FBI agent Mark Andrews alone knows when. He also knows that a senator is involved. He has six days to learn where – and how. Six days to prevent certain death of the President.',10,1,9780330524759,'2011-04-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Mrs. Pollifax Unveiled','After facing down hijackers on a flight to the Middle East and saving the lives of the passengers on board, a young American woman steps off the plane in Damascus in a blaze of celebrity and disappears. The CIA believes Amanda Pym was kidnapped, possibly murdered.

Masquerading as Amanda Pym’s worried aunt, Mrs. Pollifax begins her determined search, slipping through Damascus’s crooked streets and crowded souks . . . and trekking deep into the desert. Yet she is shadowed by deadly enemies, whose sinister agenda threatens not only Mrs. P. but the fragile stability of the entire Middle East. Only a miracle–or a brilliant counterplot– can forestall a disaster that will send shock waves around the world.',11,1,9780345443076,'2000-05-31');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Gangster: A Novel','Love. Violence. Destiny. These powerful themes ricochet through Lorenzo Carcaterra’s new novel like bullets from a machine gun. In Gangster, he surpasses even his bestselling Sleepers to create a brutal and brilliant American saga of murder, forgiveness, and redemption.

Born in the midst of tragedy and violence and raised in the shadow of a shocking secret, young Angelo Vestieri chooses to flee both his past and his father to seek a second family—the criminals who preside over early 20th century New York. In his bloody rise from soldier to mob boss, he encounters ever more barbaric betrayals—in friendship, in his brutal business, in love—yet simultaneously comes to understand the meaning of loyalty, the virtue of relationships, and gains a perspective on the lonely, if powerful, life he has chosen.

As the years pass, as enemies are made and defeated, as wars are fought and won, the old don meets an abandoned boy who needs a parent as much as protection. By taking Gabe under his wing and teaching him everything he knows, Angelo Vestieri will learn, in the winter of his life, which is greater: his love for the boy he cherishes, or his need to be a gangster and to live by the savage rules he helped create.

A sweeping panoramic with riveting characters, a unique understanding of the underworld philosophy, and a relentless pace, Gangster travels through the time of godfathers and goodfellas to our own world of suburban Sopranos. But this is more than just an authentic chronicle of crime. Setting a new standard for this acclaimed author, Gangster is a compassionate portrait of one man''s fight against his fate—and an unforgettable epic of a family, a city, a century.',11,1,9780345459541,'2002-07-30');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Daylight War: Book Three of The Demon Cycle','NEW YORK TIMES BESTSELLER

With The Warded Man and The Desert Spear, Peter V. Brett surged to the front rank of contemporary fantasy, standing alongside giants in the field such as George R. R. Martin, Robert Jordan, and Terry Brooks. The Daylight War, the eagerly anticipated third volume in Brett’s internationally bestselling Demon Cycle, continues the epic tale of humanity’s last stand against an army of demons that rise each night to prey on mankind.

 On the night of the new moon, the demons rise in force, seeking the deaths of two men, both of whom have the potential to become the fabled Deliverer, the man prophesied to reunite the scattered remnants of humanity in a final push to destroy the demon corelings once and for all.

 Arlen Bales was once an ordinary man, but now he has become something more—the Warded Man, tattooed with eldritch wards so powerful they make him a match for any demon. Arlen denies he is the Deliverer at every turn, but the more he tries to be one with the common folk, the more fervently they believe. Many would follow him, but Arlen’s path threatens to lead to a dark place he alone can travel to, and from which there may be no returning.

 The only one with hope of keeping Arlen in the world of men, or joining him in his descent into the world of demons, is Renna Tanner, a fierce young woman in danger of losing herself to the power of demon magic.

 Ahmann Jardir has forged the warlike desert tribes of Krasia into a demon-killing army and proclaimed himself Shar’Dama Ka, the Deliverer. He carries ancient weapons—a spear and a crown—that give credence to his claim, and already vast swaths of the green lands bow to his control.

 But Jardir did not come to power on his own. His rise was engineered by his First Wife, Inevera, a cunning and powerful priestess whose formidable demon bone magic gives her the ability to glimpse the future. Inevera’s motives and past are shrouded in mystery, and even Jardir does not entirely trust her.

 Once Arlen and Jardir were as close as brothers. Now they are the bitterest of rivals. As humanity’s enemies rise, the only two men capable of defeating them are divided against each other by the most deadly demons of all—those lurking in the human heart.

Look for Peter V. Brett’s complete Demon Cycle:
 THE WARDED MAN | THE DESERT SPEAR | THE DAYLIGHT WAR | THE SKULL THRONE | THE CORE

Praise for The Daylight War

“[Peter V. Brett] confirms his place among epic fantasy’s pantheon of greats amid the likes of George R. R. Martin, Steven Erikson, and Robert Jordan.”—Fantasy Book Critic

“Brett’s prose and flow remain virtually flawless, providing for a smooth read during which you don’t feel guilty for skipping two meals so you can lie on the couch and keep reading.”—Fixed on Fantasy

“The best book yet in The Demon Cycle. If you are looking for a great series, look no further.”—Roqoo Depot

“After the phenomenal success of both The Warded Man and The Desert Spear, I was tentative about The Daylight War; surely it couldn’t get much better? Well, I was wrong. . . . This will be a strong contender for one of the best books of the year, even this early on.”—Jet Black Ink

“Brett has his hooks in me and I want more of The Demon Cycle.”—Best Fantasy Books',8,1,9780345535658,'2013-02-12');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Darksiders: The Abomination Vault: A Novel','Ride with the Horsemen of the Apocalypse as they seek to unearth a plot that could plunge all of Creation into chaos!
  
 Ages before the events of Darksiders and Darksiders II, two of the feared Horsemen—Death and War—are tasked with stopping a group of renegades from locating the Abomination Vault: a hoard containing weapons of ultimate power and malice, capable of bringing an end to the uneasy truce between Heaven and Hell . . . but only by unleashing total destruction.
  
 Created in close collaboration with the Darksiders II teams at Vigil and THQ, Darksiders: The Abomination Vault gives an exciting look at the history and world of the Horsemen, shining a new light on the unbreakable bond between War and Death.',8,1,9780345535863,'2012-07-24');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Morning Star','#1 NEW YORK TIMES BESTSELLER • Red Rising thrilled readers and announced the presence of a talented new author. Golden Son changed the game and took the story of Darrow to the next level. Now comes the exhilarating next chapter in the Red Rising Saga: Morning Star.

ITW THRILLER AWARD FINALIST • “[Brown’s] achievement is in creating an uncomfortably familiar world of flaw, fear, and promise.”—Entertainment Weekly

Darrow would have lived in peace, but his enemies brought him war. The Gold overlords demanded his obedience, hanged his wife, and enslaved his people. But Darrow is determined to fight back. Risking everything to transform himself and breach Gold society, Darrow has battled to survive the cutthroat rivalries that breed Society’s mightiest warriors, climbed the ranks, and waited patiently to unleash the revolution that will tear the hierarchy apart from within.

 Finally, the time has come.

 But devotion to honor and hunger for vengeance run deep on both sides. Darrow and his comrades-in-arms face powerful enemies without scruple or mercy. Among them are some Darrow once considered friends. To win, Darrow will need to inspire those shackled in darkness to break their chains, unmake the world their cruel masters have built, and claim a destiny too long denied—and too glorious to surrender.

Praise for Morning Star

“There is no one writing today who does shameless, Michael Bay–style action set pieces the way Brown does. The battle scenes are kinetic, bloody, breathless, crazy. Everything is on fire all the time.”—NPR

 “Morning Star is this trilogy’s Return of the Jedi. . . . The impactful battles that make up most of Morning Star are damn near operatic. . . . It absolutely satisfies.”—Tordotcom

 “Excellent . . . Brown’s vivid, first-person prose puts the reader right at the forefront of impassioned speeches, broken families, and engaging battle scenes . . . as this interstellar civil war comes to a most satisfying conclusion.”—Publishers Weekly (starred review)

 “A page-turning epic filled with twists and turns . . . The conclusion to Brown’s saga is simply stellar.”—Booklist (starred review)

Don’t miss any of Pierce Brown’s Red Rising Saga:
RED RISING • GOLDEN SON • MORNING STAR • IRON GOLD • DARK AGE',8,1,9780345539854,'2016-02-09');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Thrawn (Star Wars)','NEW YORK TIMES BESTSELLER • In this definitive novel, readers will follow Thrawn’s rise to power—uncovering the events that created one of the most iconic villains in Star Wars history.

 One of the most cunning and ruthless warriors in the history of the Galactic Empire, Grand Admiral Thrawn is also one of the most captivating characters in the Star Wars universe, from his introduction in bestselling author Timothy Zahn’s classic Heir to the Empire through his continuing adventures in Dark Force Rising, The Last Command, and beyond. But Thrawn’s origins and the story of his rise in the Imperial ranks have remained mysterious. Now, in Star Wars: Thrawn, Timothy Zahn chronicles the fateful events that launched the blue-skinned, red-eyed master of military strategy and lethal warfare into the highest realms of power—and infamy.

Praise for Thrawn

“The origin story of one of the greatest Star Wars villains . . . a book that fans have wanted for decades.”—The Verge

 “A satisfying tale of political intrigue . . . Thrawn’s observations and tactical thinking are utterly captivating.”—New York Daily News

 “Quite the page-turner.”—Flickering Myth',8,1,9780345542847,'2017-04-11');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Auberon','A novella set in the universe of James S. A. Corey''s New York Times bestselling Expanse series, Auberon explores a new and alien world and the age-old dangers that humanity has carried with it to the stars. Now a Prime Original series. Auberon is one of the first and most important colony worlds in humanity''s reach, and the new conquering faction has come to claim it. Governor Rittenaur has come to bring civilization and order to the far outpost and guarantee the wealth and power of the Empire.But Auberon already has its own history, a complex culture, and a criminal kingpin named Erich with very different plans. In a world of deceit, violence, and corruption, the greatest danger Rittenaur faces is love. 
The Expanse
Leviathan Wakes
Caliban''s War
Abaddon''s Gate
Cibola Burn
Nemesis Games
Babylon''s Ashes
Persepolis Rising
Tiamat''s WrathThe Expanse Short Fiction
The Butcher of Anderson Station
Gods of Risk
The Churn
The Vital Abyss
Strange Dogs
Auberon',12,1,9780356504322,'2019-11-12');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Burning White: Book Five of Lightbringer','The Burning White is the epic conclusion to the Lightbringer series by New York Times bestseller Brent Weeks - one of the most popular fantasy series of recent years. 

As the White King springs his great trap, and the Chromeria itself is threatened by treason and siege, Kip Guile and his companions will scramble to return for one impossible final stand.In the darkest hour, will the Lightbringer come?

The Lightbringer series
The Black Prism
The Blinding Knife
The Broken Eye
The Blood Mirror
The Burning WhiteMore novels from Brent Weeks:Night Angel
 The Way of Shadows
 Shadow''s Edge
 Beyond the Shadows
Perfect Shadow (novella)',12,1,9780356504650,'2019-10-22');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Find Me: A Novel','A New York Times Bestseller

In this spellbinding exploration of the varieties of love, the author of the worldwide bestseller Call Me by Your Name revisits its complex and beguiling characters decades after their first meeting. No novel in recent memory has spoken more movingly to contemporary readers about the nature of love than André Aciman’s haunting Call Me by Your Name. First published in 2007, it was hailed as “a love letter, an invocation . . . an exceptionally beautiful book” (Stacey D’Erasmo, The New York Times Book Review). Nearly three quarters of a million copies have been sold, and the book became a much-loved, Academy Award–winning film starring Timothée Chalamet as the young Elio and Armie Hammer as Oliver, the graduate student with whom he falls in love. In Find Me, Aciman shows us Elio’s father, Samuel, on a trip from Florence to Rome to visit Elio, who has become a gifted classical pianist. A chance encounter on the train with a beautiful young woman upends Sami’s plans and changes his life forever.Elio soon moves to Paris, where he, too, has a consequential affair, while Oliver, now a New England college professor with a family, suddenly finds himself contemplating a return trip across the Atlantic. Aciman is a master of sensibility, of the intimate details and the emotional nuances that are the substance of passion. Find Me brings us back inside the magic circle of one of our greatest contemporary romances to ask if, in fact, true love ever dies.',13,1,9780374722104,'2019-10-29');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Becoming Steve Jobs: The Evolution of a Reckless Upstart into a Visionary Leader','The #1 New York Times bestselling biography of how Steve Jobs became the most visionary CEO in history.  

 Becoming Steve Jobs breaks down the conventional, one-dimensional view of Steve Jobs that he was half-genius, half-jerk from youth, an irascible and selfish leader who slighted friends and family alike. Becoming Steve Jobs answers the central question about the life and career of the Apple cofounder and CEO: How did a young man so reckless and arrogant that he was exiled from the company he founded become the most effective visionary business leader of our time, ultimately transforming the daily life of billions of people?

 Drawing on incredible and sometimes exclusive access, Schlender and Tetzeli tell a different story of a real human being who wrestled with his failings and learned to maximize his strengths over time. Their rich, compelling narrative is filled with stories never told before from the people who knew Jobs best, including his family, former inner circle executives, and top people at Apple, Pixar and Disney, most notably Tim Cook, Jony Ive, Eddy Cue, Ed Catmull, John Lasseter, Robert Iger and many others. In addition, Schlender knew Jobs personally for 25 years and draws upon his many interviews with him, on and off the record, in writing the book. He and Tetzeli humanize the man and explain, rather than simply describe, his behavior. Along the way, the book provides rich context about the technology revolution we''ve all lived through, and the ways in which Jobs changed our world.

 A rich and revealing account, Becoming Steve Jobs shows us how one of the most colorful and compelling figures of our times was able to combine his unchanging, relentless passion with an evolution in management style to create one of the most valuable and beloved companies on the planet.',14,1,9780385347419,'2015-03-24');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Girl in the Spider''s Web: A Lisbeth Salander novel, continuing Stieg Larsson''s Millennium Series','Soon to be a major motion picture starring Claire Foy. Lisbeth Salander and Mikael Blomkvist return in this ripped-from-the-headlines, high-octane follow-up to Stieg Larsson''s The Girl Who Kicked the Hornet''s Nest. 

One of the Best Books of the Year
 NPR * USA Today * O, The Oprah Magazine * Esquire
  
 A genius hacker who has always been an outsider. A journalist with a penchant for danger. She is Lisbeth Salander, the girl with the dragon tattoo. He is Mikael Blomkvist, crusading editor of Millennium. One night, Blomkvist receives a call from a source who claims to have been given information vital to the United States by a young female hacker. Blomkvist, always on the lookout for a story, reaches out to Salander for help. She, as usual, has plans of her own. Together they are drawn into a ruthless underworld of spies, cybercriminals, and government operatives—some willing to kill to protect their secrets.',15,1,9780385354295,'2015-09-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Guardians: A Novel','In this instant #1 New York Times bestseller, John Grisham delivers a classic legal thriller—with a twist.

“Terrific…affecting…Grisham has done it again.”—Maureen Corrigan, The Washington Post
 
“A suspenseful thriller mixed with powerful themes.”—Associated Press


In the small Florida town of Seabrook, a young lawyer named Keith Russo was shot dead at his desk as he worked late one night. The killer left no clues. There were no witnesses, no one with a motive. But the police soon came to suspect Quincy Miller, a young black man who was once a client of Russo’s. 

 Quincy was tried, convicted, and sent to prison for life. For twenty-two years he languished in prison, maintaining his innocence.  But no one was listening.  He had no lawyer, no advocate on the outside. In desperation, he writes a letter to Guardian Ministries, a small nonprofit run by Cullen Post, a lawyer who is also an Episcopal minister.

 Guardian accepts only a few innocence cases at a time.  Cullen Post travels the country fighting wrongful convictions and taking on clients forgotten by the system. With Quincy Miller, though, he gets far more than he bargained for. Powerful, ruthless people murdered Keith Russo, and they do not want Quincy Miller exonerated.

 They killed one lawyer twenty-two years ago, and they will kill another without a second thought.',16,1,9780385544191,'2019-10-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Platform Revolution: How Networked Markets Are Transforming the Economy—and How to Make Them Work for You','A practical guide to the new economy that is transforming the way we live, work, and play. Uber. Airbnb. Amazon. Apple. PayPal. All of these companies disrupted their markets when they launched. Today they are industry leaders. What’s the secret to their success? These cutting-edge businesses are built on platforms: two-sided markets that are revolutionizing the way we do business. Written by three of the most sought-after experts on platform businesses, Platform Revolution is the first authoritative, fact-based book on platform models. Whether platforms are connecting sellers and buyers, hosts and visitors, or drivers with people who need a ride, Geoffrey G. Parker, Marshall W. Van Alstyne, and Sangeet Paul Choudary reveal the what, how, and why of this revolution and provide the first “owner’s manual” for creating a successful platform business. Platform Revolution teaches newcomers how to start and run a successful platform business, explaining ways to identify prime markets and monetize networks. Addressing current business leaders, the authors reveal strategies behind some of today’s up-and-coming platforms, such as Tinder and SkillShare, and explain how traditional companies can adapt in a changing marketplace. The authors also cover essential issues concerning security, regulation, and consumer trust, while examining markets that may be ripe for a platform revolution, including healthcare, education, and energy. As digital networks increase in ubiquity, businesses that do a better job of harnessing the power of the platform will win. An indispensable guide, Platform Revolution charts out the brilliant future of platforms and reveals how they will irrevocably alter the lives and careers of millions.',17,1,9780393249125,'2016-03-28');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Captivate: The Science of Succeeding with People','Do you feel awkward at networking events? Do you wonder what your date really thinks of you? Do you wish you could decode people? You need to learn the science of people.
  
 As a human behavior hacker, Vanessa Van Edwards created a research lab to study the hidden forces that drive us. And she’s cracked the code. In Captivate, she shares shortcuts, systems, and secrets for taking charge of your interactions at work, at home, and in any social situation. These aren’t the people skills you learned in school. This is the first comprehensive, science backed, real life manual on how to captivate anyone—and a completely new approach to building connections.
  
 Just like knowing the formulas to use in a chemistry lab, or the right programming language to build an app, Captivate provides simple ways to solve people problems. You’ll learn, for example…
 
 · How to work a room: Every party, networking event, and social situation has a predictable map. Discover the sweet spot for making the most connections.
 · How to read faces: It’s easier than you think to speed-read facial expressions and use them to predict people’s emotions.
 · How to talk to anyone: Every conversation can be memorable—once you learn how certain words generate the pleasure hormone dopamine in listeners.

 When you understand the laws of human behavior, your influence, impact, and income will increase significantly. What’s more, you will improve your interpersonal intelligence, make a killer first impression, and build rapport quickly and authentically in any situation—negotiations, interviews, parties, and pitches. You’ll never interact the same way again.',18,1,9780399564505,'2017-04-25');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Shattered Bonds','Jane Yellowrock must dig deep and find strength within herself if she is to survive in the latest novel in this New York Times bestselling series.

Jane Yellowrock is vampire-killer-for-hire, but her last battle with an ancient arcane enemy has brought her low. She seeks retreat in the Appalachian Mountains to grieve the loss of her friends, and to heal—or to die—from the disease brought on by her magic. 

 But malevolent elements in the paranormal community still seek to destroy Jane, and a terrifying foe stalks her, even into the safety of the hills. With nowhere to run and her body failing, the rogue-vampire hunter and her inner Beast must discover a way to defeat this new threat, and find a form that gives her a chance to fight another day.',18,1,9780399587993,'2019-10-29');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Blue Moon: A Jack Reacher Novel','#1 NEW YORK TIMES BESTSELLER • In the next highly anticipated installment of Lee Child’s acclaimed suspense series, Jack Reacher comes to the aid of an elderly couple . . . and confronts his most dangerous opponents yet.
 
“Jack Reacher is today’s James Bond, a thriller hero we can’t get enough of.”—Ken Follett

“This is a random universe,” Reacher says. “Once in a blue moon things turn out just right.”
 
This isn’t one of those times.
 
Reacher is on a Greyhound bus, minding his own business, with no particular place to go, and all the time in the world to get there. Then he steps off the bus to help an old man who is obviously just a victim waiting to happen. But you know what they say about good deeds. Now Reacher wants to make it right.
 
An elderly couple have made a few well-meaning mistakes, and now they owe big money to some very bad people. One brazen move leads to another, and suddenly Reacher finds himself a wanted man in the middle of a brutal turf war between rival Ukrainian and Albanian gangs.
 
Reacher has to stay one step ahead of the loan sharks, the thugs, and the assassins. He teams up with a fed-up waitress who knows a little more than she’s letting on, and sets out to take down the powerful and make the greedy pay. It’s a long shot. The odds are against him. But Reacher believes in a certain kind of justice . . . the kind that comes along once in a blue moon.',19,1,9780399593550,'2019-10-29');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Dark Age','NEW YORK TIMES BESTSELLER • The bestselling author of Morning Star returns to the Red Rising universe with the thrilling sequel to Iron Gold.
 
“Brown’s plots are like a depth charge of nitromethane dropped in a bucket of gasoline. His pacing is 100% him standing over it all with a lit match and a smile, waiting for us to dare him to drop it.”—NPR

He broke the chains. Then he broke the world….
 
A decade ago Darrow led a revolution, and laid the foundations for a new world. Now he’s an outlaw.
 
Cast out of the very Republic he founded, with half his fleet destroyed, he wages a rogue war on Mercury. Outnumbered and outgunned, is he still the hero who broke the chains? Or will he become the very evil he fought to destroy?
 
In his darkening shadow, a new hero rises. 
 
Lysander au Lune, the displaced heir to the old empire, has returned to bridge the divide between the Golds of the Rim and Core. If united, their combined might may prove fatal to the fledgling Republic. 
 
On Luna, the embattled Sovereign of the Republic, Virginia au Augustus, fights to preserve her precious demokracy and her exiled husband. But one may cost her the other, and her son is not yet returned.
 
Abducted by enemy agents, Pax au Augustus must trust in a Gray thief, Ephraim, for his salvation. 
 
Far across the void, Lyria, a Red refugee accused of treason, makes a desperate bid for freedom with the help of two unlikely new allies.
 
Fear dims the hopes of the Rising, and as power is seized, lost, and reclaimed, the worlds spin on and on toward a new Dark Age.

Don’t miss any of Pierce Brown’s Red Rising Saga:
RED RISING • GOLDEN SON • MORNING STAR • IRON GOLD • DARK AGE',8,1,9780425285954,'2019-07-30');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Salvaged','A WOMAN ON THE RUN. A CAPTAIN ADRIFT IN SPACE. ONE OF THEM IS INFECTED WITH AN ALIEN PARASITE. 

In this dark science fiction thriller, a young woman must confront her past so the human race will have a future.

Rosalyn Devar is on the run from her famous family, the bioengineering job she''s come to hate, and her messed-up life. She''s run all the way to outer space, where she''s taken a position as a "space janitor," cleaning up ill-fated research expeditions. But no matter how far she goes, Rosalyn can''t escape herself. After too many mistakes on the job, she''s given one last chance: take care of salvaging the Brigantine, a research vessel that has gone dark, with all crew aboard thought dead.

But the Brigantine''s crew are very much alive--if not entirely human. Now Rosalyn is trapped on board, alone with a crew infected by a mysterious parasitic alien. The captain, Edison Aries, seems to still maintain some control over himself and the crew, but he won''t be able to keep fighting much longer. Rosalyn and Edison must find a way to stop the parasite''s onslaught...or it may take over the entire human race.',18,1,9780451491848,'2019-10-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Memoirs of Sherlock Holmes','Boasting some of Sherlock Holmes''s finest adventures, this classic 1894 collection was originally written in serial form. Eleven of the most popular tales of the immortal sleuth include "Silver Blaze," concerning the "curious incident of the dog in the night-time"; "The Greek Interpreter," starring Holmes''s even more formidable brother, Mycroft; and "The Final Problem," the detective''s notorious confrontation with arch-criminal Moriarty at the Reichenbach Falls.
Holmes and Dr. Watson remain history''s greatest detective team, and Sir Arthur Conan Doyle''s portrayals of male comradeship, the thrills of the chase, and the misty precincts of Victorian London remains unmatched in detective literature.',20,1,9780486114354,'2012-05-11');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('No One Is Too Small to Make a Difference','The groundbreaking speeches of Greta Thunberg, the young climate activist who has become the voice of a generation, including her historic address to the United Nations 

In August 2018 a fifteen-year-old Swedish girl, Greta Thunberg, decided not to go to school one day in order to protest the climate crisis. Her actions sparked a global movement, inspiring millions of students to go on strike for our planet, forcing governments to listen, and earning her a Nobel Peace Prize nomination.

No One Is Too Small to Make A Difference brings you Greta in her own words, for the first time. Collecting her speeches that have made history across the globe, from the United Nations to Capitol Hill and mass street protests, her book is a rallying cry for why we must all wake up and fight to protect the living planet, no matter how powerless we feel. Our future depends upon it.',18,1,9780525505372,'2019-11-12');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Final Option','In Final Option, Juan Cabrillo fights the worst enemy from his past to the terrifying and unexpected ending created by the Grand Master of Adventure, Clive Cussler, in the latest action-packed thriller in his #1 New York Times-bestselling series.

When the CIA realizes the identities of three American spies in Brazil have been compromised, they turn to Juan Cabrillo and the crew of the Oregon to rescue the agents. What seems a routine operation turns out to be a trap designed by Juan Cabrillo''s greatest enemy, a man driven by hate to seek the ultimate revenge. At the heart of the plot is a state-of-the-art ship that is identical to the Oregon: same weaponry, same technology, same ability to evade capture. The only thing it doesn''t have is Cabrillo and his talented crew. But will they be enough to go up against the one ship that rivals their own? 

The crew of the Oregon must piece together a series of disturbing events, including the mysterious sinking of a nuclear attack submarine and the possible discovery of a WWII-era weapon that was thought to be lost in the jungles of Brazil, in the ultimate game of cat and mouse.',18,1,9780525541820,'2019-11-05');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Man in the High Castle','Now an Amazon Original series
  
Winner of the Hugo Award

“The single most resonant and carefully imagined book of Dick’s career.” —New York Times
  
 It’s America in 1962. Slavery is legal once again. The few Jews who still survive hide under assumed names. In San Francisco, the I Ching is as common as the Yellow Pages. All because some twenty years earlier the United States lost a war—and is now occupied by Nazi Germany and Japan.
  
 This harrowing, Hugo Award–winning novel is the work that established Philip K. Dick as an innovator in science fiction while breaking the barrier between science fiction and the serious novel of ideas. In it Dick offers a haunting vision of history as a nightmare from which it may just be possible to wake.',21,1,9780547601205,'2012-01-24');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('A Game of Thrones: A Song of Ice and Fire: Book One','NOW THE ACCLAIMED HBO SERIES GAME OF THRONES—THE MASTERPIECE THAT BECAME A CULTURAL PHENOMENON
 
Winter is coming. Such is the stern motto of House Stark, the northernmost of the fiefdoms that owe allegiance to King Robert Baratheon in far-off King’s Landing. There Eddard Stark of Winterfell rules in Robert’s name. There his family dwells in peace and comfort: his proud wife, Catelyn; his sons Robb, Brandon, and Rickon; his daughters Sansa and Arya; and his bastard son, Jon Snow. Far to the north, behind the towering Wall, lie savage Wildings and worse—unnatural things relegated to myth during the centuries-long summer, but proving all too real and all too deadly in the turning of the season.
 
Yet a more immediate threat lurks to the south, where Jon Arryn, the Hand of the King, has died under mysterious circumstances. Now Robert is riding north to Winterfell, bringing his queen, the lovely but cold Cersei, his son, the cruel, vainglorious Prince Joffrey, and the queen’s brothers Jaime and Tyrion of the powerful and wealthy House Lannister—the first a swordsman without equal, the second a dwarf whose stunted stature belies a brilliant mind. All are heading for Winterfell and a fateful encounter that will change the course of kingdoms.
 
Meanwhile, across the Narrow Sea, Prince Viserys, heir of the fallen House Targaryen, which once ruled all of Westeros, schemes to reclaim the throne with an army of barbarian Dothraki—whose loyalty he will purchase in the only coin left to him: his beautiful yet innocent sister, Daenerys.',22,1,9780553897845,'2003-01-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('A Dance with Dragons: A Song of Ice and Fire: Book Five','#1 NEW YORK TIMES BESTSELLER • THE BOOK BEHIND THE FIFTH SEASON OF THE ACCLAIMED HBO SERIES GAME OF THRONES

Don’t miss the thrilling sneak peek of George R. R. Martin’s A Song of Ice and Fire: Book Six, The Winds of Winter

Dubbed “the American Tolkien” by Time magazine, George R. R. Martin has earned international acclaim for his monumental cycle of epic fantasy. Now the #1 New York Times bestselling author delivers the fifth book in his landmark series—as both familiar faces and surprising new forces vie for a foothold in a fragmented empire. 
 
A DANCE WITH DRAGONS
A SONG OF ICE AND FIRE: BOOK FIVE
 
In the aftermath of a colossal battle, the future of the Seven Kingdoms hangs in the balance—beset by newly emerging threats from every direction. In the east, Daenerys Targaryen, the last scion of House Targaryen, rules with her three dragons as queen of a city built on dust and death. But Daenerys has thousands of enemies, and many have set out to find her. As they gather, one young man embarks upon his own quest for the queen, with an entirely different goal in mind.

Fleeing from Westeros with a price on his head, Tyrion Lannister, too, is making his way to Daenerys. But his newest allies in this quest are not the rag-tag band they seem, and at their heart lies one who could undo Daenerys’s claim to Westeros forever.

Meanwhile, to the north lies the mammoth Wall of ice and stone—a structure only as strong as those guarding it. There, Jon Snow, 998th Lord Commander of the Night’s Watch, will face his greatest challenge. For he has powerful foes not only within the Watch but also beyond, in the land of the creatures of ice.

From all corners, bitter conflicts reignite, intimate betrayals are perpetrated, and a grand cast of outlaws and priests, soldiers and skinchangers, nobles and slaves, will face seemingly insurmountable obstacles. Some will fail, others will grow in the strength of darkness. But in a time of rising restlessness, the tides of destiny and politics will lead inevitably to the greatest dance of all.

Praise for A Dance with Dragons
  
 “Filled with vividly rendered set pieces, unexpected turnings, assorted cliffhangers and moments of appalling cruelty, A Dance with Dragons is epic fantasy as it should be written: passionate, compelling, convincingly detailed and thoroughly imagined.”—The Washington Post
  
 “Long live George Martin . . . a literary dervish, enthralled by complicated characters and vivid language, and bursting with the wild vision of the very best tale tellers.”—The New York Times
  
 “One of the best series in the history of fantasy.”—Los Angeles Times',22,1,9780553905656,'2011-07-12');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Jump','Struggling to come to terms with the suicide of her teenage son, Ellie lives in the shadows of the Forth Road Bridge, lingering on its footpaths and swimming in the waters below. One day she talks down another suicidal teenager, Sam, and sees for herself a shot at redemption, the chance to atone for her son''s death. But even with the best intentions, she can''t foresee the situation she''s falling headlong into - a troubled family, with some very dark secrets of their own. From #1 bestselling author of Gone Again, The Jump is a hugely moving contemporary thriller, and a stunning portrait of an unlikely heroine.',23,1,9780571321599,'2015-08-04');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Find Me: A TOP TEN SUNDAY TIMES BESTSELLER','In Find Me, Aciman shows us Elio''s father, Samuel, on a trip from Florence to Rome to visit Elio, now a gifted classical pianist. A chance encounter on the train upends Sami''s visit and changes his life forever.
Elio soon moves to Paris, where he, too, has a consequential affair, while Oliver, a New England college professor with a family, suddenly finds himself contemplating a return trip across the Atlantic.Aciman is a master of sensibility, of the intimate details and the nuances of emotion that are the substance of passion. Find Me brings us back inside the world of one of our greatest contemporary romances to show us that in fact true love never dies.',23,1,9780571356515,'2019-10-29');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Name of the Wind: The Kingkiller Chronicle:, Book 1','''I have stolen princesses back from sleeping barrow kings. I burned down the town of Trebon. I have spent the night with Felurian and left with both my sanity and my life. I was expelled from the University at a younger age than most people are allowed in. I tread paths by moonlight that others fear to speak of during day. I have talked to Gods, loved women, and written songs that make the minstrels weep. My name is Kvothe.
You may have heard of me''So begins the tale of Kvothe - currently known as Kote, the unassuming innkeepter - from his childhood in a troupe of traveling players, through his years spent as a near-feral orphan in a crime-riddled city, to his daringly brazen yet successful bid to enter a difficult and dangerous school of magic. In these pages you will come to know Kvothe the notorious magician, the accomplished thief, the masterful musician, the dragon-slayer, the legend-hunter, the lover, the thief and the infamous assassin.The Name of the Wind is fantasy at its very best, and an astounding must-read title.',12,1,9780575087057,'2010-04-22');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Power of Habit: Why We Do What We Do in Life and Business','NEW YORK TIMES BESTSELLER • This instant classic explores how we can change our lives by changing our habits.

 NAMED ONE OF THE BEST BOOKS OF THE YEAR BY The Wall Street Journal • Financial Times
 
In The Power of Habit, award-winning business reporter Charles Duhigg takes us to the thrilling edge of scientific discoveries that explain why habits exist and how they can be changed. Distilling vast amounts of information into engrossing narratives that take us from the boardrooms of Procter & Gamble to the sidelines of the NFL to the front lines of the civil rights movement, Duhigg presents a whole new understanding of human nature and its potential. At its core, The Power of Habit contains an exhilarating argument: The key to exercising regularly, losing weight, being more productive, and achieving success is understanding how habits work. As Duhigg shows, by harnessing this new science, we can transform our businesses, our communities, and our lives.

With a new Afterword by the author
  
 “Sharp, provocative, and useful.”—Jim Collins
  
 “Few [books] become essential manuals for business and living. The Power of Habit is an exception. Charles Duhigg not only explains how habits are formed but how to kick bad ones and hang on to the good.”—Financial Times
  
 “A flat-out great read.”—David Allen, bestselling author of Getting Things Done: The Art of Stress-Free Productivity
  
 “You’ll never look at yourself, your organization, or your world quite the same way.”—Daniel H. Pink, bestselling author of Drive and A Whole New Mind
  
 “Entertaining . . . enjoyable . . . fascinating . . . a serious look at the science of habit formation and change.”—The New York Times Book Review',24,1,9780679603856,'2012-02-28');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Boy Erased: A Memoir','The New York Times bestselling memoir about identity, love and understanding. Now a major motion picture starring Nicole Kidman, Russell Crowe, and Lucas Hedges, directed by Joel Edgerton. "Every sentence of the story will stir your soul" (O Magazine).
  
 The son of a Baptist pastor and deeply embedded in church life in small town Arkansas, as a young man Garrard Conley was terrified and conflicted about his sexuality.
  
 When Garrard was a nineteen-year-old college student, he was outed to his parents, and was forced to make a life-changing decision: either agree to attend a church-supported conversion therapy program that promised to “cure” him of homosexuality; or risk losing family, friends, and the God he had prayed to every day of his life. Through an institutionalized Twelve-Step Program heavy on Bible study, he was supposed to emerge heterosexual, ex-gay, cleansed of impure urges and stronger in his faith in God for his brush with sin. Instead, even when faced with a harrowing and brutal journey, Garrard found the strength and understanding to break out in search of his true self and forgiveness. 
  
 By confronting his buried past and the burden of a life lived in shadow, Garrard traces the complex relationships among family, faith, and community. At times heart-breaking, at times triumphant, this memoir is a testament to love that survives despite all odds.',18,1,9780698155558,'2016-05-10');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Getting Things Done: The Art of Stress-Free Productivity','The book Lifehack calls "The Bible of business and personal productivity."

"A completely revised and updated edition of the blockbuster bestseller from ''the personal productivity guru''"—Fast Company

Since it was first published almost fifteen years ago, David Allen’s Getting Things Done has become one of the most influential business books of its era, and the ultimate book on personal organization. “GTD” is now shorthand for an entire way of approaching professional and personal tasks, and has spawned an entire culture of websites, organizational tools, seminars, and offshoots.
 
Allen has rewritten the book from start to finish, tweaking his classic text with important perspectives on the new workplace, and adding material that will make the book fresh and relevant for years to come. This new edition of Getting Things Done will be welcomed not only by its hundreds of thousands of existing fans but also by a whole new generation eager to adopt its proven principles.',18,1,9780698161863,'2015-03-17');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Magic of Thinking Big','The timeless and practical advice in The Magic of Thinking Big clearly demonstrates how you can: Sell moreManage betterLead fearlesslyEarn moreEnjoy a happier, more fulfilling life With applicable and easy-to-implement insights, you’ll discover:Why believing you can succeed is essentialHow to quit making excusesThe means to overcoming fear and finding confidenceHow to develop and use creative thinking and dreamingWhy making (and getting) the most of your attitudes is criticalHow to think right towards othersThe best ways to make “action” a habitHow to find victory in defeatGoals for growth, andHow to think like a leader 
"Believe Big,” says Schwartz. “The size of your success is determined by the size of your belief. Think little goals and expect little achievements. Think big goals and win big success. Remember this, too! Big ideas and big plans are often easier -- certainly no more difficult - than small ideas and small plans."',18,1,9780698198586,'2014-12-02');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Infinite Game','From the New York Times bestselling author of Start With Why and Leaders Eat Last, a bold framework for leadership in today’s ever-changing world.
  
 How do we win a game that has no end? Finite games, like football or chess, have known players, fixed rules and a clear endpoint. The winners and losers are easily identified. Infinite games, games with no finish line, like business or politics, or life itself, have players who come and go. The rules of an infinite game are changeable while infinite games have no defined endpoint. There are no winners or losers—only ahead and behind. 
  
 The question is, how do we play to succeed in the game we’re in?
  
 In this revelatory new book, Simon Sinek offers a framework for leading with an infinite mindset. On one hand, none of us can resist the fleeting thrills of a promotion earned or a tournament won, yet these rewards fade quickly. In pursuit of a Just Cause, we will commit to a vision of a future world so appealing that we will build it week after week, month after month, year after year. Although we do not know the exact form this world will take, working toward it gives our work and our life meaning. 
  
 Leaders who embrace an infinite mindset build stronger, more innovative, more inspiring organizations. Ultimately, they are the ones who lead us into the future.',18,1,9780735213524,'2019-10-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Awaken the Giant Within: How to Take Immediate Control of Your Mental, Emotional, Physical and Financial','Wake up and take control of your life! From the bestselling author of Inner Strength, Unlimited Power, and MONEY Master the Game, Anthony Robbins, the nation''s leader in the science of peak performance, shows you his most effective strategies and techniques for mastering your emotions, your body, your relationships, your finances, and your life.

The acknowledged expert in the psychology of change, Anthony Robbins provides a step-by-step program teaching the fundamental lessons of self-mastery that will enable you to discover your true purpose, take control of your life, and harness the forces that shape your destiny.',25,1,9780743274333,'2007-11-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Way Of Shadows: Book 1 of the Night Angel','The razor-sharp first novel in the Night Angel trilogy, from international bestseller Brent Weeks The perfect killer has no friends. Only targets. For Durzo Blint, assassination is an art. And he is the city''s most accomplished artist, his talents required from alleyway to courtly boudoir.For Azoth, survival is precarious. Something you never take for granted. As a guild rat, he''s grown up in the slums, and learned the hard way to judge people quickly - and to take risks. Risks like apprenticing himself to Durzo Blint.But to be accepted, Azoth must turn his back on his old life and embrace a new identity and name. As Kylar Stern, he must learn to navigate the assassins'' world of dangerous politics and strange magics - and cultivate a flair for death.''Brent Weeks is so good it''s beginning to tick me off'' Peter V. Brett''Weeks has a style of immediacy and detail that pulls the reader relentlessly into the story. He doesn''t allow you to look away'' Robin Hobb''I was mesmerised from start to finish. Unforgettable characters, a plot that kept me guessing, non-stop action and the kind of in-depth storytelling that makes me admire a writers'' work'' Terry Brooks''Weeks has truly cemented his place among the great epic fantasy writers of our time'' British Fantasy Society Books by Brent WeeksNight Angel 
 The Way of Shadows
Shadow''s Edge
Beyond the Shadows
Perfect Shadow (novella)Lightbringer
The Black Prism
The Blinding Knife
The Broken Eye
The Blood Mirror
The Burning White',12,1,9780748112586,'2009-06-11');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Kingdom Of Strangers','Ibrahim Al-Brehm is a respectable husband a police inspector on Jeddah''s murder squad. But for the past year, he has been having an affair with a woman named Maria. One day though, she disappears.Terrified and with nowhere else to turn, Ibrahim goes to Katya, one of the few women on the force. As she ventures into Saudi Arabia''s underworld, she uncovers a murder which connects Maria to a human trafficking ring. Soon Ibrahim realises that the killer is closer to home than he had ever imagined.Kingdom of Strangers is a suspenseful story of murder and deception among Saudi Arabia''s shaded alleys, gleaming compounds and vast lonely deserts.',12,1,9780748129942,'2012-06-07');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('How to Understand Business Finance: Edition 2','The modern marketplace is increasingly unpredictable and there is an ever-greater need for non-financial managers to understand the financial and management accounting process.How to Understand Business Finance is part of the bestselling Creating Success series published in association with the Sunday Times, which has been translated into 25 languages with over 500, 000 copies sold. This book is written for those managing a business in a real market. It provides a quick and effective course in financial literacy, aimed at the pursuit of business growth, in the context of the journey of a business from initial set-up through its first year of trading.As well as learning how to understand balance sheets and profit and loss accounts, readers will also learn the principles of: market dynamics; budgeting and forecasting; fixed and variable costs; break-even analysis; the difference between profit and cash; financial ratios for measuring business performance; investment appraisal; stock market ratios; shareholder value; financial measures for improving business performance, and much more.How to Understand Business Finance helps you to understand double entry bookkeeping, supply chain management, the difference in American and British accounting terminology, financial ratios for measuring business performance, common acronyms, and the real cash flow implications of working capital.',26,1,9780749460211,'2010-04-03');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Killer Blonde','"Jaine Austen''s amused take on life, love, sex and LA will delight readers." --Carolyn Hart

A gal with a serious Ben & Jerry''s habit can''t afford to be too picky about employment opportunities. So when Beverly Hills socialite SueEllen Kingsley offers freelance writer Jaine Austen megabucks to ghostwrite a book of hostess tips, it''s time to sharpen the #2s.

But everything short circuits when Jaine finds SueEllen floating face down in her tub, fried by her own blow dryer. The primary suspect: Heidi, SueEllen''s stepdaughter, whose account of a mysterious blonde fleeing the scene is greeted with skepticism by Beverly Hills'' finest. Peroxided suspects abound, including a very private masseuse, a jealous nurse, a former game show hostess. . .even a closet blonde with a surprising secret. One of them is hiding a murderous heart behind pricey highlights, and Jaine''s out to expose the killer''s dark roots. Because blondes have enough fun without getting away with murder. . .

"Levine''s series gets stronger with each book. Her dialogue is realistic yet hilarious, and her vivid characters jump off the page." -Romantic Times

"The identity of the real killer comes as [a] smart surprise." --Publishers Weekly',27,1,9780758265111,'2008-09-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Antiques Roadkill: A Trash ''n'' Treasures Mystery','Determined to make a new start in her quaint hometown on the banks of the Mississippi, Brandy Borne never dreams she''ll become the prime suspect in a murder case. . . 

Moving back in with her eccentric, larger-than-life mother, Brandy Borne finds small-town Serenity anything but serene. It seems an unscrupulous antiques dealer has swindled Vivian out of the family''s heirlooms. But when he is found run over in a country lane, Brandy becomes Murder Suspect Number One--with her mother coming in a very close second. . . 

The list of other suspects is impressive--the victim''s business seems to have been based on bilking seniors out of their possessions. And when the Borne "girls" uncover a few very unsavory Serenity secrets, they become targets for a murderer whose favorite hobby seems to be collecting victims. 

Don''t miss Brandy Borne''s tips on antiques! 

"Cozy mystery fans will love this down-to-earth heroine with the wry sense of humor and a big heart." --Nancy Pickard 

"With its small-town setting and quirky characters, Antiques Roadkill is fun from start to finish. Dive in and enjoy."--Laurien Berenson',28,1,9780758272799,'2007-07-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Antiques Knock-Off','Brandy Borne is pretty sure her "charmingly eccentric" (a.k.a. "off her meds") mother, Vivian, didn''t kill that viperous mousy-haired busybody Connie Grimes. But there''s the small matter of her guilty plea. . ..While Mother blithely adapts to life behind bars by organizing a jailhouse theater troupe, seven-months-pregnant Brandy and her intrepid shih tzu, Sushi, trundle into a morass of fake antiques and faux collectibles. In the dog days of summer, they''d better not bark up the wrong tree--or a scheming killer just may put the bite on them!

Don''t Miss Brandy Borne''s Tips On Antiques!

"If you like laugh-out-loud mysteries, this one will make your day." --Romantic Times (4.5 stars)

Praise for Barbara Allan and the Trash ‘n'' Treasures Mystery Series. . .

"You''ll laugh out loud as Brandy and Vivian bumble their way through murder investigations in far-from-serene Serenity, Iowa." --Mystery Scene

"One of the funniest cozy series going." --Ellery Queen Mystery Magazine

"A sure-fire winner." --Publishers Weekly',28,1,9780758277695,'2012-04-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Working With You is Killing Me: Freeing Yourself from Emotional Traps at Work','"For anyone trapped in an energy-zapping relationship with a co-worker, boss, or subordinate, Crowley and Elster offer an exit strategy - a highly practical and easily implemented guide to making the situation workable." - Publishers Weekly 

If you find yourself frustrated with a colleague whose incompetence is driving you crazy, a boss who gets angry when you''re not a mind reader, or an employee who challenges your authority, chances are you''re caught in an emotional trap at your job. The solution is simple: Take control of your own response. 

In this pragmatic, insightful guide, psychotherapist Katherine Crowley and business consultant Kathi Elster teach you how to eliminate your workplace woes step by easy step. Through quizzes, case examples, and field-tested strategies, you''ll learn how to handle any bad work relationship. With your newfound emotional skills, you''ll be able to: 
Manage an ill-tempered boss before he or she explodesDetach from coworkers whose irritating habits ruin the dayDefend yourself from idea-pilfering rivalsGet out of the grip of toxic relationshipsProtect your work territory from "boundary busters"Break out of the limiting roles that box you inParent your difficult employees to get the results you want...and much, much more.',12,1,9780759515062,'2006-03-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('One Small Step Can Change Your Life: The Kaizen Way','Improve your life fearlessly with this essential guide to kaizen—the art of making great and lasting change through small, steady steps.

 Written by psychologist and kaizen expert Dr. Robert Maurer, One Small Step Can Change Your Life is the simple but potent guide to easing into new habits—and turning your life around. Learn how to overcome fear and procrastination with his 7 Small Steps—including how to Think Small Thoughts, Take Small Actions, and Solve Small Problems—to steadily build your confidence and make insurmountable-seeming goals suddenly feel doable.

 The science is irrefutable: Small steps circumvent our brains’ built-in resistance to new behaviors. Throughout this book, Dr. Maurer also shows how to visualize virtual change so that real change can come more easily. Why small rewards lead to big returns. And how great discoveries are made by paying attention to the little details most of us overlook. His simple regiment is your path to continuous improvement for anything from losing weight to quitting smoking, paying off debt, or conquering shyness and meeting new people. Rooted in the two-thousand-year-old wisdom of the Tao Te Ching—“The journey of a thousand miles begins with a single step”—here is the way to change your life without fear, without failure, and start on a new path of easy, continuous improvement.',29,1,9780761181347,'2014-04-22');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Chronicle of the Unhewn Throne: (The Emperor''s Blades, The Providence of Fire, The Last Mortal Bond)','This discounted ebundle of Chronicle of the Unhewn Throne includes: The Emperor''s Blades, The Providence of Fire, The Last Mortal Bond“An enchanting union of old and new.” —Pierce BrownThe emperor of Annur is dead, slain by enemies unknown. His daughter and two sons, scattered across the world, do what they must to stay alive and unmask the assassins. But each of them also has a life-path on which their father set them, destinies entangled with both ancient enemies and inscrutable gods.The Emperor’s Blades — Three siblings: Kaden, the heir to the Unhewn Throne, has spent eight years sequestered in a remote mountain monastery. An ocean away, Valyn endures the brutal training of the Kettral. At the heart of the empire, Adare hunts those who murdered her father.The Providence of Fire — Kaden infiltrates the Annurian capital, while Adare flees the Dawn Palace in search of allies to challenge the coup against her family. As armies prepare to clash, the threat of invasion compels the rival forces to unite. Unknown to Adare, Valyn has allied with the invading nomads.The Last Mortal Bond — The ancient csestriim are back to finish their purge of humanity; armies march against the capital; capricious gods walk the earth in human guise, but the imperial siblings at the heart of it all soon understand that there may be no reconciling their conflicting visions of the future.Chronicle of the Unhewn Throne
The Emperor''s Blades
The Providence of Fire
The Last Mortal BondOther books in the world of the Unhewn Throne
SkullswornAt the Publisher''s request, this title is being sold without Digital Rights Management Software (DRM) applied.',30,1,9780765396143,'2016-12-06');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Civil War: Volume 1','The landscape of the Marvel Universe is changing; and it''s time to choose: Whose side are you on? A conflict has been brewing; threatening to pit friend against friend; brother against brother - and all it will take is a single misstep to cost thousands their lives and ignite the fuse! As the war claims its first victims; no one is safe as teams; friendships and families begin to fall apart. The crossover that rewrites the rules; Civil War stars Spider-Man; the New Avengers; the Fantastic Four; the X-Men and the entirety of the Marvel pantheon! Collects Civil War (2006) #1-7.',31,1,9780785170242,'2011-01-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Marvel Universe Vs. The Punisher: Volume 1','COLLECTING: MARVEL UNIVERSE VS. THE PUNISHER #1-4',31,1,9780785179009,'2011-01-05');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Ultimate Spider-Man Vol. 11: Carnage','Collects Ultimate Spider-Man 60-65. One of the most ruthless villains in the history of the Marvel Universe, the fan-favorite Carnage, gets the Ultimate treatment! And though young Peter Parker has proven himself time and time again on the field of battle, can even he hope to defeat this heartless killing machine?',31,1,9780785180197,'2014-01-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Spider-Man: Anti-Venom','What''s Black, White, and Dead all over?!?! From the pages of last year''s best-selling New Ways to Die, Zeb Wells (Amazing Spider-Man, New Mutants) and Paulo Siqueira (Amazing Spider-Man, Ms. Marvel) bring you the story of Eddie Brock, the sallow symbiote known as Anti-Venom! With his life saved by Spider-Man, Eddie is cautiously walking the line between the darkness and light while trying to find his place in a world marked only by gray... and the absolute last person he needs to run into is the Punisher! Unfortunately, the Punisher remembers Eddie as a coldblooded killer, and that is just gonna hurt. Collects Dark Reign: Anti-Venom #1-3, Extra #2 (Anti-Venom story)',31,1,9780785182962,'2010-03-10');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Shadowbred: The Twilight War, Book 1','The Lady has spoken to me.
 
 It has already begun.

 Shadows move out of the shrinking desert, south to the rich and arrogant cities of Sembia.

 “Be brave, little man,” says the shadowman, and the boy thinks his voice is surprisingly soft. “Stay with your mother. This will be over soon.”
 
 The shadows swallow him and he is gone.
 
 On the edge of a war that will change the face of Faerûn, the world will find that not all shadows serve Shade.',32,1,9780786956890,'2010-04-21');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Rogues','NEW YORK TIMES BESTSELLER

A thrilling collection of twenty-one original stories by an all-star list of contributors—including a new A Game of Thrones story by George R. R. Martin!
  
If you’re a fan of fiction that is more than just black and white, this latest story collection from #1 New York Times bestselling author George R. R. Martin and award-winning editor Gardner Dozois is filled with subtle shades of gray. Twenty-one all-original stories, by an all-star list of contributors, will delight and astonish you in equal measure with their cunning twists and dazzling reversals. And George R. R. Martin himself offers a brand-new A Game of Thrones tale chronicling one of the biggest rogues in the entire history of Ice and Fire.
  
 Follow along with the likes of Gillian Flynn, Joe Abercrombie, Neil Gaiman, Patrick Rothfuss, Scott Lynch, Cherie Priest, Garth Nix, and Connie Willis, as well as other masters of literary sleight-of-hand, in this rogues gallery of stories that will plunder your heart—and yet leave you all the richer for it.
  
 Featuring all-new stories by
  
 Joe Abercrombie • Daniel Abraham • David W. Ball • Paul Cornell • Bradley Denton • Phyllis Eisenstein • Gillian Flynn • Neil Gaiman • Matthew Hughes • Joe R. Lansdale • Scott Lynch • Garth Nix • Cherie Priest • Patrick Rothfuss • Steven Saylor • Michael Swanwick • Lisa Tuttle • Carrie Vaughn • Walter Jon Williams • Connie Willis
  
 And an Introduction by George R. R. Martin!

Praise for Rogues
  
 “Not a single bad story in the bunch . . . The table of contents alone will make fans from all genre aisles salivate.”—Library Journal',22,1,9780804179607,'2014-06-17');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('On Tyranny: Twenty Lessons from the Twentieth Century','#1 New York Times Bestseller • A historian of fascism offers a guide for surviving and resisting America''s turn towards authoritarianism.

The Founding Fathers tried to protect us from the threat they knew, the tyranny that overcame ancient democracy. Today, our political order faces new threats, not unlike the totalitarianism of the twentieth century. We are no wiser than the Europeans who saw democracy yield to fascism, Nazism, or communism. Our one advantage is that we might learn from their experience.

On Tyranny is a call to arms and a guide to resistance, with invaluable ideas for how we can preserve our freedoms in the uncertain years to come.

"Mr. Snyder is a rising public intellectual unafraid to make bold connections between past and present." —The New York Times',33,1,9780804190121,'2017-02-28');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Essentials of Finance and Accounting for Nonfinancial Managers','Based on the bestselling AMA seminar, a nuts-and-bolts guide to the dollars-and-cents issues that drive your organization! As a department manager, the last thing you want to think about is numbers. But the truth is, that’s the only thing your executives and senior managers are thinking about so it’s crucial to understand key financial information like balance sheets, income statements, cash flow statements, budgets and forecasts, and annual reports. With over 40,000 copies sold, The Essentials of Finance and Accounting for Nonfinancial Managers has long provided readers with insight into the financial fundamentals. It demystifies the role accounting and finance play in a corporation, demonstrates how financial decisions reflect business goals, and shows how managers can connect corporate financial information directly to their own strategies and actions. Now revised to reflect new accounting and financial standards, the second edition includes: Strategies for getting your share of the budget • New case studies and practice sessions • An explanation of Sarbanes-Oxley and its relevance to nonfinancial managers • How to manage cash flow in tough times • Fraud detection tools • An expanded glossary including up-to-the-minute business concepts and terminology • And more',34,1,9780814416259,'2011-03-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Powerful Phrases for Dealing with Difficult People: Over 325 Ready-to-Use Words and Phrases for Working with Challenging Personalities','The key to a harmonious, highly effective work environment is not by ensuring you work among carbon-copies of yourself whose personalities never clash with one another or with you. That pipe dream could not ever happen, nor would it result in a successful team collaboration even if it could. Instead, most of us are going to work today with individuals who at times come across as incompetent, lazy, spotlight-hugging, whiny, or backstabbing. And then tomorrow we go to work with them again . . . and again . . . and again.Like it or not, the bulk of our waking hours are spent with people at work--people who can grate on our nerves. Therefore, learning to interact effectively with difficult employees, colleagues, and bosses is an absolute essential for our success. With Powerful Phrases for Dealing with Difficult People, anyone can learn how to confront head-on the difficult situations that can arise when dealing with these personalities, before they fester and spread. Helpful features inside this practical and easy-to-use book include:• Thirty common personality traits, behaviors, and workplace scenarios along with the phrases that work best with each • Nonverbal communication skills to back up your words • Sample dialogues that demonstrate how phrasing improves interactions • A five-step process for moving from conflict to resolution • “Why This Works” sections that provide detailed explanationsButton-pushing situations are going to come up today at work--and tomorrow too. Don’t let them rent space inside of you and turning everything to mold. Instead, choose to deploy simple phrases to regain control and resolve conflicts. When you do, you, your colleagues, and your company will be all the better for it!',34,1,9780814432990,'2013-10-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Management (The Brian Tracy Success Library)','Do you want to become invaluable to your company? Of course you do. The unparalleled key to achieving that notoriety is to learn how to boost your managerial skills and bring out the best in your people. And if that sounds simple, that’s because it is! Great managers are made, not born. And success expert Brian Tracy has written Management, a handy, easy-to-follow guide book to show how anyone can easily:• Set performance standards • Delegate productively • Define key result areas • Concentrate attention and resources on high-payoff activities and eliminate distractions • Hire and fire effectively Build a staff of peak performers • Hold meetings that work • Communicate with clarity • Negotiate successfully • Remove obstacles to performance• And moreFilled with practical, proven techniques and tools, this essential guide shows you how to bring out the best in your people--and be seen as an indispensable linchpin by the leaders of your organization.',34,1,9780814434208,'2014-05-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Marketing (The Brian Tracy Success Library)','Too often, businesses create a product or service and then focus their marketing efforts on trying to convince customers that they need it. But the key to successful marketing--and a successful business for that matter--is already knowing that what you are offering is what the public has been searching for! In Marketing, renowned business expert Brian Tracy has provided 21 powerful and proven ideas any business can use immediately to improve their strategic marketing results. You’ll discover how to:• Build your customer base • Set yourself apart from the competition • Use market research and focus groups to fuel better decisions • Fulfill a basic emotional need for buyers • Determine the correct price point for your offerings • Make the most of your distribution channels • Give customers a reason to switch from your competitors • And much more!Complete with time-tested marketing strategies, as well as Tracy’s trademark wisdom, this practical pocket guide shows you how to overcome the competition, increase sales and profitability, and dominate your market niche.',34,1,9780814434222,'2014-06-11');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Business Strategy (The Brian Tracy Success Library)','How will you determine if your company has succeeded if you can’t base its performance on a well-defined business strategy? A strategic plan, established at your venture’s birth, helps crystalize the future of the organization--mapping a clear path from where the company stands today to where you wish it to be.Renowned business author Brian Tracy has provided a simple path to creating the specific business strategy needed for your company’s success. Readers of Business Strategy will discover how to:• Ask the five key questions vital to any strategic plan• Determine a corporate mission that lifts and inspires people• Define themselves in relation to their competition• Anticipate crises• Reposition their business with new products, services, and technology• And moreIncorporating wide-ranging examples--from Alexander the Great to IBM to General Electric--this concise, practical guide gives readers proven ideas for increasing their company’s bottom line and maximizing their strengths and opportunities. The path to success starts at the beginning!',34,1,9780814436288,'2015-04-29');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Personal Success (The Brian Tracy Success Library)','Where does that “winning edge” you’ve heard so much about come from? How do some people seem to find success simply from waking up and getting out of bed? World-renowned performance expert Brian Tracy has spent decades studying uncommonly high achievers. Instead of finding commonalities such as Ivy League educations, gold-star connections, and a dash of blind luck, Tracy discovered that the keys to their success were more often small adjustments in outlook and behavior--simple things that anyone can do!In Personal Success, Tracy lays out a simple, clear plan for anyone to be able to unlock their potential and find the success they previously thought was unattainable for them. Readers will learn to:• Change your mindset to attract opportunity• Banish self-limited beliefs• Build your self-confidence• Practice courage--because all successful people are risk takers• Sharpen your natural intuition• Continually upgrade your skills• And morePacked with simple but game-changing techniques, Personal Success is the answer you’ve been searching for to gain that winning edge and turn your dreams into realities.',34,1,9780814437049,'2016-01-06');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Mini Habits: Smaller Habits, Bigger Results','Discover the Life-Changing Strategy of This Worldwide Bestseller in 17 Languages!
UPDATED: Includes the best habit tracking apps of 2017.Lasting Change For Early Quitters, Burnouts, The Unmotivated, And Everyone Else Too 

When I decided to start exercising consistently 10 years ago, this is what actually happened: I tried "getting motivated." It worked sometimes.I tried setting audacious big goals. I almost always failed them.I tried to make changes last. They didn''t.Like most people who try to change and fail, I assumed that I was the problem.

Then one afternoon--after another failed attempt to get motivated to exercise--I (accidentally) started my first mini habit. I initially committed to do one push-up, and it turned into a full workout. I was shocked. This "stupid idea" wasn''t supposed to work. I was shocked again when my success with this strategy continued for months (and to this day).

I had to consider that maybe I wasn''t the problem in those 10 years of mediocre results. Maybe it was my prior strategies that were ineffective, despite being oft-repeated as "the way to change" in countless books and blogs.

My suspicions were correct.

Is There A Scientific Explanation For This?
As I sought understanding, I found a plethora of scientific studies that had answers, with nobody to interpret them correctly. Based on the science--which you''ll find peppered throughout Mini Habits--we''ve been doing it all wrong.

You can succeed without the guilt, intimidation, and repeated failure associated with such strategies as "getting motivated," New Year''s Resolutions, or even "just doing it." In fact, you need to stop using those strategies if they aren''t giving you great results.

Most popular strategies don''t work well because they require you to fight against your subconscious brain (a fight not easily won). It''s only when you start playing by your brain''s rules and taking your human limitations seriously--as mini habits show you how to do--that you can achieve lasting change.

What''s A Mini Habit?
A mini habit is a very small positive behavior that you force yourself to do every day; its "too small to fail" nature makes it weightless, deceptively powerful, and a superior habit-building strategy. You will have no choice but to believe in yourself when you''re always moving forward.

The barrier to the first step is so low that even depressed or "stuck" people can find early success and begin to reverse their lives right away. And if you think one push-up a day is too small to matter, I''ve got one heck of a story for you!

Aim For The First Step
They say when you aim for the moon, you''ll land among the stars. Well, that doesn''t make sense, as the moon is closer than the stars. I digress. 

The message is that you should aim very high and even if you fall short, you''ll still get somewhere. I''ve found the opposite to be true in regards to productivity and healthy behaviors. When you aim for the moon, you won''t do anything because it''s too far away. But when you aim for the step in front of you, you might keep going and reach the moon.

I''ve used the Mini Habits strategy to get into the best shape of my life, read 10x more books, and write 4x as many words. It started from requiring one push-up from myself every day. How ridiculous is that? Not so ridiculous when you consider the science of the brain, habits, and willpower.

The Mini Habits system works because it''s how our brains are designed to change.

Note: This book isn''t for eliminating bad habits (some principles could be useful for breaking habits). Mini Habits is a strategy to create permanent healthy habits in: exercise, writing, reading, thinking positively, meditating, drinking water, eating healthy foods, etc.

Lasting change won''t happen until you take that first step into a strategy that works. Give Mini Habits a try. You won''t look back.',35,1,9780996435420,'2013-12-22');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Homecoming (A Chloe Fine Psychological Suspense Mystery—Book 5)','“A masterpiece of thriller and mystery. Blake Pierce did a magnificent job developing characters with a psychological side so well described that we feel inside their minds, follow their fears and cheer for their success. Full of twists, this book will keep you awake until the turn of the last page.”--Books and Movie Reviews, Roberto Mattos (re Once Gone)
HOMECOMING (A Chloe Fine Mystery) is book #5 in a new psychological suspense series by bestselling author Blake Pierce, whose #1 bestseller Once Gone (Book #1) (a free download) has over 1,000 five-star reviews.  When two husbands, best friends, turn up dead in a wealthy suburban town, FBI VICAP Special Agent Chloe Fine, 27, is called in to unmask the lies in this small town and to find the killer.  Chloe will have to penetrate this town’s perfect façade, to get past its public appearances to understand the truth of who these men were, and who may have wanted them dead. And in a town that thrives on its exclusivity, that won’t be easy to do. What secrets were these husbands hiding?
An emotionally wrought psychological suspense with layered characters, small-town ambiance and heart-pounding suspense, HOMECOMING is book #5 in a riveting new series that will leave you turning pages late into the night.
Book #6 in the Chloe Fine series is now available for pre-order!',36,1,9781094310442,'2019-10-29');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Ultimate Secrets of Total Self-Confidence','This is no way to live! Like so many others, you can now enjoy your own personal success story by mastering the principles of total self-confidence. Here Dr. Robert Anthony reveals the secrets he has taught in seminars and workshops that have changed thousands of lives. Executive businessmen, star athletes, and celebrities know how total self-confidence can make you soar. And now you can, too. YOU WILL LEARN:How to tap into your creative imagination—and use it to get what you wantHow to clear your mind of fear, worry, guilt, and reverse failureThe best ways to communicate and the art of small talkThe simplest ways to get perspective and set goals The joys and benefits of being differentLet Dr. Anthony guide you on this step-by-step, day-by-day path toward total self-confidence—in your career, family, love life, finances, and mental and physical health—and achieve a brand-new, totally positive and confident outlook.',18,1,9781101042892,'1986-11-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Death Masks','The Dresden Files have taken the genre of paranormal mystery to a new level of action, excitement, and hard-hitting magical muscle. Now, in Death Masks, Jim Butcher’s smart-guy private eye may have taken on more than he can handle...

Harry Dresden, Chicago’s only practicing professional wizard, should be happy that business is pretty good for a change. But he also knows that whenever things are going good, the only way left for them to go is bad. Way bad. Such as:

• A duel with the lethal champion of the Red Court, who must kill Harry to end the war between vampires and wizards...
• Professional hit men using Harry for target practice...
• The missing Shroud of Turin—and the possible involvement of Chicago''s most feared mob boss...
• A handless and headless corpse the Chicago police need identified...

Not to mention the return of Harry’s ex-girlfriend Susan, who’s still struggling with her semi-vampiric nature. And who seems to have a new man in her life. Some days, it just doesn’t pay to get out of bed. No matter how much you’re charging.',37,1,9781101128459,'2003-08-05');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Her Royal Spyness','THE FIRST ROYAL SPYNESS MYSTERY!

The New York Times bestselling author of the Molly Murphy and Constable Evan Evans mysteries turns her attentions to “a feisty new heroine to delight a legion of Anglophile readers.”*

London, 1932. Lady Victoria Georgiana Charlotte Eugenie, 34th in line for the English throne, is flat broke. She''s bolted Scotland, her greedy brother, and her fish-faced betrothed. London is a place where she''ll experience freedom, learn life lessons aplenty, do a bit of spying for HRH—oh, and find a dead Frenchman in her tub. Now her new job is to clear her long family name...',18,1,9781101207369,'2008-07-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Neatest Little Guide to Stock Market Investing: Fifth Edition','The essential stock market guide for beginners, updated with timely strategies for investing your money. The perfect gift for anyone hoping to learn the basics of investing. 

Now in its fifth edition, The Neatest Little Guide to Stock Market Investing has established itself as a clear, concise, and highly effective approach to stocks and investment strategy. Rooted in the principles that made it invaluable from the start, this completely revised and updated edition of The Neatest Little Guide to Stock Market Investing shares a wealth of information, including: 

•What has changed and what remains timeless as the economy recovers from the subprime crash 

•All-new insights from deep historical research showing which measurements best identify winning stocks 

•A rock-solid value averaging plan that grows 3 percent per quarter, regardless of the economic climate 

•An exclusive conversation with legendary Legg Mason portfolio manager Bill Miller, revealing what he learned from the crash and recovery 

•Thoroughly updated resources emphasizing online tools, the latest stock screeners, and analytical sites that best navigated recent trends 

Accessible and intelligent, The Neatest Little Guide to Stock Market Investing is what every investor, new or seasoned, needs to keep pace in the current market. This book is a must read for anyone looking to make money in the stock market this year!',18,1,9781101615478,'2012-12-24');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('W is for Wasted: A Kinsey Millhone Novel','Private investigator Kinsey Millhone finds shocking connections between two seemingly unrelated deaths in this #1 New York Times bestselling mystery in the Alphabet series.

The first victim is a local PI of suspect reputation, gunned down near the beach at Santa Teresa. The second is a John Doe found on the beach six weeks later with a slip of paper with private detective Kinsey Millhone’s name and number in his pocket.

 Two seemingly unrelated deaths: one man murdered, the other apparently dead of natural causes.

But as Kinsey digs deeper into the mystery of the John Doe, some very strange links begin to emerge. Not just between the two victims, but also to Kinsey’s past. And before long Kinsey, through no fault of her own, is thoroughly compromised...',18,1,9781101636459,'2013-09-10');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('We Should All Be Feminists','The highly acclaimed, provocative New York Times bestseller from the award-winning author of Americanah, “one of the world’s great contemporary writers” (Barack Obama).

In this personal, eloquently-argued essay—adapted from the much-admired TEDx talk of the same name—Chimamanda Ngozi Adichie offers readers a unique definition of feminism for the twenty-first century, one rooted in inclusion and awareness. Drawing extensively on her own experiences and her deep understanding of the often masked realities of sexual politics, here is one remarkable author’s exploration of what it means to be a woman now—and an of-the-moment rallying cry for why we should all be feminists.

An eBook short.',38,1,9781101872932,'2014-07-29');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Dark Matter: A Novel','A mindbending, relentlessly surprising thriller from the author of the bestselling Wayward Pines trilogy.

“Are you happy with your life?” 
 
Those are the last words Jason Dessen hears before the masked abductor knocks him unconscious. 
 
Before he awakens to find himself strapped to a gurney, surrounded by strangers in hazmat suits. 
 
Before a man Jason’s never met smiles down at him and says, “Welcome back, my friend.”  
 
In this world he’s woken up to, Jason’s life is not the one he knows. His wife is not his wife. His son was never born. And Jason is not an ordinary college physics professor, but a celebrated genius who has achieved something remarkable. Something impossible.
 
Is it this world or the other that’s the dream? And even if the home he remembers is real, how can Jason possibly make it back to the family he loves? The answers lie in a journey more wondrous and horrifying than anything he could’ve imagined—one that will force him to confront the darkest parts of himself even as he battles a terrifying, seemingly unbeatable foe.
 
Dark Matter is a brilliantly plotted tale that is at once sweeping and intimate, mind-bendingly strange and profoundly human—a relentlessly surprising science-fiction thriller about choices, paths not taken, and how far we’ll go to claim the lives we dream of.',9,1,9781101904237,'2016-07-26');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Edgedancer: From the Stormlight Archive','From #1 New York Times bestselling author Brandon Sanderson, a special gift edition of Edgedancer, a short novel of the Stormlight Archive (previously published in Arcanum Unbounded).Three years ago, Lift asked a goddess to stop her from growing older--a wish she believed was granted. Now, in Edgedancer, the barely teenage nascent Knight Radiant finds that time stands still for no one. Although the young Azish emperor granted her safe haven from an executioner she knows only as Darkness, court life is suffocating the free-spirited Lift, who can''t help heading to Yeddaw when she hears the relentless Darkness is there hunting people like her with budding powers. The downtrodden in Yeddaw have no champion, and Lift knows she must seize this awesome responsibility.
Other Tor books by Brandon Sanderson The Cosmere
 
 The Stormlight Archive
 The Way of Kings
 Words of Radiance
 Edgedancer (Novella)
 Oathbringer
 
 The Mistborn trilogy
 Mistborn: The Final Empire
 The Well of Ascension
 The Hero of Ages
 
 Mistborn: The Wax and Wayne series
 Alloy of Law
 Shadows of Self
 Bands of Mourning Collection
 Arcanum Unbounded Other Cosmere novels
 Elantris
 Warbreaker The Alcatraz vs. the Evil Librarians series
 Alcatraz vs. the Evil Librarians
 The Scrivener''s Bones
 The Knights of Crystallia
 The Shattered Lens
 The Dark Talent The Rithmatist series
 The Rithmatist Other books by Brandon Sanderson

 The Reckoners
 Steelheart
 Firefight
 CalamityAt the Publisher''s request, this title is being sold without Digital Rights Management Software (DRM) applied.',39,1,9781250166609,'2017-10-17');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Permanent Record','NEW YORK TIMES BESTSELLER

Edward Snowden, the man who risked everything to expose the US government’s system of mass surveillance, reveals for the first time the story of his life, including how he helped to build that system and what motivated him to try to bring it down.

In 2013, twenty-nine-year-old Edward Snowden shocked the world when he broke with the American intelligence establishment and revealed that the United States government was secretly pursuing the means to collect every single phone call, text message, and email. The result would be an unprecedented system of mass surveillance with the ability to pry into the private lives of every person on earth. Six years later, Snowden reveals for the very first time how he helped to build this system and why he was moved to expose it.Spanning the bucolic Beltway suburbs of his childhood and the clandestine CIA and NSA postings of his adulthood, Permanent Record is the extraordinary account of a bright young man who grew up online—a man who became a spy, a whistleblower, and, in exile, the Internet’s conscience. Written with wit, grace, passion, and an unflinching candor, Permanent Record is a crucial memoir of our digital age and destined to be a classic.',40,1,9781250237248,'2019-09-17');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('In Dark Company: A Kate Burkholder Short Story','From the New York Times bestselling author of DOWN A DARK ROAD comes Linda Castillo''s IN DARK COMPANY: a short story about an injured young woman with amnesia who seeks Chief of Police Kate Burkholder’s help to remember her identity—and her attacker. It’s the middle of the night in Painters Mill, and Chief of Police Kate Burkholder is called to a scene where a mysterious young woman, battered and terrified, has sought shelter at an Amish farmhouse. She can’t remember her name or where she’s from, but she knows one thing: someone was trying to kill her. Kate suspects that “Jane Doe” remembers more than she’s letting on, but when Jane is attacked again on Kate’s watch, Kate resolves to find the truth. As Jane’s memories start flooding back and Kate dives deeper into her murky past, they must race to discover what Jane was running from—and who is still pursuing her.',41,1,9781250314161,'2018-05-29');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Tintinalli''s Emergency Medicine: A Comprehensive Study Guide, 9th edition: Edition 9','Publisher''s Note: Products purchased from Third Party sellers are not guaranteed by the publisher for quality, authenticity, or access to any online entitlements included with the product.
 
 
 The long awaited new edition of the world''s most widely used and highly regarded textbook and reference of emergency medicine -- Endorsed by the American College of Emergency Physicians
 
 Unquestionably the leading text in emergency medicine, Tintinalli’s Emergency Medicine is a true must-have resource for everyone in emergency medicine --- from residents to practicing physicians. The Ninth Edition of provides the depth and breadth of coverage that reflects the complexity and expertise needed to practice emergency medicine successfully in today’s fast –paced environments. It is an important contemporary clinical emergency care resource for physicians, nurse practitioners, and physician assistants who practice emergency medicine and for emergency medicine and pediatric emergency medicine fellows. It remains the preferred study guide for in-training and board examinations and recertification.
 
 This comprehensive text covers everything from prehospital care, disaster preparedness, and basic resuscitative techniques to all the major diseases requiring emergency treatment in adults and children, such as pulmonary emergencies, renal and genitourinary disorders, and hemophilia.
 
 • Full-color design with more tables than ever to succinctly present key information
 • Extensive updates to all sections, incorporating the latest guidelines, evidence-based protocols, and relevant research
 • Online access to more than 50 videos, covering a wide range of procedural and diagnostic topics and focusing on the latest ultrasound-guided techniques – most NEW to this edition
 • NEW Chief Complaint infographics for the Thirty Most Common Presenting Symptoms in the Emergency Department. These printable, downloadable guides feature algorithms, mnemonics, and succinct text to assist differential diagnosis.',4,1,9781260019940,'2019-10-22');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Avengers Vol. 1: Avengers World','The greatest heroes in comics together on one unbeatable team! The Avengers "go large," expanding their roster and their sphere of influence to a global and even interplanetary level. When Captain America puts out his call - who will answer? Big threats, big ideas, big idealism - these are the Avengers NOW! AVENGERS VOL. 1: AVENGERS WORLD includes a code for a free digital copy on the Marvel Comics app (for iPhone?, iPad?, iPad Touch? & Android devices) and Marvel Digital Comics Shop. Additionally, this collection also features special augmented reality content available exclusive through the Marvel AR app - including cover recaps, behind the scenes features and more that add value to your reading experience at no additional cost.

COLLECTING: Avengers 1-6',31,1,9781302013622,'2013-04-30');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Marvel Universe: The End','Collects Marvel Universe: The End #1-6. Jim Starlin is back and this time he destroys everything! When the immortal Egyptian pharoah Akhenaten gains cosmic powers, his first act is to annihilate the Avengers and the X-Men! The universe is endangered, and Thanos and Dr. Doom may be the world''s best chance at survival! Featuring lead roles for Thor, Zeus, Captain Marvel, Dr. Strange, Namor and the Silver Surfer! And Thanos, more powerful than you''ve ever seen him!',31,1,9781302368173,'2014-06-11');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Deadpool Kills the Marvel Universe','Collects Deadpool Kills the Marvel Universe #1-4. What if everything you thought was funny about Deadpool was actually just disturbing? What if he decided to kill everyone and everything that makes up the Marvel Universe? What if he actually pulled it off? Would that be FUN for you? The Merc with a Mouth takes a turn for the twisted in a horror comic like no other!',31,1,9781302368807,'2014-05-21');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Spider-Man: Kraven''s Last Hunt','Collects Web of Spider-Man #31-32, Amazing Spider-Man #293-294, and Spectacular Spider-Man #131-132.',31,1,9781302377366,'2014-12-10');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Punisher Vol. 1: Black and White','Collects The Punisher #1-6.',31,1,9781302393021,'2014-08-20');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Captain Marvel Vol. 1: Higher, Further, Faster, More','Collects Captain Marvel #1-6.',31,1,9781302401580,'2014-10-08');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Spider-Verse: Volume 1','Someone is working their way through the multiverse, leaving a trail of dead spiders in their wake! As the Superior Spider-Man faces this foe in the future, MC2''s Spider-Girl finds herself under attack! From 1602 to the era of Noir, from a spider-powered Gwen Stacy to the world-famous Spider-Ham, spider-themed heroes everywhere, in every world, begin to falter and fall. How can "our" Spider-Man possibly hope to survive against this unstoppable interdimensional onslaught? Guest-starring every Spider-Man ever, and then some! Spider-UK, Sp//dr, Scarlet Spiders, Spider-Woman, Spider-Man 2099...can any of them survive the arrival of Morlun? Collects Amazing Spider-Man (2014) #7-15, Superior Spider-Man (2013) #32-33, Free Comic Book Day 2014 (Guardians of the Galaxy) #1 (5 page Spider-Man story), Spider-Verse #1-2, Spider-Verse Team-Up #1-3, Scarlet Spiders #1-3, Spider-Woman (2014) #1-4, Spider-Man 2099 (2014) #6-8.',31,1,9781302480042,'2015-04-29');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('All-New Wolverine Vol. 1: The Four Sisters','Now SHE''S the best there is! X-23 was created to be a weapon and, for a time, that''s all she was. But with the help of her mentor, Logan - the original Wolverine -she escaped that dark past. Now the man she knew has fallen, but Laura will honor his memory as the All-New Wolverine. But with the famous cowl comes a world of misery and mystery...like the devastating secret of the Four Sisters. Uncovering it will involve new friends Dr. Strange and the Wasp, and lethal new enemies like the Taskmaster! But after recent events, Laura is growing used to doing everything in her power to save those around her from forces hell-bent on destruction. If anyone can stop them, it''s Laura. After all, it''s what Wolverine does. COLLECTING: ALL-NEW WOLVERINE 1-6.',31,1,9781302486112,'2016-05-11');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Mighty Thor Vol. 2: Lords Of Midgard','Collects Mighty Thor (2015) #6-11.  The legend continues with Thors new and old! Loki spins a special ages-old tale of a young Odinson in action against a hulking great enemy. You wouldnt like this Viking when hes angry! But what incredible impact will this yarn from the past have on the present? Prepare for corporate espionage, Marvel-style, as some of the worlds most powerful and evil conglomerates go to war  with Thor caught in the middle! But if Roxxon and the rest arent enough trouble, Jane Foster must contend with a new enemy: S.H.I.E.L.D.! Whose side will Agent Roz Solomon be on? Worse still, somehow millions of lives will depend on the God of Thunder saving Roxxons evil executive, Dario Agger! All this andthe Exterminatrix and the Silver Samurai?!',31,1,9781302494605,'2016-11-30');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Venomized','Collects Venomized #1-5. The story that began in VENOMVERSE reaches its epic conclusion! The Poisons, a species that hungers for super-powered symbiotes and their hosts, have picked their next target: the Marvel Universe itself! Their first objective? Put every superhuman in a Klyntar symbiote  and then consume them! And with Venom and the X-Men still missing after the events of Poison-X, Earth stands defenseless! By the time they make it back home, Venom and the X-Men find dozens of heroes and villains unwillingly bonded with symbiotes. And when the Poisons consume one of their strongest allies, the champions of Earth must rally  and stand against one of their own! But what do the Poisons have planned for Cletus Kasady, A.K.A. Carnage? And can anything in the galaxy stand in the way ofPoison Thanos?!',31,1,9781302505295,'2018-07-25');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Immortal Hulk Vol. 1: Or Is He Both?','Collecting Immortal Hulk #1-5 and material from Avengers (2016) #684 by Jim Zub and Mark Waid. Horror has a name. Youd never notice the man. He doesnt like to be noticed. Hes quiet. Calm. If someone were to shoot him in the headall hed do is die. Until night falls  and someone else gets up again. The mans name is Banner. The horror is the Immortal Hulk! And trouble has a way of following them both. As reporter Jackie McGee tries to put together the pieces, Banner treads a lonely path from town to town, finding murder, mystery and tragedy as he goes. And what Banner finds, the Hulk smashes! Elsewhere, the hero called Sasquatch cant help but feel involved. In many ways, hes Banners equal  and his opposite. Sasquatch is about to risk his life by looking for the man  and finding the monster!',31,1,9781302507169,'2018-11-21');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Batman and Robin Vol. 1: Batman Reborn','Batman and Robin hit the streets with a bang in their new flying Batmobile to face an assemblage of villains called the Circus of Strange, and investigate the abduction of a child by the mysterious Domino Killer. But can this new Dynamic Duo find a way to work together? Find out in this new Deluxe hardcover collecting the first six issues of the hit series!',42,1,9781401235741,'2011-04-05');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Batman: Year One','A NEW   YORK TIMES Bestseller!
   
   A new edition of one of the most important and critically acclaimed Batman   adventures ever, written by Frank Miller, author of THE DARK KNIGHT   RETURNS!
   
   In 1986, Frank Miller and David Mazzucchelli produced   this groundbreaking reinterpretation of the origin of Batman--who he is and   how he came to be.
   
   Written shortly after THE DARK KNIGHT RETURNS, Miller''s dystopian fable of   Batman''s final days, YEAR ONE set the stage for a new vision of a legendary   character.
   
   This edition includes the complete graphic novel, a new introduction by   writer Frank Miller and a new illustrated afterword by artist David   Mazzucchelli. Completing this collection are over 40 pages of   never-before-seen developmental material such as character and layout   sketches, sample script pages, sketches and more that provide a glimpse into   the making of this contemporary classic.
   
   This volume collects BATMAN #404-407.',42,1,9781401235888,'2007-01-10');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Green Lantern: Secret Origin','Before he became the Green Lantern...before he unwittingly brought about the downfall of the Green Lantern Corps...before his rebirth as the universe''s most powerful protector...Hal Jordan of Earth was just a washed-up test pilot with no way to fly...until the dying alien Abin Sur granted him his power ring, the most powerful weapon in the universe--and his entry into a reality he could never have imagined. Hal Jordan''s metamorphosis from cocky test pilot to the role of the intergalactic guardian Green Lantern makes its way to the big screen in June 2011 from Warner Bros. Pictures, directed by Martin Campbell(CASINO ROYALE) and starring Ryan Reynolds and Blake Lively.  In preparation for his roll as Hal Jordan in "Green Lantern", Ryan Reynolds, who also contributes the introduction to this new edition, has pointed to Geoff Johns'' GREEN LANTERN: SECRET ORIGIN as "his bible" for shaping his portrayal of Hal Jordan:  "Green Lantern encompasses a seemingly limitless supply of adventure."  This new edition includes several preview pages from Green Lantern: Rebirth and Green Lantern: The Sinestro Corps War. Collects issues #29-35',42,1,9781401236410,'2011-04-12');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Joker','"You will be blown away."-AIN''T IT COOL NEWS Brian Azzarello brings to THE JOKER all the visceral intensity and criminal insight that has made his Vertigo graphic novel series 100 BULLETS one of the most critically acclaimed and award-winning series of all time. This original graphic novel tells the story of one very dark night in Gotham City. The Joker has been mysteriously released from Arkham Asylum, and he''s none too happy about what''s happened to his Gotham City rackets while he''s been "away." What follows is a harrowing night of revenge, murder and manic crime as only The Joker can deliver it, as he brutally takes back his stolen assets from The Penguin, The Riddler, Two-Face, Killer Croc and, of course, The Batman, and heaven help them all. Told through the eyes of his loyal (but naive) henchman Jonny Frost, JOKER is a true noir crime novel: a harrowing journey into a city of rain-soaked streets, dirty sheets and nothing but bad choices.',42,1,9781401236632,'2008-11-04');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Batman: Earth One','#1 NEW   YORK TIMES Bestseller!
   
   Batman is not a hero.
    
   He is just a man.
    
   Fallible, vulnerable and angry.
    
   In a Gotham City where friend and foe are indistinguishable, Bruce Wayne''s   path toward becoming the Dark Knight is riddled with more obstacles than ever   before. Focused on punishing his parents’ true killers, and the corrupt   police that allowed the criminals to go free, Bruce Wayne''s thirst for   vengeance fuels his mad crusade and no one, not even Alfred, can stop   him.
   
   In the tradition of the #1 NEW YORK TIMES best-selling SUPERMAN: EARTH ONE,   writer Geoff Johns and artist Gary Frank re-imagine a new mythology for the   Dark Knight, where the familiar is no longer the expected in this   long-awaited original graphic novel from DC Comics.',42,1,9781401239565,'2012-07-10');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Batman: The Man Who Laughs','Witness Batman''s first encounter with The Joker in this volume collecting the graphic novel BATMAN: THE MAN WHO LAUGHS, by Ed Brubaker and Doug Mahnke! This collection also includes DETECTIVE COMICS #784-786, a murder mystery tale guest-starring Green Lantern Alan Scott.',42,1,9781401242299,'2015-04-07');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Batman: Arkham Unhinged Vol. 1','In these stories originally available only online and tying into the bestselling videogame BATMAN: ARKHAM CITY, Dr. Hugo Strange has gained control of Arkham Asylum and is determined to keep the city''s criminal element behind bars. But with Catwoman and Two-Face still on the loose, Strange will go to any lengths to capture them - even if it means battling Batman along the way.',42,1,9781401244330,'2013-08-13');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Young Justice Vol. 1','Don''t call them sidekicks! The Justice League needs a covert team that could operate on the sly, so who better than experienced crime fighters Robin, Kid Flash and Aqualad? Together with Superboy, recently rescued from the top-secret Project Cadmus, and the crush-worthy shape-shifting alien Miss Martian, these teens are ready to stop being sidekicks and start taking down their own villainsãlike League of Shadows and the Jokerãall on their own. But Superboy may have a secret mission of his own to complete ... destroying Superman!  Based on the hit Cartoon Network series!  Collects issues #0-6.',42,1,9781401244378,'2012-01-17');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Batman Vol. 4: Zero Year-Secret City (The New 52)','In this first volume of the critically acclaimed ZERO YEAR storyline, the #1 New York Times bestselling creative team of Scott Snyder and Greg Capullo present an astonishing new vision of the Dark Knight''s origin—and his first encounters with the Riddler, the Red Hood, and others!

Before the era of superheroes began—before the Batman spread his wings to protect the innocent and punish evil—Gotham City''s prodigal son, Bruce Wayne, had been missing for years. But this was exactly the cover of darkness Bruce needed. Patrolling Gotham''s streets, in a series of disguises, he began a career as a faceless vigilante. 

Collects BATMAN issues #21-#24.',42,1,9781401252090,'2014-05-13');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Forever Evil','The Justice League is DEAD! And the villains shall INHERIT the Earth! In a flash of light, the world''s most powerful heroes vanish as the Crime Syndicate arrives from Earth-3! As this evil version of the Justice League takes over the DC Universe, no one stands in the way of them and complete domination ... no one except for Lex Luthor.  By New York Times #1 best-selling creators Geoff Johns and David Finch, FOREVER EVIL is the first universe-wide crossover of The New 52. Collects FOREVER EVIL #1-7.',42,1,9781401253523,'2014-09-09');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Batman vs. Superman: The Greatest Battles','THE MAN OF STEEL AGAINST THE DARK KNIGHT!
Superman and Batman are usually allies, but when they do have to go toe-to-toe, it’s the ultimate battle of brains versus brawn! Can an ordinary man take down an opponent with the power of a god? Can even superpowers prevail against a tactical genius who is never less than ten steps ahead? 
From all-star comic talents Frank Miller, Geoff Johns, Jim Lee, Jeph Loeb, Scott Snyder, Greg Capullo and more, these stories tackle the oldest fan debate in comics: Who would win—Superman or Batman? Collects stories from JUSTICE LEAGUE #2, BATMAN #612, SUPERMAN/BATMAN #78, BATMAN #35-36, BATMAN: THE DARK NIGHT RETURNS #4 and MAN OF STEEL #4.',42,1,9781401266066,'2015-12-08');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Injustice: Gods Among Us Year One - The Complete Collection: Issues 1-12','Inspired by the video game phenomenon, INJUSTICE: GODS AMONG US YEAR ONE-THE COMPLETE EDITION collects the initial year of the best-selling series in its entirety for the first time! Superman is Earth''s greatest hero. But when the Man of Steel can''t protect the thing he holds most dear, he decides to stop trying to save the world-and start ruling it. Now, the Last Son of Krypton is enforcing peace on Earth by any means necessary. Only one man stands between Superman and absolute power: Batman. And the Dark Knight will use any method at his disposal to stop his former friend from reshaping the world in his shattered image. Written by Tom Taylor (EARTH 2) with art by Jheremy Raapack (RESIDENT EVIL), Mike S. Miller (A Game of Thrones) and more, this thrilling graphic novel collects INJUSTICE: GODS AMONG US digital chapters 1-36 and in single magazine form as INJUSTICE: GODS AMONG US 1-12 and INJUSTICE: GODS AMONG US ANNUAL 1.',42,1,9781401267452,'2016-03-08');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Batman: Arkham Knight Vol. 3','The Joker is dead. Arkham City is no more. But as Batman has learned, evil is endless. And his new enemy, the mysterious, murderous Arkham Knight, is here to see the Dark Knight fall forever. And he is not alone. The crazed criminal called the Calendar Man is out to make each day BatmanÕs last. The brutal killer known as Bane wants to prove himself a more powerful warrior than any Knight. And in the shadows lurks the Scarecrow, whose sinister plans for Gotham City and its guardians are the most frightening of all. Defeating the Arkham Knight and his army will take every ounce of BatmanÕs skills and strength. Because under his rivalÕs helmet is a familiar face, one that should strike terror even into the heart of the Dark Knight himselfÉ Writers Peter J. Tomasi (BATMAN AND ROBIN) and Tim Seeley (GRAYSON) and an arsenal of top artists including Viktor Bogdanovic (REALITY CHECK), Ig Guara (BLUE BEETLE), Julio Ferreira (TEEN TITANS) and Richard Friend (BATMAN: THE DARK KNIGHT) proudly present BATMAN: ARKHAM KNIGHT VOL. 3, the shocking finale of the official prequel to Rocksteady StudiosÕ smash-hit Arkham trilogy! Collects BATMAN: ARKHAM KNIGHT #9-12, BATMAN: ARKHAM KNIGHT ANNUAL #1, BATMAN: ARKHAM KNIGHT ROBIN #1 and BATMAN: ARKHAM KNIGHT: BATGIRL & HARLEY QUINN #1.',42,1,9781401270506,'2016-07-12');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Dark Nights: Metal: Deluxe Edition: Issues 1-6','The New York Times bestselling BATMAN writer and artist team of Scott Snyder and Greg Capullo re-unite in the epic event graphic novel DARK NIGHTS: METAL!  The Dark Knight has uncovered one of the lost mysteries of the universe...one that could destroy the very fabric of the DC Universe! The dark corners of reality that have never been seen till now! The Dark Multiverse is revealed in all its devastating danger--a team of twisted, evil versions of Batman hellbent on destroying the DC Universe!   With appearances from heroes, villains and faces long forgotten, DARK NIGHTS: METAL will examine every choice a hero doesn''t take and every path they don''t walk, and open up worlds that are forged by nightmares.    Together on a single title for an outstanding fifty issues, Snyder and Capullo''s award-winning stories BATMAN VOL. 1: THE COURT OF OWLS, BATMAN VOL. 3: DEATH OF THE FAMILY and BATMAN VOL. 7: ENDGAME turned generations of Batman fans into a global horde of Batman superfans. With DARK NIGHTS: METAL, Scott and Greg will build on this strong foundation and broaden the scope of their storytelling to encompass the full expanse of the DC Universe.  Collects DARK NIGHTS: METAL #1-6.',43,1,9781401287184,'2018-06-12');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Letting Go','Letting Go describes a simple and effective means by which to let go of the obstacles to Enlightenment and become free of negativity. 

During the many decades of the author’s clinical psychiatric practice, the primary aim was to seek the most effective ways to relieve human suffering in all of its many forms.The inner mechanism of surrender was found to be of great practical benefit and is described in this book. Dr Hawkins’s previous books focused on advanced states of awareness and Enlightenment. Over the years, thousands of students had asked for a practical technique by which to remove the inner blocks to happiness, love, joy, success, health and, ultimately, Enlightenment. This book provides a mechanism for letting go of those blocks. The mechanism of surrender that Dr Hawkins describes can be done in the midst of everyday life. The book is equally useful for all dimensions of human life: physical health, creativity, financial success, emotional healing, vocational fulfillment, relationships, sexuality and spiritual growth.It is an invaluable resource for all professionals who work in the areas of mental health, psychology, medicine, self-help, addiction recovery and spiritual development.',44,1,9781401945534,'2013-08-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Shantaram','''A literary masterpiece . . . at once erudite and intimate, reflective and funny . . . it has the grit and pace of a thriller'' Daily Telegraph

A novel of high adventure, great storytelling and moral purpose, based on an extraordinary true story of eight years in the Bombay underworld.

''In the early 80s, Gregory David Roberts, an armed robber and heroin addict, escaped from an Australian prison to India, where he lived in a Bombay slum. There, he established a free health clinic and also joined the mafia, working as a money launderer, forger and street soldier. He found time to learn Hindi and Marathi, fall in love, and spend time being worked over in an Indian jail. Then, in case anyone thought he was slacking, he acted in Bollywood and fought with the Mujahedeen in Afghanistan . . . Amazingly, Roberts wrote Shantaram three times after prison guards trashed the first two versions. It''s a profound tribute to his willpower . . . At once a high-kicking, eye-gouging adventure, a love saga and a savage yet tenderly lyrical fugitive vision.'' Time Out',12,1,9781405516976,'2012-06-28');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Eeny Meeny: DI Helen Grace 1','*** Start a new crime series... now at this special price for a limited time only ***''This is going to be as big as Jo Nesbo'' Judy Finnigan ''What a great premise!'' Jeffery Deaver, New York Times bestselling author of The Skin Collector and Solitude Creek
 
 Eeny Meeny is the rocket-paced serial-killer thriller debut from M. J. Arlidge. Eeny Meeny was a Richard and Judy Book Club Summer 2014 pick. ******** The girl emerged from the woods, barely alive. Her story was beyond belief. But it was true. Every dreadful word of it. Days later, another desperate escapee is found - and a pattern is emerging. Pairs of victims are being abducted, imprisoned then faced with a terrible choice: kill or be killed. Would you rather lose your life or lose your mind? Detective Inspector Helen Grace has faced down her own demons on her rise to the top. As she leads the investigation to hunt down this unseen monster, she learns that it may be the survivors - living calling cards - who hold the key to the case. And unless she succeeds, more innocents will die . . . Introducing M. J. Arlidge''s Detective Inspector Helen Grace, Eeny Meeny is an electrifying début, with the nerve-shredding intensity of Saw and Along Came a Spider. Fans of James Patterson and Mo Hayder should pay attention. Praise for M.J. Arlidge and the DI Helen Grace series: ''M. J. Arlidge has created a genuinely fresh heroine in DI Helen Grace'' Daily Mail ''Taut, fast-paced, truly excellent'' Sun
 
 ''Detective Inspector Helen Grace is one of the greatest heroes to come along in years.'' Jeffery Deaver, New York Times bestselling author of The Skin Collector and Solitude Creek ''Gruesomely realistic, intriguing and relentless'' Sunday Sport ''Eeny Meeny debuts one of the best new series detectives, Helen Grace. Determined, tough and damaged, she must unravel a terrifying riddle of a killer kidnapping victims in pairs. Mesmerizing!'' Lisa Gardner''A gripping debut ... D.I. Helen Grace is a flawed but winning heroine ... and, boy, the pages fly by'' USA Today''A fast-paced, twisting police procedural and thriller that''s sure to become another bestseller'' Huffington Post',5,1,9781405914895,'2014-05-08');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Final Option: ''The best one yet''','THE THRILLING NEW OREGON FILES NOVEL FROM THE ADVENTURE KING CLIVE CUSSLER''An all-out nonstop action thriller . . . the best one yet. The story hits the gas pedal and never taps the brakes'' Mail Online

 The Oregon crew face their greatest threat - a ship as secretive and powerful as their own and an enemy from their captain''s past every bit as wily and canny as Cabrillo himself . . .  When the CIA realizes the identities of three American spies in Brazil have been compromised, they turn to Juan Cabrillo and the crew of the Oregon to rescue the agents. What seems like a routine operation turns out to be a trap designed by Juan Cabrillo''s greatest enemy, seeking revenge. At the heart of the plot is a state-of-the-art ship that is identical to the Oregon: same weaponry, same technology, same ability to evade capture. But it doesn''t have is Cabrillo and his talented crew - will they be enough to go up against the only ship that rivals their own? In this high-stakes high seas mission packed with page-turning intrigue and exhilarating suspense, Final Option proves once again that no one writes adventure like Cussler.
 __________ ''Cussler is hard to beat'' 
 Daily Mail ''The Adventure King'' 
 Sunday Express
 
 ''Nobody does it better . . . nobody!'' 
 Stephen Coonts
 
 ''Just about the best storyteller in the business'' 
 New York Post',5,1,9781405941020,'2019-11-14');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('How to Win Friends and Influence People','The most famous confidence-boosting book ever published; with sales of over 16 million copies worldwide Millions of people around the world have improved their lives based on the teachings of Dale Carnegie. In How to Win Friends and Influence People, he offers practical advice and techniques, in his exuberant and conversational style, for how to get out of a mental rut and make life more rewarding.  His advice has stood the test of time and will teach you how to: 
 - make friends quickly and easily
 - increase your popularity
 - persuade people to follow your way of thinking
 - enable you to win new clients and customers
 - become a better speaker 
 - boost enthusiasm among your colleagues This classic book will turn your relationships around and improve your interactions with everyone in your life. Dale Carnegie, known as ''the arch-priest of the art of making friends'', pioneered the development of personal business skills, self-confidence and motivational techniques. His books - most notably How to Win Friends and Influence People - have sold tens of millions worldwide and, even in today''s changing climate, they remain as popular as ever.',24,1,9781409005216,'2010-09-30');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Black Box','May 1992, and after four LAPD officers are acquitted following the savage beating of Rodney King, Los Angeles is ablaze. As looting and burning take over the city, law and order are swept away in a tidal wave of violence. But under threat of their lives, homicide detectives like Harry Bosch are still stubbornly trying to do their job. With no effective police presence on the streets, murder just got a whole lot easier - and investigating them a whole lot harder. When Harry finds the body of a female journalist in an alley, he is forced to hand over the case to the Riot Crimes Task Force, knowing that it will never be solved.Twenty years later, new evidence confirms her death was not a case of random violence but something much more personal. This time Harry is determined that the killer isn''t going to escape - even if it means stepping back into the darkest days of the city he loves . . .',12,1,9781409134336,'2012-11-22');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Secret','The tenth-anniversary edition of the book that changed lives in profound ways, now with a new foreword and afterword.

In 2006, a groundbreaking feature-length film revealed the great mystery of the universe—The Secret—and, later that year, Rhonda Byrne followed with a book that became a worldwide bestseller.
 
Fragments of a Great Secret have been found in the oral traditions, in literature, in religions and philosophies throughout the centuries. For the first time, all the pieces of The Secret come together in an incredible revelation that will be life-transforming for all who experience it.
 
In this book, you’ll learn how to use The Secret in every aspect of your life—money, health, relationships, happiness, and in every interaction you have in the world. You’ll begin to understand the hidden, untapped power that’s within you, and this revelation can bring joy to every aspect of your life.
 
The Secret contains wisdom from modern-day teachers—men and women who have used it to achieve health, wealth, and happiness. By applying the knowledge of The Secret, they bring to light compelling stories of eradicating disease, acquiring massive wealth, overcoming obstacles, and achieving what many would regard as impossible.',25,1,9781416554998,'2007-02-26');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Competitive Advantage: Creating and Sustaining Superior Performance','Now beyond its eleventh printing and translated into twelve languages, Michael Porter’s The Competitive Advantage of Nations has changed completely our conception of how prosperity is created and sustained in the modern global economy. Porter’s groundbreaking study of international competitiveness has shaped national policy in countries around the world. It has also transformed thinking and action in states, cities, companies, and even entire regions such as Central America.

Based on research in ten leading trading nations, The Competitive Advantage of Nations offers the first theory of competitiveness based on the causes of the productivity with which companies compete. Porter shows how traditional comparative advantages such as natural resources and pools of labor have been superseded as sources of prosperity, and how broad macroeconomic accounts of competitiveness are insufficient. The book introduces Porter’s “diamond,” a whole new way to understand the competitive position of a nation (or other locations) in global competition that is now an integral part of international business thinking. Porter''s concept of “clusters,” or groups of interconnected firms, suppliers, related industries, and institutions that arise in particular locations, has become a new way for companies and governments to think about economies, assess the competitive advantage of locations, and set public policy.
 
Even before publication of the book, Porter’s theory had guided national reassessments in New Zealand and elsewhere. His ideas and personal involvement have shaped strategy in countries as diverse as the Netherlands, Portugal, Taiwan, Costa Rica, and India, and regions such as Massachusetts, California, and the Basque country. Hundreds of cluster initiatives have flourished throughout the world. In an era of intensifying global competition, this pathbreaking book on the new wealth of nations has become the standard by which all future work must be measured.',25,1,9781416595847,'2008-06-30');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Selling 101: What Every Successful Sales Professional Needs to Know','Here in a short, compact and concise format is the basics of how to persuade more people more effectively, more ethically, and more often. Ziglar draws from his fundamental selling experiences and shows that while the fundamentals of selling may remain constant, sales people must continue learning, living, and looking: learning from the past without living there; living in the present by seizing each vital moment of every single day; and looking to the future with hope, optimism, and education. His tips will not only keep your clients happy and add to your income, but will also teach you ideas and principles that will, most importantly, add to the quality of your life. Content drawn from Ziglar on Selling.',45,1,9781418530297,'2003-04-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Leadership 101: What Every Leader Needs to Know','Unleash your leadership potential. No matter who you are, you can lead—and lead well. That is the message New York Times bestselling author John C. Maxwell gives in this power-packed guidebook: Leadership 101. Here the consummate leader offers a succinct and inspiring framework for enhancing the leadership abilities you already possess. Learn how to:  Follow your vision and bring others with you Produce a lasting legacy Grow the loyalty of your followers Make continual investments in the quality of your leadership Increase your ability to influence others Determine your leadership "lid" Empower others through mentoring Create a foundation of trust Use self-discipline to improve your character—and your results One of the keys to successful leadership is applying the concepts that have made other leaders strong. Here''s your opportunity to do just that.',45,1,9781418535285,'2002-09-08');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Dead Silent','Ten months ago, Samantha Hunt set off for work…and was never seen again. 

Despite the statistics of cold cases, Dylan Scott wants to believe the young woman''s alive—and not just because her father, his client, is desperate to find his missing daughter before he dies of cancer. By all accounts Sam was a lovely girl, devoted to her younger stepsisters, well-liked at her work, in love with her boyfriend. 

But as usual not everything is as it seems in sleepy Dawson''s Clough. Sam''s boyfriend has a violent past. She may have been having an affair with her boss. And Dylan can''t shake the feeling that her stepfather is hiding something. Meanwhile, someone is trying to scare Dylan off the case. 

Who wanted to silence Sam, and why? The truth turns out to be worse than anyone expected…

80,000 words',46,1,9781426892103,'2011-08-22');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Eye of the World: Book One of ''The Wheel of Time''','The Wheel of Time ® is a PBS Great American Read Selection! Now in development for TV! Since its debut in 1990, The Wheel of Time® by Robert Jordan has captivated millions of readers around the globe with its scope, originality, and compelling characters.The Wheel of Time turns and Ages come and go, leaving memories that become legend. Legend fades to myth, and even myth is long forgotten when the Age that gave it birth returns again. In the Third Age, an Age of Prophecy, the World and Time themselves hang in the balance. What was, what will be, and what is, may yet fall under the Shadow.When The Two Rivers is attacked by Trollocs—a savage tribe of half-men, half-beasts— five villagers flee that night into a world they barely imagined, with new dangers waiting in the shadows and in the light.TV series update: "Sony will produce along with Red Eagle Entertainment and Radar Pictures. Rafe Judkins is attached to write and executive produce. Judkins previously worked on shows such as ABC’s “Agents of SHIELD,” the Netflix series “Hemlock Grove,” and the NBC series “Chuck.” Red Eagle partners Rick Selvage and Larry Mondragon will executive produce along with Radar’s Ted Field and Mike Weber. Darren Lemke will also executive produce, with Jordan’s widow Harriet McDougal serving as consulting producer." —VarietyThe Wheel of Time®
New Spring: The Novel
#1 The Eye of the World
#2 The Great Hunt
#3 The Dragon Reborn
#4 The Shadow Rising
#5 The Fires of Heaven
#6 Lord of Chaos
#7 A Crown of Swords
#8 The Path of Daggers
#9 Winter''s Heart
#10 Crossroads of Twilight
#11 Knife of DreamsBy Robert Jordan and Brandon Sanderson
#12 The Gathering Storm
#13 Towers of Midnight
#14 A Memory of LightBy Robert Jordan and Teresa Patterson
The World of Robert Jordan''s The Wheel of TimeBy Robert Jordan, Harriet McDougal, Alan Romanczuk, and Maria Simons
The Wheel of Time CompanionBy Robert Jordan and Amy Romanczuk
Patterns of the Wheel: Coloring Art Based on Robert Jordan''s The Wheel of TimeAt the Publisher''s request, this title is being sold without Digital Rights Management Software (DRM) applied.',39,1,9781429959810,'2000-09-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Shadow Rising: Book Four of ''The Wheel of Time''','The Wheel of Time ® is a PBS Great American Read Selection! Now in development for TV! 

Since its debut in 1990, The Wheel of Time® by Robert Jordan has captivated millions of readers around the globe with its scope, originality, and compelling characters.The Wheel of Time turns and Ages come and go, leaving memories that become legend. Legend fades to myth, and even myth is long forgotten when the Age that gave it birth returns again. In the Third Age, an Age of Prophecy, the World and Time themselves hang in the balance. What was, what will be, and what is, may yet fall under the Shadow.The seals of Shayol Ghul are weak now, and the Dark One reaches out. The Shadow is rising to cover humankind.In Tar Valon, Min sees portents of hideous doom. Will the White Tower itself be broken?In the Two Rivers, the Whitecloaks ride in pursuit of a man with golden eyes, and in pursuit of the Dragon Reborn.In Cantorin, among the Sea Folk, High Lady Suroth plans the return of the Seanchan armies to the mainland.In the Stone of Tear, the Lord Dragon considers his next move. It will be something no one expects, not the Black Ajah, not Tairen nobles, not Aes Sedai, not Egwene or Elayne or Nynaeve.Against the Shadow rising stands the Dragon Reborn...TV series update: "Sony will produce along with Red Eagle Entertainment and Radar Pictures. Rafe Judkins is attached to write and executive produce. Judkins previously worked on shows such as ABC’s “Agents of SHIELD,” the Netflix series “Hemlock Grove,” and the NBC series “Chuck.” Red Eagle partners Rick Selvage and Larry Mondragon will executive produce along with Radar’s Ted Field and Mike Weber. Darren Lemke will also executive produce, with Jordan’s widow Harriet McDougal serving as consulting producer." —VarietyThe Wheel of Time®
New Spring: The Novel
#1 The Eye of the World
#2 The Great Hunt
#3 The Dragon Reborn
#4 The Shadow Rising
#5 The Fires of Heaven
#6 Lord of Chaos
#7 A Crown of Swords
#8 The Path of Daggers
#9 Winter''s Heart
#10 Crossroads of Twilight
#11 Knife of DreamsBy Robert Jordan and Brandon Sanderson
#12 The Gathering Storm
#13 Towers of Midnight
#14 A Memory of LightBy Robert Jordan and Teresa Patterson
The World of Robert Jordan''s The Wheel of TimeBy Robert Jordan, Harriet McDougal, Alan Romanczuk, and Maria Simons
The Wheel of Time CompanionBy Robert Jordan and Amy Romanczuk
Patterns of the Wheel: Coloring Art Based on Robert Jordan''s The Wheel of TimeAt the Publisher''s request, this title is being sold without Digital Rights Management Software (DRM) applied.',39,1,9781429960199,'2010-01-19');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Fires of Heaven: Book Five of ''The Wheel of Time''','The Wheel of Time ® is a PBS Great American Read Selection! Now in development for TV! Since its debut in 1990, The Wheel of Time® by Robert Jordan has captivated millions of readers around the globe with its scope, originality, and compelling characters.The Wheel of Time turns and Ages come and go, leaving memories that become legend. Legend fades to myth, and even myth is long forgotten when the Age that gave it birth returns again. In the Third Age, an Age of Prophecy, the World and Time themselves hang in the balance. What was, what will be, and what is, may yet fall under the Shadow.Into the forbidden city of Rhuidean, where Rand al''Thor, now the Dragon Reborn, must conceal his present endeavor from all about him, even Egwene and Moiraine.Into the Amyrlin''s study in the White Tower, where the Amyrlin, Elaida do Avriny a''Roihan, is weaving new plans.Into the luxurious hidden chamber where the Forsaken Rahvin is meeting with three of his fellows to ensure their ultimate victory over the Dragon.Into the Queen''s court in Caemlyn, where Morgase is curiously in thrall to the handsome Lord Gaebril.For once the dragon walks the land, the fires of heaven fall where they will, until all men''s lives are ablaze.And in Shayol Ghul, the Dark One stirs...TV series update: "Sony will produce along with Red Eagle Entertainment and Radar Pictures. Rafe Judkins is attached to write and executive produce. Judkins previously worked on shows such as ABC’s “Agents of SHIELD,” the Netflix series “Hemlock Grove,” and the NBC series “Chuck.” Red Eagle partners Rick Selvage and Larry Mondragon will executive produce along with Radar’s Ted Field and Mike Weber. Darren Lemke will also executive produce, with Jordan’s widow Harriet McDougal serving as consulting producer." —VarietyThe Wheel of Time®
New Spring: The Novel
#1 The Eye of the World
#2 The Great Hunt
#3 The Dragon Reborn
#4 The Shadow Rising
#5 The Fires of Heaven
#6 Lord of Chaos
#7 A Crown of Swords
#8 The Path of Daggers
#9 Winter''s Heart
#10 Crossroads of Twilight
#11 Knife of DreamsBy Robert Jordan and Brandon Sanderson
#12 The Gathering Storm
#13 Towers of Midnight
#14 A Memory of LightBy Robert Jordan and Teresa Patterson
The World of Robert Jordan''s The Wheel of TimeBy Robert Jordan, Harriet McDougal, Alan Romanczuk, and Maria Simons
The Wheel of Time CompanionBy Robert Jordan and Amy Romanczuk
Patterns of the Wheel: Coloring Art Based on Robert Jordan''s The Wheel of TimeAt the Publisher''s request, this title is being sold without Digital Rights Management Software (DRM) applied.',39,1,9781429960373,'2010-02-16');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('A Crown of Swords: Book Seven of ''The Wheel of Time''','The Wheel of Time ® is a PBS Great American Read Selection! Now in development for TV! Since its debut in 1990, The Wheel of Time® by Robert Jordan has captivated millions of readers around the globe with its scope, originality, and compelling characters.The Wheel of Time turns and Ages come and go, leaving memories that become legend. Legend fades to myth, and even myth is long forgotten when the Age that gave it birth returns again. In the Third Age, an Age of Prophecy, the World and Time themselves hang in the balance. What was, what will be, and what is, may yet fall under the Shadow.Elayne, Aviendha, and Mat come ever closer to the bowl ter''angreal that may reverse the world''s endless heat wave and restore natural weather. Egwene begins to gather all manner of women who can channel--Sea Folk, Windfinders, Wise Ones, and some surprising others. And above all, Rand faces the dread Forsaken Sammael, in the shadows of Shadar Logoth, where the blood-hungry mist, Mashadar, waits for prey.TV series update: "Sony will produce along with Red Eagle Entertainment and Radar Pictures. Rafe Judkins is attached to write and executive produce. Judkins previously worked on shows such as ABC’s “Agents of SHIELD,” the Netflix series “Hemlock Grove,” and the NBC series “Chuck.” Red Eagle partners Rick Selvage and Larry Mondragon will executive produce along with Radar’s Ted Field and Mike Weber. Darren Lemke will also executive produce, with Jordan’s widow Harriet McDougal serving as consulting producer." —VarietyThe Wheel of Time®
New Spring: The Novel
#1 The Eye of the World
#2 The Great Hunt
#3 The Dragon Reborn
#4 The Shadow Rising
#5 The Fires of Heaven
#6 Lord of Chaos
#7 A Crown of Swords
#8 The Path of Daggers
#9 Winter''s Heart
#10 Crossroads of Twilight
#11 Knife of DreamsBy Robert Jordan and Brandon Sanderson
#12 The Gathering Storm
#13 Towers of Midnight
#14 A Memory of LightBy Robert Jordan and Teresa Patterson
The World of Robert Jordan''s The Wheel of TimeBy Robert Jordan, Harriet McDougal, Alan Romanczuk, and Maria Simons
The Wheel of Time CompanionBy Robert Jordan and Amy Romanczuk
Patterns of the Wheel: Coloring Art Based on Robert Jordan''s The Wheel of TimeAt the Publisher''s request, this title is being sold without Digital Rights Management Software (DRM) applied.',30,1,9781429960571,'2010-04-20');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Crossroads of Twilight: Book Ten of ''The Wheel of Time''','The Wheel of Time ® is a PBS Great American Read Selection! Now in development for TV! Since its debut in 1990, The Wheel of Time® by Robert Jordan has captivated millions of readers around the globe with its scope, originality, and compelling characters.The Wheel of Time turns and Ages come and go, leaving memories that become legend. Legend fades to myth, and even myth is long forgotten when the Age that gave it birth returns again. In the Third Age, an Age of Prophecy, the World and Time themselves hang in the balance. What was, what will be, and what is, may yet fall under the Shadow.Fleeing from Ebou Dar with the kidnapped Daughter of the Nine Moons, whom he is fated to marry, Mat Cauthon learns that he can neither keep her nor let her go, not in safety for either of them, for both the Shadow and the might of the Seanchan Empire are in deadly pursuit.Perrin Aybara seeks to free his wife, Faile, a captive of the Shaido, but his only hope may be an alliance with the enemy. Can he remain true to his friend Rand and to himself? For his love of Faile, Perrin is willing to sell his soul.At Tar Valon, Egwene al''Vere, the young Amyrlin of the rebel Aes Sedai, lays siege to the heart of Aes Sedai power, but she must win quickly, with as little bloodshed as possible, for unless the Aes Sedai are reunited, only the male Asha''man will remain to defend the world against the Dark One, and nothing can hold the Asha''man themselves back from total power except the Aes Sedai and a unified White Tower.In Andor, Elayne Trakland fights for the Lion Throne that is hers by right, but enemies and Darkfriends surround her, plotting her destruction. If she fails, Andor may fall to the Shadow, and the Dragon Reborn with it.Rand al''Thor, the Dragon Reborn himself, has cleansed the Dark One''s taint from the male half of the True Source, and everything has changed. Yet nothing has, for only men who can channel believe that saidin is clean again, and a man who can channel is still hated and feared-even one prophesied to save the world. Now, Rand must gamble again, with himself at stake, and he cannot be sure which of his allies are really enemies.TV series update: "Sony will produce along with Red Eagle Entertainment and Radar Pictures. Rafe Judkins is attached to write and executive produce. Judkins previously worked on shows such as ABC’s “Agents of SHIELD,” the Netflix series “Hemlock Grove,” and the NBC series “Chuck.” Red Eagle partners Rick Selvage and Larry Mondragon will executive produce along with Radar’s Ted Field and Mike Weber. Darren Lemke will also executive produce, with Jordan’s widow Harriet McDougal serving as consulting producer." —VarietyThe Wheel of Time®
New Spring: The Novel
#1 The Eye of the World
#2 The Great Hunt
#3 The Dragon Reborn
#4 The Shadow Rising
#5 The Fires of Heaven
#6 Lord of Chaos
#7 A Crown of Swords
#8 The Path of Daggers
#9 Winter''s Heart
#10 Crossroads of Twilight
#11 Knife of DreamsBy Robert Jordan and Brandon Sanderson
#12 The Gathering Storm
#13 Towers of Midnight
#14 A Memory of LightBy Robert Jordan and Teresa Patterson
The World of Robert Jordan''s The Wheel of TimeBy Robert Jordan, Harriet McDougal, Alan Romanczuk, and Maria Simons
The Wheel of Time CompanionBy Robert Jordan and Amy Romanczuk
Patterns of the Wheel: Coloring Art Based on Robert Jordan''s The Wheel of TimeAt the Publisher''s request, this title is being sold without Digital Rights Management Software (DRM) applied.',47,1,9781429960748,'2010-07-20');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Mistborn Trilogy: The Final Empire, The Well of Ascension, The Hero of Ages','This discounted ebundle includes: Mistborn: The Final Empire, The Well of Ascension, The Hero of AgesFrom #1 New York Times bestselling author Brandon Sanderson, the Mistborn trilogy is a heist story of political intrigue and magical, martial-arts action.For a thousand years the ash fell and no flowers bloomed. For a thousand years the Skaa slaved in misery and lived in fear. For a thousand years the Lord Ruler, the "Sliver of Infinity," reigned with absolute power and ultimate terror, divinely invincible. This saga dares to ask a simple question: What if the hero of prophecy fails?Mistborn: The Final Empire — Kelsier, a brilliant thief has turned his talents to the ultimate caper, with the Lord Ruler as the mark. Kel''s plan is the ultimate long shot, until luck brings a ragged girl named Vin into the fold. But she will have to learn to trust if she is to master powers of which she never dreamed.The Well of Ascension — Evil has been defeated; the war has just begun. Vin, the street urchin who has become the most powerful Mistborn in the land, and Elend Venture, the idealistic young nobleman who loves her, must build a healthy new society in the ashes of an empire.The Hero of Ages — The Deepness has returned, along with unusually heavy ashfalls and powerful earthquakes. Humanity appears to be doomed. Vin and Eland investigate the past to save the future, and in the end, sacrifices must be made.Other Tor books by Brandon Sanderson The Cosmere
 
 The Stormlight Archive
 The Way of Kings
 Words of Radiance
 Edgedancer (Novella)
 Oathbringer 
 
 The Mistborn trilogy
 Mistborn: The Final Empire
 The Well of Ascension
 The Hero of Ages
 
 Mistborn: The Wax and Wayne series
 Alloy of Law
 Shadows of Self
 Bands of Mourning Collection
 Arcanum Unbounded Other Cosmere novels
 Elantris
 Warbreaker The Alcatraz vs. the Evil Librarians series
 Alcatraz vs. the Evil Librarians
 The Scrivener''s Bones
 The Knights of Crystallia
 The Shattered Lens
 The Dark Talent The Rithmatist series
 The Rithmatist Other books by Brandon Sanderson

 The Reckoners
 Steelheart
 Firefight
 CalamityAt the Publisher''s request, this title is being sold without Digital Rights Management Software (DRM) applied.',39,1,9781429989817,'2011-02-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Start Day Trading Now: A Quick and Easy Introduction to Making Money While Managing Your Risk','Are you intimidated by day trading? Think it''s only for the select few who are savvy with stocks or are financial savants? Well, think again, because anyone can master day trading--and once you learn the basic techniques, it''s possible to make a boatload of money! The flip side: if you don''t know what you''re doing, you can lose your shirt.

In this entry-level guide to day trading, MarketWatch columnist and financial journalist Michael Sincere assumes you know nothing. Zip. Zero. Inside, he shows you how to get started and breaks day trading down by clearly explaining:What computer equipment you''ll needHow much money is requiredThe technical jargon of day tradingKey strategies you''ll employ while tradingHow you can manage risk Most important, Sincere lets you in on the biggest secret of all: how to master the mind game of day trading.

Thousands of day traders have watched their bank accounts balloon thanks to Wall Street. Now you can get into the market and enter their coveted ranks.',25,1,9781440511929,'2011-02-18');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Furies of Calderon','In this extraordinary fantasy epic, the #1 New York Times bestselling author of the Dresden Files leads readers into a world where the fate of the realm rests on the shoulders of a boy with no power to call his own...
  
 For a thousand years, the people of Alera have united against the aggressive and threatening races that inhabit the world, using their unique bond with the furies—elementals of earth, air, fire, water, wood, and metal. But in the remote Calderon Valley, the boy Tavi struggles with his lack of furycrafting. At fifteen, he has no wind fury to help him fly, no fire fury to light his lamps. Yet as the Alerans’ most savage enemy—the Marat horde—return to the Valley, Tavi’s courage and resourcefulness will be a power greater than any fury, one that could turn the tides of war...',18,1,9781440631849,'2005-06-28');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('I Am Pilgrim: The bestselling Richard & Judy Book Club pick','''An all too plausible disaster for the world we live in. Great nail-biting stuff'' - Robert Goddard
''The plot twists and turns like a python in a sack... Visceral, gritty and cinematic'' - The TimesWhen your past comes calling, it''s time to disappear . . . Pilgrim is the codename for a man who doesn’t exist. The adopted son of a wealthy American family, he once headed up a secret espionage unit for US intelligence. Before he disappeared into anonymous retirement, he wrote the definitive book on forensic criminal investigation.But that book will come back to haunt him. It will help NYPD detective Ben Bradley track him down. And it will take him to a rundown New York hotel room where the body of a woman is found facedown in a bath of acid.Her features erased, her teeth missing, her fingerprints gone. The perfect crime, it''s a textbook murder – and Pilgrim wrote the book.What begins as an unusual and challenging investigation will become a terrifying race-against-time to save America from oblivion, in the Sunday Times bestselling novel from Terry Hayes.',24,1,9781448170609,'2013-07-18');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Power of Focus: How to Hit Your Business, Personal and Financial Targets with Confidence and Certainty','The No1 problem that stops people getting what they want is lack of focus. Those that focus on what they want to achieve prosper, while those that don''t struggle. In The Power of Focus, you''ll discover the specific focusing strategies used by the world''s most successful men and women. In this new, updated edition, you''ll find out how to:- Focus on your strengths and eliminate everything that is holding you back
- Change bad habits into habits that will make you debt-free and wealthy
- Create an excellent balance between work and family life - without guilt!Your ability to focus will determine your future, so start now!',24,1,9781448176007,'2013-09-30');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Heart and Brain: An Awkward Yeti Collection','Boasting more than two million pageviews per month, TheAwkwardYeti.com has become a webcomic staple since its creation in 2012.

 In addition to tons of fan favorites, Heart and Brain contains more than 75 brand new comics that have never been seen online.

 From paying taxes and getting up for work to dancing with kittens and starting a band, readers everywhere will relate to the ongoing struggle between Heart and Brain.',48,1,9781449474836,'2015-10-20');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('How To Win Friends and Influence People','You can go after the job you want—and get it!
 You can take the job you have—and improve it!
 You can take any situation—and make it work for you!

Dale Carnegie’s rock-solid, time-tested advice has carried countless people up the ladder of success in their business and personal lives. One of the most groundbreaking and timeless bestsellers of all time, How to Win Friends & Influence People will teach you:
 
 -Six ways to make people like you
 -Twelve ways to win people to your way of thinking
 -Nine ways to change people without arousing resentment
 
 And much more! Achieve your maximum potential—a must-read for the twenty-first century with more than 15 million copies sold!',25,1,9781451621716,'2010-08-24');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Kiss the Girls and Make Them Cry','AN ELECTRIFYING NEW THRILLER FROM ''QUEEN OF SUSPENSE'' MARY HIGGINS CLARK . . .

 When investigative journalist Gina Kane receives an email from a ''CRyan'' describing her ''terrible experience'' while working at REL, a high-profile television news network, including the comment ''and I’m not the only one,'' Gina knows she has to pursue the story. But when Ryan goes silent, Gina is shocked to discover the young woman has died tragically in a Jet Ski accident while on holiday.

 Meanwhile, REL counsel Michael Carter finds himself in a tricky spot. Several female employees have come forward with allegations of sexual misconduct. Carter approaches the CEO, offering to persuade the victims to accept settlements in exchange for their silence. It’s a risky endeavor, but it could well make him rich.

 As more allegations emerge and the company’s IPO draws near, Carter’s attempts to keep the story from making headlines are matched only by Gina Kane’s determination to uncover the truth. Was Ryan’s death truly an accident? And when another accuser turns up dead, Gina realizes someone—or some people—will go to depraved lengths to keep the story from seeing the light.

 The novels of Mary Higgins Clark are perfect for fans of Sabine Durant, Shari Lapena and everyone who loves a good mystery...

*** Praise for Mary Higgins Clark  ***

 ''I adore Mary Higgins Clark'' Karin Slaughter 

 ''Trust Mary Higgins Clark to know what frightens us to death'' New York Times 

 ''Clark plays out her story like the pro that she is . . . flawless'' Daily Mirror

 ''Should come with a warning: start in the evening and you''ll be reading late into the night'' USA Today',25,1,9781471167690,'2019-11-14');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Dork Diaries: Spectacular Superstar','Nikki Maxwell’s summer is packed with drama in this fourteenth installment of the bestselling Dork Diaries series - now with over 45 million books in print worldwide!

 Nikki and her bandmates are looking forward to an AWESOME summer on tour as the opening act for the world famous Bad Boyz! Nikki is a little worried when her frenemy, MacKenzie Hollister, weasels her way on to the tour. But she has a total MELTDOWN when she learns that MacKenzie is her new roommate! Will Nikki survive her dream tour turning into a nightmare?!',25,1,9781471172816,'2019-10-31');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Queen of Nothing (The Folk of the Air #3)','The intoxicating and bloodthirsty finale to the New York Times bestselling The Cruel Prince, nominated for the CILIP CARNEGIE MEDAL 2019, and  New York Times bestseller The Wicked King 

After being pronounced Queen of Faerie and then abruptly exiled by the Wicked King Cardan, Jude finds herself unmoored, the queen of nothing. She spends her time with Vivi and Oak, watching reality television, and doing odd jobs, including squaring up to a cannibalistic faerie.

When her twin sister Taryn shows up asking a favour, Jude jumps at the chance to return to the Faerie world, even if it means facing Cardan, who she loves despite his betrayal. When a dark curse is unveiled, Jude must become the first mortal Queen of Faerie and break the curse, or risk upsetting the balance of the whole Faerie world.',49,1,9781471407574,'2019-11-19');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('No Mercy: The brand new novel from the Queen of Crime','Family always come first. Until now. No more waiting, the new novel from the No. 1 bestselling phenomenon Martina Cole is here, and it''s pure Martina gold. No Mercy is a heart-stopping rollercoaster ride of a read that proves there really is only one Martina Cole. Diana Davis has been head of the family business since the death of her husband, an infamous bank robber. She''s a woman in a man''s world, but no one messes with her.Her only son, Angus, is a natural born villain, but he needs to earn Diana''s trust before she''ll allow him into the business.Once he''s proved he has the brains to run their clubs in Marbella, he is given what he''s always wanted. It''s the beginning of a reign of terror that knows no bounds.But Angus has a blind spot: his wife, Lorna, and their three kids, Angus Junior, Sean and Eilish. And as the next generation enters the business, Angus has a painful truth to learn. Even when it comes to family, he must show no mercy...''She''s a total one-off'' Guardian''The stuff of legend'' Mirror''Superstar crime writer'' This Morning''There really is only one Martina Cole'' Closer''The undisputed Queen of crime writing'' Erwin James',12,1,9781472249425,'2019-10-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Malady and Other Stories: An Andrzej Sapkowski Sampler','A sample of offerings from international fantasy superstar Andrzej Sapkowski, and the perfect introduction to his work.Best known for his series of stories and novels about Geralt, the Witcher, Sapkowski is one of the most successful fantasy authors in the world. Contains:
2 complete Witcher short stories taken from THE LAST WISH
The first chapter of BLOOD OF ELVES, the first Witcher novel
An exclusive sneak peek at the forthcoming BAPTISM OF FIRE, the third full-length book in the series
A non-Witcher short story, THE MALADY',12,1,9781473202993,'2014-07-03');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Sword of Destiny: Witcher 2: Tales of the Witcher','Geralt is a witcher, a man whose magic powers, enhanced by long training and a mysterious elixir, have made him a brilliant fighter and a merciless assassin. Yet he is no ordinary murderer: his targets are the multifarious monsters and vile fiends that ravage the land and attack the innocent. He roams the country seeking assignments, but gradually comes to realise that while some of his quarry are unremittingly vile, vicious grotesques, others are the victims of sin, evil or simple naivety.In this collection of short stories, following the adventures of the hit collection THE LAST WISH, join Geralt as he battles monsters, demons and prejudices alike . . .',12,1,9781473211551,'2015-05-21');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Tower of the Swallow: Witcher 6','The world has fallen into war. Ciri, the child of prophecy, has vanished. Hunted by friends and foes alike, she has taken on the guise of a petty bandit and lives free for the first time in her life.
But the net around her is closing. Geralt, the Witcher, has assembled a group of allies determined to rescue her. Both sides of the war have sent brutal mercenaries to hunt her down. Her crimes have made her famous. There is only one place left to run. The tower of the swallow is waiting...',12,1,9781473211582,'2016-05-19');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Happy: Why More or Less Everything is Absolutely Fine','_______
THE SUNDAY TIMES BESTELLER‘Deeply informative, moving, wise and full of love’
Alain de BottonEveryone says they want to be happy. But that''s much more easily said than done. What does being happy actually mean? And how do you even know when you feel it?In Happy Derren Brown explores changing concepts of happiness - from the surprisingly modern wisdom of the Stoics and Epicureans in classical times right up until today, when the self-help industry has attempted to claim happiness as its own. He shows how many of self-help’s suggested routes to happiness and success – such as positive thinking, self-belief and setting goals – can be disastrous to follow and, indeed, actually cause anxiety. Happy aims to reclaim happiness and to enable us to appreciate the good things in life, in all their transient glory. By taking control of the stories we tell ourselves, by remembering that ‘everything’s fine’ even when it might not feel that way, we can allow ourselves to flourish and to live more happily._______PRAISE FOR HAPPY:
"Crammed with wisdom and insight . . . I''m going to recommend it to everyone I know" Stephen Fry
"Witty, useful and beautifully written" The Sunday Times
"A wonderfully evocative - and enjoyable - book" A.C. Grayling_______Please note that customers may receive this title with either a blue or a yellow cover.',24,1,9781473526853,'2016-09-22');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Secrets of Saving and Investing with Alvin Hall: Simple Strategies to Make Your Money Go Further','The most popular question Alvin Hall is asked is ''where does my money go?''. In this quick and straightforward mini-guide, Alvin helps everyone get their finances in order by exploring the fundamentals of savings and investments.  Helping you to reverse that ''spend first, save later'' impulse, Alvin beats a clear pathway through the financial maze of saving and investing, and provides a practical understanding of how to make the most of your personal finances.This is an easy-to-follow advice for a brighter, sounder financial future.',12,1,9781473616141,'2015-01-29');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('You Are a Badass: How to Stop Doubting Your Greatness and Start Living an Awesome Life','YOU ARE A BADASS IS THE SELF-HELP BOOK FOR PEOPLE WHO DESPERATELY WANT TO IMPROVE THEIR LIVES BUT DON''T WANT TO GET BUSTED DOING IT.

In this refreshingly entertaining how-to guide, bestselling author and world-traveling success coach, Jen Sincero, serves up 27 bitesized chapters full of hilariously inspiring stories, sage advice, easy exercises, and the occasional swear word, helping you to: - Identify and change the self-sabotaging beliefs and behaviours that stop you from getting what you want.
- Create a life you totally love. And create it NOW!
- Make some damn money already. The kind you''ve never made before. By the end of You Are a Badass, you''ll understand why you are how you are, how to love what you can''t change, how to change what you don''t love, and how to use The Force to kick some serious ass.',12,1,9781473649491,'2016-10-13');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Battle Sight Zero','From the author of Harry''s Game - A Sunday Times ''100 best crime novels and thrillers since 1945'' pickThe Kalashnikov AK47. A weapon with a unique image. A symbol of freedom fighters and terrorists across the globe. Undercover officer Andy Knight has infiltrated an extremist group intent on bringing the rifle to Britain - something MI5 have been struggling for years to prevent.  He befriends Zeinab, the young Muslim student from Yorkshire who is at the centre of the plot. All Zeinab needs to do is travel to the impoverished high-rise estates of Marseilles and bring one rifle home on a test run. Then many more will follow - and with them would come killing on an horrendous scale. Zeinab is both passionate and attractive, and though Andy knows that the golden rule of undercover work is not to get emotionally attached to the target, sometimes rules are impossible to follow. Supremely suspenseful, Battle Sight Zero follows Andy and Zeinab to the lethal badlands of the French port city, simultaneously tracking the extraordinary life journey of the blood-soaked weapon they are destined to be handed there.',12,1,9781473663527,'2019-01-10');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Guardians: The explosive new thriller from international bestseller John Grisham','The Sunday Times bestseller from international bestseller John Grisham.''Grisham at his passionate best'' - Daily Mail

He was framed for murder.
 Now he needs a miracle. 
 
 22 years ago Quincy Miller was sentenced to life without parole. He was accused of killing Keith Russo, a lawyer in a small Florida town. But there were no reliable witnesses and little motive. Just the fact that Russo had botched Quincy''s divorce case, that Quincy was black in a largely all-white town and that a blood-splattered torch was found in the boot of Quincy''s car. A torch he swore was planted. A torch that was conveniently destroyed in a fire just before his trial. The lack of evidence made no difference to judge or jury. In the eyes of the law Quincy was guilty and, no matter how often he protested his innocence, his punishment was life in prison. Finally, after 22 years, comes Quincy''s one and only chance of freedom. An innocence lawyer and minister, Cullen Post, takes on his case. Post has exonerated eight men in the last ten years. He intends to make Quincy the next. But there were powerful and ruthless people behind Russo''s murder. They prefer that an innocent man dies in jail rather than one of them. There''s one way to guarantee that. They killed one lawyer 22 years ago, and they''ll kill another without a second thought.

Praise for John Grisham''s THE GUARDIANS:...Grisham at his passionate best, conveying every ounce of his anger at the corruption behind the law. It is his finest book for some time. Do not miss it - Daily MailA canny and engrossing blend of two types of Grisham novel: enough of the familiar formula of a single lawsuit in a single town, mixed with a more picaresque and multistranded approach that has the significant advantage of taking in a wider swathe of America - The Sunday TimesDelivered with all his signature easy, flowing style. A past master at the art of deft characterisation and the skilful delivery of hair-raising crescendos, Grisham makes this a deceptively easy read. But The Guardians is much more than a simple legal divertissement... Grisham aims a spotlight at the all-too-prevalent venality of the American ''win at all costs'' prosecutorial attitude... much of his inspiration is based on tragic fact - Irish IndependentThe master of the legal thriller turns to one of his real-life passions - freeing those wrongly convicted. Inspired by true stories, the skilful plot follows an "innocence lawyer", who goes up against dangerous foes as he dedicates himself to freeing a man behind bars for the murder of a lawyer - Sunday MirrorThis is typical Grisham: speedy, gripping, very good at conveying the complexities of the law in a digestible way - Sunday ExpressSpeedy and gripping - Daily MirrorNo one with any interest in justice could resist this story, which Grisham has structured with all his familiar skill. The good characters are sympathetic, the wicked are truly revolting and the rage is wholly understandable - Literary Review************

THE INNOCENT MAN by John Grisham is now a major six-part documentary series on Netflix************',12,1,9781473684454,'2019-10-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Home Work: A Memoir of My Hollywood Years','In this follow-up to her critically acclaimed and bestselling memoir Home, the enchanting Julie Andrews picks up her story with her arrival in Hollywood, sharing the career highlights, personal experiences and reflections behind her astonishing career, including such classics as Mary Poppins, The Sound of Music, Victor/Victoria and many others.In Home, Julie Andrews recounted her difficult childhood and her emergence as an acclaimed singer and performer on the stage. In her new memoir, Julie picks up the story with her arrival in Hollywood and her astonishing rise to fame as two of her early films -Mary Poppins and The Sound of Music- brought her instant and enormous success, including an Oscar. It was the beginning of a career that would make Julie Andrews an icon to millions the world over. In Home Work, Julie describes her years in Hollywood - from the incredible highs to the challenging lows. Not only does she detail her work in now-classic films and her collaborations with giants of cinema and television; she also unveils her personal story of adjusting to a new and often daunting world, dealing with the demands of unimaginable success, being a new mother, moving on from her first marriage, embracing two stepchildren, adopting two more children, and falling in love with the brilliant and mercurial Blake Edwards. The pair worked together in numerous films, culminating in Victor/Victoria, the gender-bending comedy that garnered multiple Oscar nominations. Told with her trademark charm and candour, Julie Andrews takes us on a rare and intimate journey into an astonishing life that is funny, heartbreaking and inspiring.',12,1,9781474602198,'2019-10-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Raven','Edgar Allan Poe’s celebrated narrative poem now available as an ebook, including an extended excerpt from Mrs. Poe by Lynn Cullen, a vivid and compelling novel about a poet who becomes entangled in an affair with Edgar Allan Poe—at the same time that she becomes the unwilling confidante of his much-younger wife.',25,1,9781476759685,'2013-08-26');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('War and Peace: With bonus material from Give War and Peace A Chance by Andrew D. Kaufman','War and Peace is considered one of the world’s greatest works of fiction. It is regarded, along with Anna Karenina, as Tolstoy’s finest literary achievement. 

Epic in scale, War and Peace delineates in graphic detail events leading up to Napoleon’s invasion of Russia, and the impact of the Napoleonic era on Tsarist society, as seen through the eyes of five Russian aristocratic families.',25,1,9781476789477,'2014-04-08');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Memoirs of Sherlock Holmes','From his rooms in Baker Street, Sherlock Holmes grapples with forces of deceit, intrigue, and evil in Victorian London.

The Memoirs of Sherlock Holmes inspired The Map of Chaos by New York Times bestselling author Félix J. Palma. As a gift to readers, this ebook edition includes an excerpt from The Map of Chaos.',25,1,9781476797502,'2014-11-18');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Death of a Bachelorette','Freelance writer Jaine Austen thought working for a knock-off reality show in the tropics would be paradise. But when she and her kitty Prozac find themselves trapped between a dimwitted leading man, catty contestants, and a cold-blooded murderer, the splashy gig becomes one deadly nightmare . . .
 
Jaine’s life has been a royal pain since she started penning dialogue for Some Day My Prince Will Come—a cheesy dating show that features bachelorettes competing for the heart of Spencer Dalworth VII, a very distant heir to the British throne. But when one of the finalists dies in a freak accident, it’s clear someone wanted the woman out of the race for good—and the police won’t allow a soul off the island until they seize the culprit. Terrified of existing another day without air conditioning and eager to return home, Jaine is throwing herself into the investigation. And she better pounce on clues quickly—or there won’t be any survivors left . . .',27,1,9781496708489,'2017-07-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Candide','Voltaire’s satire of eighteenth-century Europe, hailed as one of the most influential works in the Western canon

 Candide’s misfortunes begin when his uncle, a German baron, banishes him for kissing the baron’s daughter, Cunégonde. Forced to make his own way in the world, Candide goes from conscription in the Bulgar army, to Lisbon, after a harrowing voyage by sea, to the tutelage of the Enlightenment philosopher Pangloss. After an unexpected reunion with his beloved Cunégonde, Candide finds that further misadventure awaits, first through South America and then back in Europe, where he settles in the countryside.

 Among the most widely renowned texts of western literature, Candide lives on two hundred fifty years since its first publication as a supreme example of political, philosophical, and religious satire whose wit and power of observation have influenced writers for generations.

 This ebook has been professionally proofread to ensure accuracy and readability on all devices.',50,1,9781497684256,'2015-01-27');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Principles: Life and Work','#1 New York Times Bestseller
 
“Significant...The book is both instructive and surprisingly moving.” —The New York Times
 
 Ray Dalio, one of the world’s most successful investors and entrepreneurs, shares the unconventional principles that he’s developed, refined, and used over the past forty years to create unique results in both life and business—and which any person or organization can adopt to help achieve their goals.

In 1975, Ray Dalio founded an investment firm, Bridgewater Associates, out of his two-bedroom apartment in New York City. Forty years later, Bridgewater has made more money for its clients than any other hedge fund in history and grown into the fifth most important private company in the United States, according to Fortune magazine. Dalio himself has been named to Time magazine’s list of the 100 most influential people in the world. Along the way, Dalio discovered a set of unique principles that have led to Bridgewater’s exceptionally effective culture, which he describes as “an idea meritocracy that strives to achieve meaningful work and meaningful relationships through radical transparency.” It is these principles, and not anything special about Dalio—who grew up an ordinary kid in a middle-class Long Island neighborhood—that he believes are the reason behind his success.
 
 In Principles, Dalio shares what he’s learned over the course of his remarkable career. He argues that life, management, economics, and investing can all be systemized into rules and understood like machines. The book’s hundreds of practical lessons, which are built around his cornerstones of “radical truth” and “radical transparency,” include Dalio laying out the most effective ways for individuals and organizations to make decisions, approach challenges, and build strong teams. He also describes the innovative tools the firm uses to bring an idea meritocracy to life, such as creating “baseball cards” for all employees that distill their strengths and weaknesses, and employing computerized decision-making systems to make believability-weighted decisions. While the book brims with novel ideas for organizations and institutions, Principles also offers a clear, straightforward approach to decision-making that Dalio believes anyone can apply, no matter what they’re seeking to achieve.
 
Here, from a man who has been called both “the Steve Jobs of investing” and “the philosopher king of the financial universe” (CIO magazine), is a rare opportunity to gain proven advice unlike anything you’ll find in the conventional business press.',25,1,9781501124051,'2017-09-19');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('It','It: Chapter Two—now a major motion picture!
 
 Stephen King’s terrifying, classic #1 New York Times bestseller, “a landmark in American literature” (Chicago Sun-Times)—about seven adults who return to their hometown to confront a nightmare they had first stumbled on as teenagers…an evil without a name: It.

Welcome to Derry, Maine. It’s a small city, a place as hauntingly familiar as your own hometown. Only in Derry the haunting is real.
 
They were seven teenagers when they first stumbled upon the horror. Now they are grown-up men and women who have gone out into the big world to gain success and happiness. But the promise they made twenty-eight years ago calls them reunite in the same place where, as teenagers, they battled an evil creature that preyed on the city’s children. Now, children are being murdered again and their repressed memories of that terrifying summer return as they prepare to once again battle the monster lurking in Derry’s sewers.
 
Readers of Stephen King know that Derry, Maine, is a place with a deep, dark hold on the author. It reappears in many of his books, including Bag of Bones, Hearts in Atlantis, and 11/22/63. But it all starts with It.
 
“Stephen King’s most mature work” (St. Petersburg Times), “It will overwhelm you…to be read in a well-lit room only” (Los Angeles Times).',25,1,9781501141232,'2016-01-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Art of Super Mario Odyssey','Take a globetrotting journey all over the world--and beyond!--with this companion art book to the hit video game for the Nintendo Switch(TM) system!

In October of 2017, Super Mario Odyssey(TM) took the gaming world by storm. Now, discover the art and expertise that went into creating one of Nintendo''s best-loved games!

 This full-color volume clocks in at over 350 pages and features concept art, preliminary sketches, and notes from the development team, plus insight into some early ideas that didn''t make it into the game itself! Explore the world of Super Mario Odyssey from every angle, including screen shots, marketing material, and more, to fully appreciate this captivating adventure',51,1,9781506713816,'2019-11-05');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Critical Role Vox Machina: Origins: Volume 1','From the creators of the hit show "Critical Role" comes Vox Machina''s origin story! Writers Matthew Mercer and Matthew Colville team with artist extraordinaire Olivia Samson and colorist Chris Northrop to bring you the story of where the heroes'' journey began.

The band of adventurers known as Vox Machina will save the world. Eventually. But even they have to start somewhere.

Six would-be heroes on seemingly different jobs find their paths intertwined as they investigate shady business in the swamp town of Stilben. They''ll need to put their heads-- and weapons--together to figure out what''s going on...and keep from being killed in the process. Even then, whether or not they can overcome what truly lurks at the bottom of the town''s travails remains to be seen! 

Collects Critical Role Vox Machina: Origins comics issues #1-6, one of the best selling digital comics ever!',51,1,9781506714820,'2019-10-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Maigret Goes to School','“One of the greatest writers of the twentieth century . . . Simenon was unequaled at making us look inside, though the ability was masked by his brilliance at absorbing us obsessively in his stories.” —The Guardian

Inspector Maigret becomes entangled in the dramas of a small town on his quest to solve the murder of their former postmistress

 Maigret is called from his usual duties in Paris to investigate a murder in a small village located close to La Rochelle. A local postmistress has been killed and suspicion has fallen on the local schoolmaster. When Maigret gets there, he discovers a very inward-looking community of people who hated the victim because she knew all their secrets. Maigret must determine if one of those secrets was enough to make someone into a killer.',18,1,9781524705398,'2018-01-02');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Martha Stewart''s Cookie Perfection: 100+ Recipes to Take Your Sweet Treats to the Next Level: A Baking Book','Showstopper cookies for a new generation: from Martha Stewart, an authoritative and creative collection to take your cookies to the next level in flavor, technique, and decorative appeal

The editors of Martha Stewart Living present a new, fun source for anyone looking to make their go-to cookies even better and bolder. These recipes make ordinary cookies absolutely extraordinary--all the familiar favorites you love, but taken up a notch in variety, flavor, and creativity. Classic recipes discover new life with unexpected twists such as Brown-Butter Crinkle Cookies and Carrot Cake Thumbprint Cookies. Go over-the-top in super-sized fashion with Chocolate-Chocolate Chip Skillet Cookies; get inspired by cultures around the globe with Brazilian Wedding Cookies and Stroopwafels; and celebrate with beautifully decorated holiday treats, such as Easter Egg Puzzle Cookies and Snowball Truffles. Whether for a special celebration or a sweet anytime-treat, you''ll be sure to find inspiration to trade in your everyday cookies for versions far more special—and especially delicious.',52,1,9781524763404,'2019-10-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('10 Ways to be less consumerist','Do you buy things without need?Do you buy things to feel happy? If the answer is ''yes'' then you need to read this short book.',53,1,9781526012456,'2019-11-21');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('10 Ways to be annoying','Nobody invites you to parties?Do you feel like a seesaw? Cause when you sit down, everybody gets up and leaves.Do you feel like people do not want to be around you?Read this short book and understand why your friends avoid you.',53,1,9781526012487,'2019-11-21');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Indistractable: How to Control Your Attention and Choose Your Life','''A must-read'' MARK MANSON

''Exactly what most of us need in order to focus on what is important, rather than the dazzling, illuminated, unsatisfying distractions of modern life'' MATT HAIG

''Does exactly as it promises. Amazing'' CHRIS EVANS

''A guide to staying focused in an age of constant distraction'' GUARDIAN

''Eyal argues with impeccable logic'' THE TIMES

''Masses of really useful arsenal and some very interesting studies about how to be less distracted in the world'' PANDORA SYKES

''Now there''s a way we can regain our ability to focus'' RED
___________________________

We are living through a crisis of distraction. Plans get sidetracked, friends are ignored, work never seems to get done. 

Why does it feel like we''re distracting our lives away?

In Indistractable, behavioural designer Nir Eyal shows what life could look like if you followed through on your intentions. Instead of suggesting a digital detox, Eyal reveals the hidden psychology driving you to distraction, and teaches you how to make pacts with yourself to keep your brain on track. Indistractable is a guide to making decisions and seeing them through. 

Empowering and optimistic, this is the book that will help you design your time, realise your ambitions, and live the life you really want.',54,1,9781526610232,'2019-10-17');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Twas The Nightshift Before Christmas: Festive hospital diaries from the author of million-copy hit This is Going to Hurt','A short gift book of festive hospital diaries from the author of million-copy bestseller This is Going to HurtChristmas is coming, the goose is getting fat . . . but 1.4 million NHS staff are heading off to work. In this perfect present for anyone who has ever set foot in a hospital, Adam Kay delves back into his diaries for a hilarious, horrifying and sometimes heartbreaking peek behind the blue curtain at Christmastime.Twas the Nightshift Before Christmas is a love letter to all those who spend their festive season on the front line, removing babies and baubles from the various places they get stuck, at the most wonderful time of the year.''The perfect surgical stocking-filler'' The Times',10,1,9781529018592,'2019-10-17');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Tall Tales and Wee Stories: The Best of Billy Connolly','THE SUNDAY TIMES BESTSELLER''Coming from Glasgow, it''s weird, I don''t really tell jokes, like Irish jokes and all that. I tell wee stories. And some of them don''t even have punchlines. But you''ll get used to it as the night goes on, and on, and on, and on and on...''In December 2018, after fifty years of belly-laughs, energy and outrage, Billy Connolly announced his retirement from live stand-up comedy. It had been an extraordinary career.When he first started out in the late sixties, Billy played the banjo in the folk clubs of Scotland. Between songs, he would improvise a bit, telling anecdotes from the Clyde shipyard where he''d worked. In the process, he made all kinds of discoveries about what audiences found funny, from his own brilliant mimes to the power of speaking irreverently about politics or explicitly about sex. He began to understand the craft of great storytelling. Soon the songs became shorter and the monologues longer, and Billy quickly became recognised as one of the most exciting comedians of his generation.Billy''s routines always felt spontaneous. He never wrote scripts, always creating his comedy freshly on stage in the presence of a live audience. A brilliant comic story might be subsequently discarded, adapted or embellished. A quick observation or short anecdote one night, could become a twenty-minute segment by the next night of a tour.Billy always brought a beautiful sense of the absurd to his shows as he riffed on his family, hecklers, swimming in the North Sea or naked bungee jumping. But his comedy can be laced with anger too. He hates pretentiousness and calls out hypocrisy wherever he sees it. His insights about the human condition have shocked many people, while his unique talent and startling appearance on stage gave him license to say anything he damn well pleased about sex, politics or religion. Billy got away with it because he has always had the popular touch. His comedy spans generations and different social tribes in a way that few others have ever managed.Tall Tales and Wee Stories brings together the very best of Billy''s storytelling for the first time and includes his most famous routines including, The Last Supper, Jojoba Shampoo, Incontinence Pants and Shouting at Wildebeest. With an introduction and original illustrations by Billy throughout, it is an inspirational, energetic and riotously funny read, and a fitting celebration of our greatest ever comedian.',12,1,9781529361353,'2019-10-17');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Ask A Footballer','''Ask a Footballer is a fine read, showcasing how an unassuming man has forged success, winning the Premier League twice, the FA Cup and the Champions League'' Matthew Syed, The TimesEver wondered what it''s REALLY like to be a Premier League footballer?

My name is James Milner and I''m not a Ribena-holic.

Let me share insights into what it''s like being a professional footballer, across my different experiences with Leeds United, Newcastle, Aston Villa, Manchester City and now Liverpool (not forgetting a six-match loan spell at Swindon). Plus my highs - and a few too many lows - playing for England. There isn''t a current player who''s been playing Premier League football as long as I have, and that gives me a pretty rare perspective into how the top-flight game has changed over the past seventeen years.In this book, I explain how a footballer''s working week unfolds - what we eat and how we prepare for matches technically, tactically, mentally and physically - and talk you through the ups and downs of a matchday. I reveal my penalty-taking techniques, half-time team talks and the differences between playing against Lionel Messi, Wilfried Zaha and Jimmy Bullard. I''ve played for managers ranging from Terry Venables, Peter Reid and Sir Bobby Robson to Martin O''Neill, Fabio Capello and Jurgen Klopp. I tell you what it''s like sharing a training ground and a dressing-room with team-mates such as Lee Bowyer, Mario Balotelli and Mo Salah. I also reveal the behind-the-scenes work that went into Liverpool''s Champions League success - and the celebrations that followed.So this isn''t an autobiography. The whole point of Ask A Footballer is that you, the fans, asked me questions and I have used my own experiences to answer them. I hope you like it, and don''t find it too boring.',12,1,9781529404937,'2019-10-31');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Legacy','Illusions shatter—and Sophie and her friends face impossible choices—in this astonishing eighth book in the New York Times and USA TODAY bestselling Keeper of the Lost Cities series. 

Sophie Foster wants answers. But after a lifetime of lies, sometimes the truth is the most dangerous discovery. Even the smallest secret comes with terrifying new responsibilities. 
 
And Sophie’s not the only one with blank spots in her past, or mysteries surrounding her family. She and her friends are part of something much bigger than they imagined—and their roles have already been chosen for them.
 
Every clue drags them deeper into the conspiracy. Every memory forces them to question everything—especially one another. And the harder they fight, the more the lines blur between friend and enemy.',25,1,9781534427358,'2019-11-05');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Platform: Get Noticed in a Noisy World','As the former chairman and CEO of Thomas Nelson Publishers, author Michael Hyatt gained insight on the importance of combining compelling products with a meaningful platform. Now, with nearly three hundred thousand followers on Twitter, his large and growing platform serves as the foundation for his own successful writing, speaking, and business coaching practice. In this straightforward how-to, he offers down-to-earth guidance on crafting an effective and meaningful online platform to help readers extend their influence, monetize it, and build a sustainable career.Social media technologies have provided unprecedented opportunities for getting noticed and earning money in an increasingly noisy world. Platform goes behind the scenes into the world of social media success. You’ll discover what bestselling authors, public speakers, entrepreneurs, musicians, and other creatives are doing differently to gain contacts, connections, and followers and win customers in today’s crowded marketplace. With proven strategies, easy-to-replicate formulas, and practical tips, this book makes it easier, less expensive, and more possible than ever to stand out from the crowd and launch a business.',45,1,9781595555045,'2012-05-21');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Financial Statements, Revised and Expanded Edition: A Step-by-Step Guide to Understanding and Creating Financial Reports','Now the best-selling book of its kind has gotten even better.This revised and expanded second edition of Ittelson’s master work will give you that firm grasp of “the numbers” necessary for business success. With more than 100,000 copies in print, Financial Statements is a perfect introduction to financial accounting for non-financial managers, stock-market investors, undergraduate business and MBA students, lawyers, lenders, entrepreneurs, and more.Most introductory finance and accounting books fail either because they are written “by accountants for accountants” or the authors “dumb down” the concepts until they are virtually useless. Financial Statements deftly shows that all this accounting and financial-reporting stuff is not rocket science and that you can understand it! Ittelson empowers non-financial managers by clearly and simply demonstrating how the balance sheet, income statement and cash flow statement work together to offer a “snapshot” of any company’s financial health. Every term is defined in simple, understandable language. Every concept is explained with a basic, straightforward transaction example. And with the book’s uniquely visual approach, you’ll be able to see exactly how each transaction affects the three key financial statement of the enterprise.Two new major sections with nine new chapters were added to this revised second edition of Financial Statements, simply the clearest and most comprehensive introduction to financial reporting available.',55,1,9781601638618,'2009-08-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Goals!: How to Get Everything You Want -- Faster Than You Ever Thought Possible, Edition 2','Why do some people achieve all their goals while others simply dream of having a better life? With over 640,000 copies sold of this classic book on how to set and achieve goals comes the newest edition by bestselling author and motivational speaker Brian Tracy.
 
The path from frustration to fulfillment has already been discovered. Hundreds of thousands—even millions—of people started with nothing and achieved great success. In this book, Tracy presents a simple, powerful, and effective system for setting and achieving goals—a method that has been used by more than one million people to achieve extraordinary things.
 
Using the twenty-one strategies Tracy outlines, you''ll be able to accomplish any goal you set for yourself—no matter how big. You''ll discover how to determine your own strengths, what you truly value in life, and what you really want to accomplish in the years ahead. Tracy shows how to build your self-esteem and self-confidence, approach every problem or obstacle effectively, overcome difficulties, respond to challenges, and continue forward toward your goals, no matter what happens. Most importantly, you''ll learn a system for achievement that you will use for the rest of your life.',56,1,9781605099408,'2010-08-09');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Walking Dead: Compendium 1','The Walking Dead Compendium Vol. 1 is here, collecting issues 1-48!Now''s your chance to experience this gripping read for the first time or catch up on the tale with the first four years worth of material, collected in one volume for the first time.Since 2003, Robert Kirkman''s The Walking Dead has been redefining the survival horror genre with its unique and vivid account of life after the end of the world. Although the cast is diverse and often changing (including, of course, a great number of zombies), at the heart of every tale is Rick Grimes: former police officer, husband, father, and de facto leader of a ragtag band of survivors looking to make a future for themselves in a world that no longer has one. To call The Walking Dead a zombie tale is accurate to a point, but it touches on only one facet of a story that asks timeless questions about what it means to live. It also asks whether or not this is possible in a world full of the dead. This is a great opportunity to experience this gripping read for the first time or catch up on the tale with the first four years worth of material, collected in one volume for the first time. Collects Volumes 1-8.',57,1,9781607066309,'2009-05-19');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Attack on Titan: Volume 13','NO SAFE PLACE LEFT At great cost to the Garrison and the Survey Corps, Commander Erwin has managed to recover Eren from the Titans who tried to carry him off. But during the battle, Eren manifested yet another power he doesn''t understand. As Eren and Krista find new enemies, the Survey Corps faces threats from both inside and outside the walls. And what will happen to Ymir, now that she has decided to make herself the Titans'' prize?',58,1,9781612626864,'2014-07-31');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Antiques Chop','"One of the funniest cozy series going." --Ellery Queen Mystery Magazine

Brandy Borne and her dramatically ditzy mother, Vivian, are stars of the new reality show, Antiques Sleuths. The season opens in a perfect location--a quaint old house echoing with the unsolved whispers of a 60-year-old axe murder. But when the show''s producer meets a similarly grisly end, Brandy and Mother must chop around for clues, axe the right questions, and get the edge on a murderer''s mysterious motives. Otherwise our sharp-witted sleuths may face cancellation--on the cutting room floor!

Don''t miss Brandy Borne''s tips on antiques!

Praise for Barbara Allan and the Trash ''n'' Treasures Mystery Series. . .

"Thrills, laugh-out-loud moments and amazingly real relationships." --Romantic Times Book Reviews

"The characters shine with brassy humor." --Publishers Weekly

"You''ll laugh out loud." --Mystery Scene',27,1,9781617730436,'2014-04-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Strawberry Shortcake Murder','In her debut mystery, Chocolate Chip Cookie Murder, intrepid amateur sleuth and bakery owner Hannah Swensen proved that when it comes to crime, nothing is sweeter than a woman who knows how to really mix it up. Now, the flame-haired, tart-talking (and baking) heroine is back, judging a contest where the competition is really murder.

Strawberry Shortcake Murder 

When the president of Hartland Flour chooses cozy Lake Eden, Minnesota, as the spot for their first annual Dessert Bake-Off, Hannah is thrilled to serve as the head judge. But when a fellow judge, Coach Boyd Watson, is found stone-cold dead, facedown in Hannah''s celebrated strawberry shortcake, Lake Eden''s sweet ride to fame turns very sour indeed.

Between perfecting her Cheddar Cheese Apple Pie and Chocolate Crunchies, Hannah''s snooping into the coach''s private life and not coming up short on suspects. And could Watson''s harsh criticism during the judging have given one of the contestants a license to kill? The stakes are rising faster than dough, and Hannah will have to be very careful, because somebody is cooking up a recipe for murder. . .with Hannah landing on the "necessary ingredients" list.


"Another delicious adventure. . .a superior cozy sure to leave readers satisfied. . .but hungry for more." --Publishers Weekly


Includes seven delicious recipes!',27,1,9781617731259,'2011-10-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Getting Away Is Deadly: An Ellie Avery Mystery','With swollen feet and swelling belly, pregnant Ellie bravely joins the nation''s tourists in seeing the sights in Washington, D.C. But a fatal incident at the Metro station convinces Ellie that something is rotten in the capital city. Should she do the safe thing and pack her bags? Not likely when too many people are telling lies, hiding secrets, and acting suspiciously. Luckily, Ellie Avery is just the right woman to clean up the most mysterious cases of murder--even if she has to brave the most dangerous byways in the corridors of power . . .




Don''t miss Ellie Avery''s top-notch tips for great vacations!



Praise for Sara Rosett and her Mom Zone Mysteries. . .



"Crackles with intrigue, keeps you turning pages."
--Alesia Holliday



"Sharp writing, tight plotting, a fascinating peek into the world of military wives. Jump in!"
--Cynthia Baxter



"The stunning conclusion should delight readers."
--Romantic Times',28,1,9781617734076,'2009-03-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Antiques Con','"Endlessly amusing."--Kirkus Reviews

Small-town sleuths Brandy and Vivian Borne--with their trusty shih tzu, Sushi--head for a Big Apple comics convention to sell a rare 1940s Superman drawing. When an intruder breaks into their hotel suite, their madcap Manhattan misadventure is only beginning. Soon the out-of-towners stumble onto a murder victim impaled by a pen-shaped award. Villains abound--from cartoonists to crime bosses--creating a jumble of clues. Brandy and Vivian will leave no comic-book page unturned in their race to trap a ruthless killer. 

Don''t miss Brandy Borne''s tips on antiques!',27,1,9781617738760,'2015-04-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Mega Man #1','The future looks bright when brilliant and benevolent Dr. Light unveils his latest creations: the Robot Masters! But when the nefarious Dr. Wily steals them for his own sinister purposes, there is no one left to stop him.',59,1,9781619882171,'2011-05-04');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Eat That Frog!: 21 Great Ways to Stop Procrastinating and Get More Done in Less Time, Edition 3','It''s time to stop procrastinating and get more of the important things done! After all, successful people don''t try to do everything. They focus on their most important tasks and get those done. They eat their frogs.
 
There''s an old saying that if the first thing you do each morning is eat a live frog, you''ll have the satisfaction of knowing you''re done with the worst thing you''ll have to do all day. For Tracy, eating a frog is a metaphor for tackling your most challenging task—but also the one that can have the greatest positive impact on your life.

Eat That Frog! shows you how to organize each day so you can zero in on these critical tasks and accomplish them efficiently and effectively. The core of what is vital to effective time management is: decision, discipline, and determination. And in this fully revised and updated edition, Tracy adds two new chapters. The first explains how you can use technology to remind yourself of what is most important and protect yourself from what is least important. The second offers advice for maintaining focus in our era of constant distractions, electronic and otherwise.

This life-changing book will ensure that you get more of your important tasks done today.',56,1,9781626569430,'2017-04-17');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Complete Art of War','Collected here in this 4-in-1 omnibus are the most important books ever written on the art of war. The Art of War By Sun Tzu translated and commented on by Lionel Giles, On War by Carl von Clausewitz, The Art of War by Niccolò Machiavelli, and The Art of War by Baron De Jomini. These four books will give you as complete a view on the art of war as you can attain. This is the most important book ever written about warfare and conflict. Lionel Giles'' translation is the definitive edition and his commentary is indispensable. The Art of War can be used and adapted in every facet of your life. This book explains when and how to go to war, as well as when not to. Learn how to win any conflict whether it be on the battlefield or in the boardroom. Although Carl von Clausewitz participated in many military campaigns, he was primarily a military theorist interested in the examination of war. On War is the West''s premier work on the philosophy of war. Other soldiers before him had written treatises on various military subjects, but none undertook a great philosophical examination of war on the scale of Clausewitz''s. On War is considered to be the first modern book of military strategy. This is due mainly to Clausewitz'' integration of political, social, and economic issues as some of the most important factors in deciding the outcomes of a war. It is one of the most important treatises on strategy ever written, and continues to be required reading at many military academies. Niccolo Machiavelli considered this book his greatest achievement. Here you will learn how to recruit, train, motivate, and discipline an army. You will learn the difference between strategy and tactics. Machiavelli does a masterful job of breaking down and analyzing historic battles. This book of military knowledge belongs alongside Sun-Tzu and Clausewitz on every book shelf. Antoine-Henri Jomini was the most celebrated writer on the Napoleonic art of war. Jomini was present at most of the most important battles of the Napoleonic Wars. His writing, therefore, is the most authoritative on the subject. "The art of war, as generally considered, consists of five purely military branches,-viz.: Strategy, Grand Tactics, Logistics, Engineering, and Tactics. A sixth and essential branch, hitherto unrecognized, might be termed Diplomacy in its relation to War. Although this branch is more naturally and intimately connected with the profession of a statesman than with that of a soldier, it cannot be denied that, if it be useless to a subordinate general, it is indispensable to every general commanding an army." -Antoine-Henri Jomini',25,1,9781627931502,'2013-04-29');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Law of Success in Sixteen Lessons','The Law of Success was a precursor to Napoleon Hill''s Think and Grow Rich. Hill was well known for researching what made millionaires different from the common man. The sixteen lessons in this book perfectly crystallize everything you will need to know to succeed during these hard economic times. Many of today''s best known self help books take there core concepts form this book. The Secret, the Power of Positive Thinking, the Millionaire next door, and The Law of Attraction all take their basic premises from this landmark work. Now you can get it from the source. Once you''ve read this book you will understand what gives certain people an edge over everyone else. By following the advice laid out clearly herein you''ll be the one with an edge. It''s time to stop wondering what it''s like to be rich and start knowing. This book has changed countless lives and it can change yours! Unlike many of the other editions on the market today, this edition is complete and unabridged! Wilder Publications is a green publisher. All of our books are printed to order. This reduces waste and helps us keep prices low while greatly reducing our impact on the environment.',25,1,9781627931991,'2013-05-20');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Weight of Honor (Kings and Sorcerers--Book 3)','“An action packed fantasy sure to please fans of Morgan Rice’s previous novels, along with fans of works such as The Inheritance Cycle by Christopher Paolini…. Fans of Young Adult Fiction will devour this latest work by Rice and beg for more.”--The Wanderer, A Literary Journal (regarding Rise of the Dragons)The #1 Bestselling series!THE WEIGHT OF HONOR is book #3 in Morgan Rice’s bestselling epic fantasy series KINGS AND SORCERERS (which begins with RISE OF THE DRAGONS, a free download)!In THE WEIGHT OF HONOR, Kyra finally meets her cryptic uncle, and is shocked to discover he is not the man she expected. She embarks on a period of training which will test her stamina and her frustration, as she soon encounters the limits of her power. Unable to summon her dragon, unable to search deep within, and feeling an urgency to help in her father’s wars, Kyra doubts if she will ever become the warrior she thought she was. And when she meets a mysterious boy, more powerful than her, deep in the forest, she wonders what her future really has in store for her.Duncan must descend the peaks of Kos with his new army and, vastly outnumbered, launch a risky invasion on the capital. If he wins, waiting behind its ancient walls, he knows, will be the old king and his nest of nobles and aristocrats, all with their own agendas, all of them as quick to betray as they are to embrace. Unifying Escalon may, indeed, be harder than freeing it.Alec, in Ur, must tap his unique skills in the forge to aid the resistance if they have any chance of defending against the looming Pandesian invasion. He is awestruck when he encounters Dierdre, the strongest girl he has ever meet. The time she has a chance to make a stand against Pandesia, and as she bravely faces off, she who wonders if her father and his men will have her back this time.Alec, in Ur, must tap his unique skills in the forge to aid the resistance if they have any chance of defending against the looming Pandesian invasion. He is awestruck when he encounters Dierdre, the strongest girl he has ever met. This time she has a chance to make a stand against Pandesia, and as she bravely faces off, she wonders if her father and his men will have her back this time.Vesuvius leads his Troll nation across a vulnerable Escalon, devastating the land, while Theos, enraged at what becomes of his son, is on a rampage himself, and will not stop until all of Escalon is aflame.With its strong atmosphere and complex characters, THE WEIGHT OF HONOR is a sweeping saga of knights and warriors, of kings and lords, of honor and valor, of magic, destiny, monsters and dragons. It is a story of love and broken hearts, of deception, ambition and betrayal. It is fantasy at its finest, inviting us into a world that will live with us forever, one that will appeal to all ages and genders.Book #4 in KINGS AND SORCERERS will be published soon.“If you thought that there was no reason left for living after the end of the Sorcerer’s Ring series, you were wrong. Morgan Rice has come up with what promises to be another brilliant series, immersing us in a fantasy of trolls and dragons, of valor, honor, courage, magic and faith in your destiny. Morgan has managed again to produce a strong set of characters that make us cheer for them on every page.…Recommended for the permanent library of all readers that love a well-written fantasy.”--Books and Movie Reviews, Roberto Mattos (regarding Rise of the Dragons)“[The novel] succeeds—right from the start…. A superior fantasy…It begins, as it should, with one protagonist''s struggles and moves neatly into a wider circle of knights, dragons, magic and monsters, and destiny.…All the trappings of high fantasy are here, from soldiers and battles to confrontations with self….A recommended winner for any who enjoy epic fantasy writing fueled by powerful, believable young adult protagonists.”--Midwest Book Review, D. Donovan, eBook Reviewer (regarding Rise of the Dragons)“A plot-driven novel that’s easy to read in a weekend…A good start to a promising series.” --San Francisco Book Review (regarding Rise of the Dragons)',60,1,9781632913296,'2015-07-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('A Forge of Valor (Kings and Sorcerers--Book 4)','“An action packed fantasy sure to please fans of Morgan Rice’s previous novels, along with fans of works such as The Inheritance Cycle by Christopher Paolini…. Fans of Young Adult Fiction will devour this latest work by Rice and beg for more.”
--The Wanderer, A Literary Journal (regarding Rise of the Dragons)  The #1 Bestselling series, with over 400 five star reviews!  A FORGE OF VALOR is book #4 in Morgan Rice’s bestselling epic fantasy series KINGS AND SORCERERS (which begins with RISE OF THE DRAGONS, a free download)!  In A FORGE OF VALOR, Kyra slowly returns from the verge of death, healed by Kyle’s love and mysterious power. As he sacrifices for her, she regains her strength—yet not without a price. She presses Alva for the secret of her lineage, and he finally reveals all about her mother. Given a chance to quest to the source of her power, Kyra must make a crucial choice: whether to complete her training or journey to help her father, who wallows in the capital dungeon, his execution pending.  Aidan, Motley at his side, also strives to rescue his father, trapped in the perilous capital, while in the far corner of the kingdom, Merk, amazed by what he discovers in the Tower of Ur, braces himself against a massive troll invasion. His Tower surrounded, he must fight alongside his fellow Watchers, to defend his nation’s most precious relic.  Dierdre finds herself facing a full-fledged Pandesian invasion in her embattled city of Ur. As her precious city is destroyed all around her, she has to decide whether to escape or to make a final, heroic stand. Alec, meanwhile, finds himself at sea with his cryptic newfound friend, sailing to a land he’s never been, one even more mysterious than his companion. It is here that, finally, he learns of his destiny—and of the last hope for Escalon.  With its strong atmosphere and complex characters, A FORGE OF VALOR is a sweeping saga of knights and warriors, of kings and lords, of honor and valor, of magic, destiny, monsters and dragons. It is a story of love and broken hearts, of deception, ambition and betrayal. It is fantasy at its finest, inviting us into a world that will live with us forever, one that will appeal to all ages and genders.  Book #5 in KINGS AND SORCERERS will be published soon.   “If you thought that there was no reason left for living after the end of the Sorcerer’s Ring series, you were wrong. Morgan Rice has come up with what promises to be another brilliant series, immersing us in a fantasy of trolls and dragons, of valor, honor, courage, magic and faith in your destiny. Morgan has managed again to produce a strong set of characters that make us cheer for them on every page.…Recommended for the permanent library of all readers that love a well-written fantasy.”
--Books and Movie Reviews, Roberto Mattos (regarding Rise of the Dragons)',60,1,9781632913821,'2015-09-07');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Night of the Bold (Kings and Sorcerers--Book 6)','“An action packed fantasy sure to please fans of Morgan Rice’s previous novels, along with fans of works such as The Inheritance Cycle by Christopher Paolini…. Fans of Young Adult Fiction will devour this latest work by Rice and beg for more.” 
 --The Wanderer, A Literary Journal (regarding Rise of the Dragons) 
 
 The #1 Bestselling series, with over 400 five star reviews on Amazon! 
 
 NIGHT OF THE BOLD is book #6—and the final installment—in Morgan Rice’s bestselling epic fantasy series KINGS AND SORCERERS (which begins with RISE OF THE DRAGONS, a free download)! 
 
 In NIGHT OF THE BOLD, Kyra must find a way to free herself from Marda and return to Escalon with the Staff of Truth. If she does, awaiting her will be the most epic battle of her life, as she will need to face off against Ra’s armies, a nation of trolls, and a flock of dragons. If her powers, and the weapon, are strong enough, her mother awaits her, ready to reveal the secrets of her destiny, and of her birth.
 
 Duncan must make an epic stand against Ra’s armies once and for all. Yet even as he fights the greatest battles of his life, leading to a final stand in The Devil’s Gluch, he cannot expect the dark trickery that Ra has awaiting him.
 
 In the Bay of Death, Merk and King Tarnis’ daughter must join forces with Alec and the warriors of the Lost Isles to fight off the dragons. They must find Duncan and unite to save Escalon, yet Vesuvius has resurfaced, and they cannot anticipate the treachery awaiting them.
 
 In the epic finale to Kings and Sorcerers, the most dramatic battles, weapons and sorcery all lead to a breathtaking, unexpected conclusion, filled with both heartbreaking tragedy and inspiring re-birth.
 
 With its strong atmosphere and complex characters, NIGHT OF THE BOLD is a sweeping saga of knights and warriors, of kings and lords, of honor and valor, of magic, destiny, monsters and dragons. It is a story of love and broken hearts, of deception, ambition and betrayal. It is fantasy at its finest, inviting us into a world that will live with us forever, one that will appeal to all ages and genders. 
 
 “If you thought that there was no reason left for living after the end of the Sorcerer’s Ring series, you were wrong. Morgan Rice has come up with what promises to be another brilliant series, immersing us in a fantasy of trolls and dragons, of valor, honor, courage, magic and faith in your destiny. Morgan has managed again to produce a strong set of characters that make us cheer for them on every page.…Recommended for the permanent library of all readers that love a well-written fantasy.” 
 --Books and Movie Reviews, Roberto Mattos (regarding Rise of the Dragons)',60,1,9781632914965,'2015-11-06');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Kings and Sorcerers Bundle (Books 2 and 3)','“An action packed fantasy sure to please fans of Morgan Rice’s previous novels, along with fans of works such as The Inheritance Cycle by Christopher Paolini…. Fans of Young Adult Fiction will devour this latest work by Rice and beg for more.” --The Wanderer, A Literary Journal (regarding Rise of the Dragons) The #1 Bestselling series! A bundle of  books 2 and 3 in Morgan Rice’s #1 Bestselling fantasy series KINGS AND SORCERERS (RISE OF THE VALIANT and THE WEIGHT OF HONOR). Here are two bestselling novels, all in one convenient file. In RISE OF THE VALIANT, Kyra is sent on an urgent quest: to cross Escalon and seek out her uncle in the mysterious Tower of Ur. The time has come for her to learn about who she is, who her mother is, and to train and develop her special powers. Her father, Duncan, must lead his men south, to the great water city of Esephus, to attempt to free his fellow countrymen from the iron grip of Pandesia. Alec escapes with Marco from The Flames to find himself on the run through the Wood of Thorns, chased by exotic beasts. Merk, despite his better judgment, turns back to help the girl, and finds himself, for the first time in his life, entangled in a stranger’s affairs. Vesuvius spurs his giant as he leads the Trolls on their mission underground, attempting to bypass The Flames, while the dragon, Theos, has his own special mission on Escalon. In THE WEIGHT OF HONOR, Kyra finally meets her cryptic uncle, and is shocked to discover he is not the man she expected. She embarks on a period of training which will test her stamina and her frustration, as she soon encounters the limits of her power. Duncan must descend the peaks of Kos with his new army and, vastly outnumbered, launch a risky invasion on the capital. If he wins, waiting behind its ancient walls, he knows, will be the old king and his nest of nobles and aristocrats, all with their own agendas, all of them as quick to betray as they are to embrace. Alec, in Ur, must tap his unique skills in the forge to aid the resistance if they have any chance of defending against the looming Pandesian invasion. Merk finally enters the tower of Ur, and is stunned by what he discovers. Vesuvius leads his Troll nation across a vulnerable Escalon, devastating the land, while Theos, enraged at what becomes of his son, is on a rampage himself, and will not stop until all of Escalon is aflame. With its strong atmosphere and complex characters, KINGS AND SORCERERS is a sweeping saga of knights and warriors, of kings and lords, of honor and valor, of magic, destiny, monsters and dragons. It is fantasy at its finest, inviting us into a world that will live with us forever, one that appeals to all ages and genders.',60,1,9781632915740,'2016-02-25');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Riley Paige Mystery Bundle: Once Gone (#1) and Once Taken (#2)','A bundle of books #1 (ONCE GONE) and #2 (ONCE TAKEN) in Blake Pierce’s Riley Paige Mystery series—a #1 bestseller with over 400 five star reviews! This bundle offers books one and two in one convenient file, with over 100,000 words of reading. In ONCE GONE, women are turning up dead in the rural outskirts of Virginia, killed in grotesque ways, and when the FBI is called in, they are stumped. A serial killer is out there, his frequency increasing, and they know there is only one agent good enough to crack this case: Special Agent Riley Paige. Riley is on paid leave herself, recovering from her encounter with her last serial killer, and, fragile as she is, the FBI is reluctant to tap her brilliant mind. Yet Riley, needing to battle her own demons, comes on board, and her hunt leads her through the disturbing subculture of doll collectors, into the homes of broken families, and into the darkest canals of the killer’s mind. As Riley peels back the layers, she realizes she is up against a killer more twisted than she could have imagined. In ONCE TAKEN, women are being murdered in upstate New York, their bodies found mysteriously hanging in chains. With the FBI called in, given the bizarre nature of the murders—and the lack of any clues—there is only one agent they can turn to: Special Agent Riley Paige. Riley, reeling from her last case, is reluctant to take on a new one, since she is still convinced a former serial killer is out there, stalking her. She knows, though, that her ability to enter a serial killer’s mind and her obsessive nature is what will be needed to crack this case, and she just can’t refuse—even if it will push her over the edge. Dark psychological thrillers with heart-pounding suspense, the Riley Paige mysteries are a riveting new series—with a beloved new character—that will leave you turning pages late into the night. Book #3 in the series, ONCE CRAVED, is now also available.',36,1,9781632917072,'2016-06-16');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Rogue, Prisoner, Princess (Of Crowns and Glory—Book 2)','“Morgan Rice has come up with what promises to be another brilliant series, immersing us in a fantasy of valor, honor, courage, magic and faith in your destiny. Morgan has managed again to produce a strong set of characters that make us cheer for them on every page.…Recommended for the permanent library of all readers that love a well-written fantasy.”
--Books and Movie Reviews, Roberto Mattos (regarding Rise of the Dragons) ROGUE, PRISONER, PRINCESS is book #2 in Morgan Rice’s bestselling epic fantasy series OF CROWNS AND GLORY, which begins with SLAVE, WARRIOR, QUEEN (Book #1). 17 year old Ceres, a beautiful, poor girl from the Empire city of Delos, finds herself forced, by royal decree, to fight in the Stade, the brutal arena where warriors from all corners of the world come to kill each other. Pitted against ferocious opponents, her chances of survival are slim. Her only chance lies in drawing on her innermost powers, and making the transition, once and for all, from slave to warrior. 18 year old Prince Thanos wakes on the isle of Haylon to discover he has been stabbed in the back by his own people, left for dead on the blood-soaked beach. Captured by the rebels, he must crawl his way back to life, find who tried to assassinate him, and seek his revenge. Ceres and Thanos, a world apart, have not lost their love for each other; yet the Empire court teems with lies, betrayal and duplicity, and as jealous royals weave intricate lies, they each, in a tragic misunderstanding, are led to believe the other is dead. The choices they make will determine each other’s fate. Will Ceres survive the Stade and become the warrior she was meant to be? Will Thanos heal and discover the secret being withheld from him? Will the two of them, forced apart, find each other again? ROGUE, PRISONER, PRINCESS tells an epic tale of tragic love, vengeance, betrayal, ambition, and destiny. Filled with unforgettable characters and heart-pounding action, it transports us into a world we will never forget, and makes us fall in love with fantasy all over again. “An action packed fantasy sure to please fans of Morgan Rice’s previous novels, along with fans of works such as The Inheritance Cycle by Christopher Paolini…. Fans of Young Adult Fiction will devour this latest work by Rice and beg for more.”
--The Wanderer, A Literary Journal (regarding Rise of the Dragons) Book #3 in OF CROWNS AND GLORY will be released soon!',60,1,9781632918031,'2016-08-03');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('A Trace of Vice (a Keri Locke Mystery--Book #3)','“A dynamic story line that grips from the first chapter and doesn''t let go.” --Midwest Book Review, Diane Donovan (regarding Once Gone) From #1 bestselling mystery author Blake Pierce comes a new masterpiece of psychological suspense. In A TRACE OF VICE (Book #3 in the Keri Locke mystery series), Keri Locke, Missing Persons Detective in the Homicide division of the LAPD, follows a fresh lead for her abducted daughter. It leads to a violent confrontation with The Collector—which, in turn, offers more clues that may, after all this time, reunite her with her daughter. Yet at the same time, Keri is assigned a new case, one with a frantic ticking clock. A teenage girl has gone missing in Los Angeles, a girl from a good family was who duped into drugs and abducted into a sex trafficking ring. Keri is hot on her trail—but the trail is moving fast, with the girl being constantly moved and with her abductors’ single, nefarious goal: to cross her over the border with Mexico. In an epic, breathtaking, cat and mouse chase that takes them through the seedy underworld of trafficking, Keri and Ray will be pushed to their limits to save the girl—and her own daughter—before it is all too late. A dark psychological thriller with heart-pounding suspense, A TRACE OF VICE is book #3 in a riveting new series—and a beloved new character—that will leave you turning pages late into the night. “A masterpiece of thriller and mystery! The author did a magnificent job developing characters with a psychological side that is so well described that we feel inside their minds, follow their fears and cheer for their success. The plot is very intelligent and will keep you entertained throughout the book. Full of twists, this book will keep you awake until the turn of the last page.” --Books and Movie Reviews, Roberto Mattos (re Once Gone) Book #4 in the Keri Locke series is also now available!',36,1,9781640290112,'2017-06-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('A Trace of Crime (a Keri Locke Mystery--Book #4)','“A dynamic story line that grips from the first chapter and doesn''t let go.” --Midwest Book Review, Diane Donovan (regarding Once Gone) From #1 bestselling mystery author Blake Pierce comes a new masterpiece of psychological suspense. In A TRACE OF CRIME (Book #4 in the Keri Locke mystery series), Keri Locke, Missing Persons Detective in the Homicide division of the LAPD, follows a fresh lead for her abducted daughter. She winds her way through a twisted underworld, and step by step, she gets closer to finding her daughter. Yet she has no time. Keri is assigned a new case: a dad calls from an affluent community and reports that his teen daughter vanished on the way home from school. Shortly after, ransom letters arrive. Twisted, filled with riddles, they make it clear that there is little time to save the girl. They also make it clear that this is the work of a diabolical killer who is toying with them. Keri and the police must scramble to find the kidnapper, to understand his demands, to decode the letters, and most of all, to outwit him. But in this master game of chess, Keri may find herself up against a foe even she cannot understand, and for the missing girl—and her own daughter—she may just be too late. A dark psychological thriller with heart-pounding suspense, A TRACE OF CRIME is book #4 in a riveting new series—and a beloved new character—that will leave you turning pages late into the night. “A masterpiece of thriller and mystery! The author did a magnificent job developing characters with a psychological side that is so well described that we feel inside their minds, follow their fears and cheer for their success. The plot is very intelligent and will keep you entertained throughout the book. Full of twists, this book will keep you awake until the turn of the last page.” --Books and Movie Reviews, Roberto Mattos (re Once Gone) Book #5 in the Keri Locke series is also now available!',36,1,9781640291102,'2017-10-20');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Watching (The Making of Riley Paige—Book 1)','“A masterpiece of thriller and mystery! The author did a magnificent job developing characters with a psychological side that is so well described that we feel inside their minds, follow their fears and cheer for their success. The plot is very intelligent and will keep you entertained throughout the book. Full of twists, this book will keep you awake until the turn of the last page.” --Books and Movie Reviews, Roberto Mattos (re Once Gone) 
 WATCHING (The Making of Riley Paige—Book One) is book #1 in a new psychological thriller series by #1 bestselling author Blake Pierce, whose  free bestseller Once Gone (Book #1) has received over 1,000 five star reviews.
 22 year old psychology major—and aspiring FBI agent—Riley Paige finds herself in a battle for her life as her closest friends on campus are abducted and killed by a serial killer. She senses that she, too, is being targeted—and that if she is to survive, she must apply her brilliant mind to stop the killer herself.
 When the FBI hits a dead end, they are impressed enough by Riley’s keen insight into the killer’s mind to allow her to help. Yet the killer’s mind is a dark, twisted place, one too diabolical to make sense of, and one that threatens to bring Riley’s fragile psyche crashing down. In this deadly game of cat and mouse, can Riley survive unscarred?
 An action-packed thriller with heart-pounding suspense, WATCHING is book #1 in a riveting new series that will leave you turning pages late into the night. It takes readers back 20 plus years—to how Riley’s career began—and is the perfect complement to the ONCE GONE series (A Riley Paige Mystery), which includes 13 books and counting.
 Book #2 in THE MAKING OF RILEY PAIGE series is also now available!',36,1,9781640294127,'2018-05-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Once Missed (A Riley Paige Mystery—Book 16)','“A masterpiece of thriller and mystery! The author did a magnificent job developing characters with a psychological side that is so well described that we feel inside their minds, follow their fears and cheer for their success. The plot is very intelligent and will keep you entertained throughout the book. Full of twists, this book will keep you awake until the turn of the last page.”--Books and Movie Reviews, Roberto Mattos (re Once Gone) ONCE MISSED is book #16 in the bestselling Riley Paige mystery series, which begins with the #1 bestseller ONCE GONE (Book #1)—a free download with over 1,000 five star reviews! A serial killer is striking seemingly at random, first killing a man in his 50s, then a woman in her 50s. The only thing that links them is the lone souvenir he took: a dining chair. What is the meaning? Are the murders random after all? FBI Special Agent Riley Paige must fend off her own demons and her own dysfunctional family life as she races against time to enter the mind of a diabolical killer who is sure to strike again. Will she stop him in time? An action-packed psychological suspense thriller with heart-pounding suspense, ONCE MISSED is book #16 in a riveting series—with a beloved character—that will leave you turning pages late into the night.
BOOK #17--ONCE CHOSEN--is also now available for pre-order!',36,1,9781640297579,'2019-10-29');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('That Time I got Reincarnated as a Slime 11','Mikami’s middle age hasn’t gone as he planned: He never found a girlfriend, he got stuck in a dead-end job, and he was abruptly stabbed to death in the street at 37. So when he wakes up in a new world straight out of a fantasy RPG, he’s disappointed but not exactly surprised to find that he’s facing down a dragon, not as a knight or a wizard but as a blind slime demon. But there are chances for even a slime to become a hero…',61,1,9781646590797,'2019-10-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Wrecking Ball (Diary of a Wimpy Kid Book 14)','In Wrecking Ball, Book 14 of the Diary of a Wimpy Kid series—from #1 international bestselling author Jeff Kinney—an unexpected inheritance gives Greg Heffley’s family a chance to make big changes to their house. But they soon find that home improvement isn’t all it’s cracked up to be.

 Once the walls come down, all sorts of problems start to crop up. Rotten wood, toxic mold, unwelcome critters, and something even more sinister all make Greg and his family wonder if the renovations are worth the trouble. When the dust finally settles, will the Heffleys be able to stay . . . or will they need to get out of town?

 And don’t miss Diary of an Awesome Friendly Kid: Rowley Jefferson’s Journal—the instant #1 bestseller—told from Greg''s best friend Rowley’s perspective!',62,1,9781683356950,'2019-11-05');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('We','Yevgeny Zamyatin''s We is set in an urban glass city called OneState, regulated by spies and secret police. Citizens of the tyrannical OneState wear identical clothing and are distinguished only by the number assigned to them at birth. The story follows a man called D-503, who dangerously begins to veer from the ''norms'' of society after meeting I-330, a woman who defies the rules. D-503 soon finds himself caught up in a secret plan to destroy OneState and liberate the city.

The failed utopia of We has been compared to the works of H.G. Wells, George Orwell, and Aldous Huxley. It was the first novel banned by the Soviets in 1921, and was finally published in its home country over a half-century later. 

We is a part of Momentum''s Classic Science Fiction series.

"The best single work of science fiction yet written." — Ursula K. Le Guin',63,1,9781743341490,'2013-01-15');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Watchmen (2019 Edition)','Soon to be an HBO original series, Watchmen, the groundbreaking series from award-winning author Alan Moore, presents a world where the mere presence of American superheroes changed history--the U.S. won the Vietnam War, Nixon is still president, and the Cold War is in full effect. Considered the greatest graphic novel in the history of the medium, the Hugo Award-winning story chronicles the fall from grace of a group of superheroes plagued by all-too-human failings. Along the way, the concept of the superhero is dissected as an unknown assassin stalks the erstwhile heroes. This edition of Watchmen, the groundbreaking series from Alan Moore, the award-winning writer of V For Vendetta and Batman: The Killing Joke, and features art from industry legend Dave Gibbons, with high-quality, recolored pages found in Watchmen: Abslolute Edtion.',43,1,9781779501837,'2019-06-18');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Blood Runs Cold: A completely unputdownable mystery and suspense thriller','‘YES… THIS WAS UP THERE WITH THE BEST!!!! I was hooked from the beginning, full of twists and turns that you will never see coming to keep you on the edge-of-your-seat and up all night reading.’ Goodreads reviewer, 5 stars The figure bent over the small grave and lowered in the black bag. Adult bones would have been heavier. Just a few spadefuls of earth and the secret was hidden…  On a bright spring morning, walkers find a tattered plastic bag containing human remains half-buried in the rolling hills of Somerset. The bones belong to Rosie Dawson, a little girl who disappeared ten years ago. Detective Anna Gwynne is back at work after a case that nearly cost her her life. The trail is stone cold, but Anna will stop at nothing to find the killer, and escape thoughts of her own dark past. Then another little girl is abducted near a river bank on the hottest day of the year, and her sister can’t remember anything about the man who took her. Nobody thinks the cases are connected, but then Anna finds a photo of her that matches an old one of Rosie. In the same dark room. The same concrete walls. The same stony floor.  The killer is bragging.  With just two photos and a witness too young to help, can Anna find the killer in time to save a little girl’s life? A heart-pounding thriller that will get right under your skin. If you love Karin Slaughter, Robert Dugoni and Angela Marsons you’ll love this killer crime thriller. What readers are saying about Blood Runs Cold: ‘I found myself on the edge-of-my-seat, not wanting it to end… Gripped me from beginning to end.’ Goodreads reviewer, 5 stars ‘Completely hooked… a jumbo-pack of plot twists… one hell of a ride… I was unable to function normally until I reached the final page and found out the truth… action-packed, suspenseful and will chill you to the bone.’ It’s All About Books, 5 stars ‘Bloody brilliant... towards the end I’m like please find the girl, please find the girl... I was on the edge-of-my-seat thinking OMG please find the girl!’ Bonnie’s Book Talk ‘Truly fantastic… Utterly gripping and compelling edge-of-your-seat stuff that had me glued to the pages.’ Novel Deelights, 5 stars ‘Spine-tingling… plenty of suspense and tension to keep you interested right till the end and I didn’t work out “whodunnit” until it was revealed! A great crime and police procedural story!’ Stardust Book Reviews ‘A compelling, complex, fast paced plot with interesting characters and lots of twists. Highly recommended.’ Humble Tart Kitchen ‘COMPLETELY UNPUTDOWNABLE!… just the way I like them.’ Goodreads reviewer, 5 stars ‘I knew as soon as I started reading that I was going to be gripped and the housework would have to wait… compulsive reading.’ Goodreads reviewer, 5 stars ‘I literally needed matchsticks to hold my eyelids open, Blood Runs Cold snatched every breath I took, intensifying my need to turn the pages and absorb the narrative in huge chunks…. A stylishly dark and an intensely heinous suspenseful thriller which will turn your world upside down.’ Sweet Little Book Blog ‘Boy oh boy this was one fantastic unpredictable rollercoaster ride of a read… I totally and utterly flipping well loved this book.’ Ginger Book Geek, 5 stars ‘Chilling and unnerving… had me guessing up until near the end… a real page turner… you will see why when you read it.’ Goodreads reviewer, 5 stars  ‘Like a slow burning fire. Starts out small and turns into an inferno. The intensity in this book just kept building and building. I never guessed who the killer was, not one time.’ Goodreads reviewer',64,1,9781786814029,'2018-05-16');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('God of War: The Official Novelization','The novelization of the highly anticipated God of War 4 game.
His vengeance against the Gods of Olympus years behind him, Kratos now lives as a man in the realm of Norse gods and monsters. It is in this harsh, unforgiving world that he must fight to survive... and teach his son to do the same. This startling reimagining of God of War deconstructs the core elements that defined the series—satisfying combat; breathtaking scale; and a powerful narrative—and fuses them anew.',65,1,9781789090154,'2018-08-28');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('You''ll Never See Daylight Again','Michaella was just a regular girl, spending the summer working at a bar in Ibiza, until she was approached by a man who asked her if she''d like to make some quick, easy money...and her decision would change her life forever. Her image was broadcast all over the world, as half of the infamous Peru Two, after she was caught and imprisoned for attempting to smuggle 11kg of cocaine from Peru to Madrid. You''ll Never See Daylight is the gritty true story of Michaella''s time in a Peruvian prison - recounting tales of vicious guards, psychotic inmates and horrendous prison conditions - and the struggles she faced as she attempted to rebuild her life among such scandal and notoriety.
 
 You''ll Never See Daylight is a brilliantly affecting and redemptive tale of a naïve young girl who comes of age in the dark heart of Peru.',66,1,9781789460148,'2019-10-31');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Empty Nest: An unputdownably gripping psychological thriller','‘Sometimes we can’t see what’s right in front of us, Kat. Everyone has secrets, even the people we love, the people we live with…’
Kat remembers the days when her only daughter Amy wouldn''t leave her side. Amy was the baby who cried when you walked out of the room, the toddler who was too shy to speak to strangers, the small child who clung to Kat''s legs in the school playground.
But now Amy is grown up, and Amy is gone – to university in a town several hours away. Kat''s house – which once felt too full, too noisy, too busy – is deathly quiet, and Kat awaits the daily phone call to tell her that her beloved daughter is thriving and happy. 
Until the day Amy doesn’t call, sending Kat into a panic. Her husband and friends say she’s being paranoid – surely Amy is just out, having fun? But Kat feels sure something is very wrong – she knows her daughter, and she would never just disappear. 
As the hours turn into days, her fears are confirmed: Amy is missing. But there are secrets about her daughter that Kat doesn''t know about yet. And the truth about Amy''s whereabouts may be closer to home than Kat could ever imagine...
A gripping and suspenseful psychological thriller with more twists and turns than a rollercoaster and an ending that will blow readers’ minds. Fans of The Wife Between Us, The Girl Before and Gone Girl will be gripped by this unputdownable story about a mother’s obsessive love for her child.
Readers are loving The Empty Nest:‘OMG… I couldn’t believe the ending and what truly happened to Kat’s daughter. There were so many twists and turns in this book but the ending blew my mind.’ Goodreads Reviewer ⭐⭐⭐⭐⭐ ‘Wow I never saw that ending!... A huge rollercoaster of events that will keep you enthralled right to the end!... Great read.’ Goodreads Reviewer ⭐⭐⭐⭐⭐ ‘A full on, straight into it thriller, with a banging twist and a satisfying end! A quickfire ever changing story of who has done what and why… It had me foxed and I got it completely wrong… So well written, full of drama and just a perfect read. 10/10.’ Goodreads Reviewer ⭐⭐⭐⭐⭐
‘What an amazing book. I couldn''t put it down. Had my attention from start to finish… Just when I thought I had it figured out I was proven wrong.’ Goodreads Reviewer ⭐⭐⭐⭐⭐ ‘A compulsively readable mystery that kept me fully engrossed and turning pages long into the night. This is a twisty thriller that kept me guessing right up until the final page… Brilliantly executed… Thoroughly addictive.’ Goodreads Reviewer ⭐⭐⭐⭐⭐ ‘I was so gobsmacked… The Empty Nest is a story steeped in secrets and lies. The suspense and tension surrounding Amy’s disappearance builds up wonderfully and had me totally hooked, tearing through the pages to see just what had happened to her.’ By the Letter Book Reviews ⭐⭐⭐⭐⭐
‘An addictive, suspenseful thriller that kept me on the edge of my seat from start to finish… This story is filled with lies, betrayal, and shocking secrets. The author does a wonderful job building the tension and the ending was clever and satisfying. I highly recommend this twisty thriller.’ Goodreads Reviewer ⭐⭐⭐⭐⭐
‘This book was fast paced. Hard to put down. It flowed well and it was very well written. It caught hold of me and had me hooked from the start. I was literally on the edge of my seat reading this book.’ Goodreads Reviewer ⭐⭐⭐⭐
‘Sue Watson is an amazing storyteller… She perfectly wove together a web of lies, paranoia, deceit, and friendship that created a rollercoaster of a ride from start to finish. This really is such a compulsive read, building the tension and a brilliant ending… A real unputdownable book.’ Goodreads Reviewer ⭐⭐⭐⭐⭐
‘Keeps the reader guessing as to what happened.... Each time you think you know where the story is going, something changes… Very difficult to put down.’ NetGalley Reviewer ⭐⭐⭐⭐⭐
‘A brilliant addictive psychological thriller, full of twists and turns… It kept me on the edge of my seat throughout… Compulsive reading.’ NetGalley Reviewer ⭐⭐⭐⭐⭐',64,1,9781838880415,'2019-11-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Last Wife: An absolutely gripping and emotional page turner with a brilliant twist','‘This was SOME read. Now I know what it means when people say a book was unputdownable. I just had to finish this in one sitting. It was just too good to wait until the next day… You will NOT want to miss this... Ten stars definitely!’ Netgalley reviewer, 5 stars
Trusting his family was her first mistake.
All Ria ever wanted was a family. Growing up alone in foster care, she imagined just how it would be. So when she fell in love with Grayson and had their daughter Shelley, she was determined to make his family love her too. She knew she’d never fit in with her glamorous sisters-in-law, or at the exclusive picture-perfect Chicago parties her mother-in-law threw, but with Grayson’s arm around her waist she tried her best to be a Parker.
Everything changed when Grayson disappeared.
Until one morning, Grayson leaves the house for work and never comes home. Left to raise Shelley alone, Ria is forced to turn to her husband’s family, to let her intimidating mother-in-law into her life, allow her to babysit Shelley, and accept her financial support. She tries to ignore the feeling that her sisters-in-law never thought she was good enough. They say they have no idea what happened to Grayson, and she tries very hard to believe them.
But Ria is about to learn that every Parker wife has secrets.
And protecting her daughter might come at a terrible price…
From USA Today bestseller Nicola Marsh. Utterly compelling, The Last Wife is an emotionally-charged novel about what one woman will do to survive. Perfect for fans of Liane Moriarty, Kerry Fisher and The Other Woman.
Readers love The Last Wife!‘I was hooked from the thrilling prologue straight through to that jaw-dropping finale!... Drew me in and left me craving for more… Domestic suspense that''ll easily have you swiping your night away.’ Misty’s Corner Reviews, 5 stars
‘WOW. I cannot say enough about this book! This book was the definition of a page turner – the plot twists kept me hooked up until the very end! Goodreads reviewer
‘What an amazing book. I couldn''t put it down. Had my attention from start to finish. plenty of suspense and twists and turns. Just when I thought I had it figured out I was proven wrong.’ Goodreads reviewer, 5 stars‘Gripped right from the start, I couldn’t turn the pages on my kindle fast enough. Everything immediately drew me in… Taken on a wild addictive ride and what a bloody great ride it is!... Wickedly twisted, highly addictive, utterly deceptive and I absolutely loved it!’ Once Upon A Time Book Blog, 5 stars
‘Wow. Just wow. From beginning to end you had no idea where this book was going… This is a must read book… At one point you are yelling at the book because darn it tell me, the ending had me shook. I was quaking. Definitely not what I was expecting.’ Goodreads reviewer, 5 stars
‘Deliciously good! I could hardly put it down. The family dynamics in this salacious drama feel like the best reality show mixed with a soap opera… I highly recommend this book to anyone.’ Goodreads reviewer, 5 stars
‘A fabulous read! There''s everything here – secrets, danger, deceit… keeps you hooked right until the last page… Not giving anything away, simply to say, this is definitely a must read.’ Brook Cottage Books, 5 stars
‘I just loved this book! My second of Nicola Marsh’s books and it did not disappoint. A domestic thriller that kept me guessing until the very end… Highly recommend.’ Chapter Chatter Pub, 5 stars
‘I have read this book in less than three hours. It was quick, sharp and full of unexpected twists. Fully recommended! I will definitely reach for more books of this author.’ Goodreads reviewer, 5 stars',64,1,9781838880514,'2019-10-11');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Introducing Critical Theory: A Graphic Guide','The last few decades have seen an explosion in the production of critical theories, with deconstructionists, poststructuralists, postmodernists, second-wave feminists, new historicists, cultural materialists, postcolonialists, black critics and queer theorists, among a host of others, all vying for our attention. The world around us can look very different on the critical theory applied to it. This vast range of interpretations can leave one feeling confused and frustrated. This book provides a route through the tangled jungle of competing theories.',67,1,9781840469097,'2004-01-01');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Art Of Seduction','Which sort of seducer could you be? Siren? Rake? Cold Coquette? Star? Comedian? Charismatic? Or Saint? 
This book will show you which. Charm, persuasion, the ability to create illusions: these are some of the many dazzling gifts of the Seducer, the compelling figure who is able to manipulate, mislead and give pleasure all at once. When raised to the level of art, seduction, an indirect and subtle form of power, has toppled empires, won elections and enslaved great minds. In this beautiful, sensually designed book, Greene unearths the two sides of seduction: the characters and the process. Discover who you, or your pursuer, most resembles. Learn, too, the pitfalls of the anti-Seducer. Immerse yourself in the twenty-four manoeuvres and strategies of the seductive process, the ritual by which a seducer gains mastery over their target. Understand how to ''Choose the Right Victim'', ''Appear to Be an Object of Desire'' and ''Confuse Desire and Reality''. In addition, Greene provides instruction on how to identify victims by type. Each fascinating character and each cunning tactic demonstrates a fundamental truth about who we are, and the targets we''ve become - or hope to win over. The Art of Seduction is an indispensable primer on the essence of one of history''s greatest weapons and the ultimate power trip.From the internationally bestselling author of The 48 Laws of Power, Mastery, and The 33 Strategies Of War.',68,1,9781847651402,'2010-09-03');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('''Salem''s Lot','''Turn off the television - in fact, why don''t you turn off all the lights except for the one over your favourite chair? - and we''ll talk about vampires here in the dim. I think I can make you believe in them.''
Stephen King, from the Introduction. ''Salem''s Lot is a small New England town with the usual quota of gossips, drinkers, weirdos and respectable folk. Of course there are tales of strange happenings - but not more than in any other town its size.Ben Mears, a moderately successful writer, returns to the Lot to write a novel based on his early years, and to exorcise the terrors that have haunted him since childhood. The event he witnessed in the house now rented by a new resident. A newcomer with a strange allure. A man who causes Ben some unease as things start to happen: a child disappears, a dog is brutally killed - nothing unusual, except the list starts to grow.Soon surprise will turn to bewilderment, bewilderment to confusion and finally to terror . . .',12,1,9781848940819,'2008-12-11');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Marine''s E-Mail Order Bride: Heroes of Chance Creek Volume 4','If Gunnery Sergeant Zane Hall wants to save his family’s ranch, he’ll need to fix up the buildings, stock the spread with cattle—and find a wife. The first two are easy with the help of his brothers, but getting hitched is proving more difficult. When he meets mountaineer Kenna North through an online ad, she seems like the perfect fit—at least in her e-mails. She wants the same thing he does: a temporary marriage to secure an inheritance. But when Zane meets Kenna, she’s nothing like he expects, and Zane finds himself changing his priorities, fast.If Storm Willow wants to save her family’s seaside cottage, she’ll have to keep her boss happy—which means taking Kenna’s place and marrying Zane when Kenna is detained out of the country.  As long as Storm acts her part, no one will know that she’s an imposter. But when she falls for the handsome Marine, Storm begins to wonder if holding onto the cottage is worth giving up on love. Can a fake marriage lead to real happiness? Or is disaster just a heartbeat away?',69,1,9781927036600,'2015-01-07');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Thirty-Five and a Half Conspiracies: Rose Gardner Mystery #8','Book eight in the New York Times and USA Today bestselling Rose Gardner Mystery series.
Rose Gardner has survived plenty of close scrapes in the past, but her latest bit of trouble has landed her in the Fenton County holding cell on trumped up charges. The most powerful man in southern Arkansas, J.R. Simmons, is determined to put her behind bars for good and destroy everything she holds dear, including her boyfriend, Mason, and her friend Skeeter, reigning king of the Fenton County crime world. In a stunning betrayal, it seems as if J.R.’s son, Rose’s ex-boyfriend, might have turned tail and joined his father.
 But Rose doesn’t have to face this fight alone. Her tight-knit group of friends is dedicated to helping her figure out—and foil—J.R.’s plan for ruining her, Mason, and Skeeter. But even with their support and the use of her special power, Rose is at a disadvantage. J.R. is a criminal mastermind who has been using his money, power, and web of influence to hide his conspiracies for years. How can she hope to find solid evidence implicating someone who’s mastered the art of not getting caught? 
Time is running out, and soon Rose realizes that reassuming her role of the Lady in Black might be her only chance at ferreting out the evidence that will save them all. In so doing, she will risk not only her life, but the possibility that her secret identity will be unveiled to all.',70,1,9781939996343,'2015-11-03');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Diabolical','From New York Times bestselling author Jana DeLeon, the third book in the Shaye Archer thriller series.Nine years ago, the police found Shaye Archer wandering in the French Quarter, beaten and abused and with no memory of the previous fifteen years, not even her name. Now, at twenty-four, Shaye is a licensed private investigator, determined to get answers for her clients when the police can’t help. But her last case uncovered more than anyone anticipated, and pieces of Shaye’s missing past have surfaced with unexpected consequences.She’s starting to remember.Will Shaye unlock the secrets buried deep in her mind? And more importantly, can she handle the truth if she does?',71,1,9781940270371,'2016-08-08');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Choice of Magic','The ancient magic of wizards was anything but dark. It was the enlightenment that lifted humanity from the squalor of superstition, and the worship of fell spirits and capricious gods, but those days are gone. The shining glory of the sorcerers burned away the subtlety of wisdom, replacing it with easy power, held only in the hands of the elite—a new age built upon the elemental supremacy of aristocrats and the ignorance of the masses.
But this will change, for the greatest power comes with knowledge, and the deeper teachings of wizardry have not been utterly lost. The last wizard of the old tradition still survives in solitude, nursing tired grudges and waiting for death.
His passing might have gone unnoticed, but for the imposition of a youth too stubborn to accept his refusal to take an apprentice. With a new student comes new hope, and that hope has caused old powers to stir again. That the world will change is inevitable, but the shape of the future is anything but certain.',72,1,9781943481316,'2019-08-16');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('Business Process Management: Concepts, Languages, Architectures, Edition 2','Business process management is usually treated from two different perspectives: business administration and computer science. While business administration professionals tend to consider information technology as a subordinate aspect in business process management for experts to handle, by contrast computer science professionals often consider business goals and organizational regulations as terms that do not deserve much thought but require the appropriate level of abstraction.Matthias Weske argues that all communities involved need to have a common understanding of the different aspects of business process management. To this end, he details the complete business process lifecycle from the modeling phase to process enactment and improvement, taking into account all different stakeholders involved. After starting with a presentation of general foundations and abstraction models, he explains concepts like process orchestrations and choreographies, as well as process properties and data dependencies. Finally, he presents both traditional and advanced business process management architectures, covering, for example, workflow management systems, service-oriented architectures, and data-driven approaches. In addition, he shows how standards like WfMC, SOAP, WSDL, and BPEL fit into the picture.This textbook is ideally suited for classes on business process management, information systems architecture, and workflow management. This 2nd edition contains major updates on BPMN Version 2 process orchestration and process choreographies, and the chapter on BPM methodologies has been completely rewritten. The accompanying website www.bpm-book.com contains further information and additional teaching material.',73,1,9783642286162,'2012-05-03');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Call of Cthulhu','The Call of Cthulhu is a story by American writer H. P. Lovecraft. The story deals with a manuscript found among the papers of the late Francis Wayland Thurston, of Boston. In the text, Thurston recounts his discovery of notes left behind by his granduncle, George Gammell Angell, a prominent Professor of Semitic languages at Brown University in Providence, Rhode Island, who died suddenly. The first chapter, The Horror in Clay, concerns a small bas-relief sculpture found among the papers, which the narrator describes: "My somewhat extravagant imagination yielded simultaneous pictures of an octopus, a dragon, and a human caricature.... A pulpy, tentacled head surmounted a grotesque and scaly body with rudimentary wings." The sculpture is the work of Henry Anthony Wilcox, a student at the Rhode Island School of Design who based the work on his delirious dreams of "great Cyclopean cities of titan blocks and sky-flung monoliths, all dripping with green ooze and sinister with latent horror."',74,1,9783736805101,'2018-10-17');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('15 Delicious Slow Cooker Recipes','This cookbook contains 15 delicious slow cooker recipes like Sweet and Sour Pork, Beef Stew, Turkey Chili, Seafood Delis and Swiss Steak.   Recipe from the cookbook:   SLOW COOKER TURKEY CHILI  Prep/cooking time: 8 hours 10 minutes Serving yield: 8 to 10  INGREDIENTS 1. Two tablespoons of vegetable oil. 2. Three tablespoons of tomato paste. 3. Three tablespoons of chili powder. 4. One tablespoon of ground cumin. 5. A half teaspoon of cayenne pepper. 6. 3/4 pound of ground turkey. 7. An adequate amount of kosher salt as a seasoning for taste. 8. One (twenty-eight ounces) can of fire-roasted diced tomatoes. 9. Two and a half cups of low-sodium chicken broth and additional for thinning the chili. 10. A quarter cup of unsweetened cocoa powder. 11. Two tablespoons of red wine vinegar. 12. One tablespoon of dried oregano. 13. Two (fifteen ounces) cans of strained and rinsed pinto beans. 14. One medium and chopped onion. 15. Two cups of crushed corn tortilla chips and a whole tortilla for serving. 16. Three chopped cloves of garlic. 17. An adequate amount of sliced scallions, shredded Cheddar, sour cream and chopped pickled jalapeno for serving.  INSTRUCTIONS 1. Place a large non-stick skillet over medium heat and add in the oil. Once the oil is hot, add in the tomato paste, chili powder, cumin, and cayenne then cook for about two minutes with a regular stir until the oil becomes brick-red in color and the mixture becomes dry. Next, add in the ground turkey and one teaspoon of salt to taste and cook for a few minutes while breaking up the turkey into smaller pieces. Don''t forget to stir until the mixture is fully combined then place into a slow cooker. 2. Next, using the same skillet over medium-high heat, add in other ingredients like the tomatoes, chicken broth, cocoa powder, vinegar, oregano and one teaspoon of salt to taste and simmer for about two minutes while whisking. Add in the tomato mixture, beans, onions, crushed tortilla chips, and garlic into the slow cooker, stir and cook for about six to eight hours on a low setting with its lid covered. 3. Add the rest of the chicken broth to the chili to thin it if desired, add salt to taste then serve the turkey chill with scallions, Cheddar, sour cream, pickled jalapeno, and tortilla chips. Enjoy.  NUTRITIONAL CONTENTS Calories 278.7, Total Fat 8.6 g, Cholesterol 66.6 mg, Sodium 853.9 mg, Potassium 527.9 mg, Total Carbohydrate 28.0 g, Dietary Fiber 9.6 g, Sugars 5.6 g, and Protein 26.0 g.',74,1,9783743895003,'2019-10-28');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Complete Works of William Shakespeare: All 213 Plays, Poems, Sonnets, Apocryphal Plays + The Biography: The Life of William Shakespeare by Sidney Lee: Hamlet - Romeo and Juliet - King Lear - A Midsummer Night’s Dream - Macbeth - The Tempest - Othello and many more','This carefully crafted ebook: “The Complete Works of William Shakespeare” is formatted for your eReader with a functional and detailed table of contents.   William Shakespeare is recognized as one of the greatest writers of all time, known for works like "Hamlet," "Much Ado About Nothing," "Romeo and Juliet," "Othello," "The Tempest," and many other works. With the 154 poems and 37 plays of Shakespeare''s literary career, his body of works are among the most quoted in literature. Shakespeare created comedies, histories, tragedies, and poetry. Despite the authorship controversies that have surrounded his works, the name of Shakespeare continues to be revered by scholars and writers from around the world.      William Shakespeare (1564 – 1616) was an English poet and playwright, widely regarded as the greatest writer in the English language and the world''s pre-eminent dramatist. He is often called England''s national poet and the "Bard of Avon". His extant works, including some collaborations, consist of about 38 plays, 154 sonnets, two long narrative poems, and a few other verses, the authorship of some of which is uncertain.',75,1,9788026804758,'2014-02-27');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('PSYCHOANALYSIS FOR BEGINNERS: A General Introduction to Psychoanalysis & Dream Psychology','This carefully crafted ebook: "PSYCHOANALYSIS FOR BEGINNERS: A General Introduction to Psychoanalysis & Dream Psychology" is formatted for your eReader with a functional and detailed table of contents. Introduction to Psychoanalysis is a set of lectures given by Sigmund Freud 1915-17, which became the most popular and widely translated of his works. The 28 lectures offered an elementary stock-taking of his views of the unconscious, dreams, and the theory of neuroses at the time of writing, as well as offering some new technical material to the more advanced reader. In these three-part Introductory Lectures, by beginning with a discussion of Freudian slips in the first part, moving on to dreams in the second, and only tackling the neuroses in the third, Freud succeeded in presenting his ideas as firmly grounded in the common-sense world of everyday experience. Freud built his complete method of psycho-analysis around his dream theories. In the book Dream Psychology: Psychoanalysis for Beginners Freud explains the buried meanings inside dreams, particularly the drive and the connection between the unconscious and conscious, blocked sexual cravings, and the significance of dreams to our overall well-being. Sigmund Freud (1856-1939) was an Austrian neurologist and the father of psychoanalysis, a clinical method for treating psychopathology through dialogue between a patient and a psychoanalyst. In creating psychoanalysis, Freud developed therapeutic techniques such as the use of free association and discovered transference, establishing its central role in the analytic process. Freud''s redefinition of sexuality to include its infantile forms led him to formulate the Oedipus complex as the central tenet of psychoanalytical theory. His analysis of dreams as wish-fulfillments provided him with models for the clinical analysis of symptom formation and the mechanisms of repression as well as for elaboration of his theory of the unconscious.',75,1,9788026850519,'2016-02-08');
INSERT INTO Book(Book_title,Book_description,Publisher_ID,Resource_type_ID,ISBN,Publication_date) VALUES ('The Art of War (The Classic Lionel Giles Translation)','This carefully crafted ebook: "The Art of War (The Classic Lionel Giles Translation)” is formatted for your eReader with a functional table of contents. The Art of War is an ancient Chinese military treatise that is attributed to Sun Tzu (also referred to as "Sunzi" and "Sun Wu"), a high ranking military general, strategist and tactist. The Art of War has also been applied to business and managerial strategies. Composed of 13 chapters, each of which is devoted to one aspect of warfare. It is said to be the definitive work on military strategies and tactics of its time, and is still read for its military insight which can be applied to business and managerial strategies as well.',75,1,9788074844553,'2012-06-02');

INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (1,1);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (2,2);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (3,3);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (4,4);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (5,5);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (6,6);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (7,6);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (8,7);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (9,6);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (10,6);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (11,4);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (12,8);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (13,9);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (14,10);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (15,11);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (16,12);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (17,13);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (18,14);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (19,11);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (20,15);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (21,16);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (22,17);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (23,18);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (24,19);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (25,20);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (26,21);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (27,22);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (28,23);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (29,24);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (30,25);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (31,26);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (32,27);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (33,28);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (34,29);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (35,1);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (36,30);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (37,31);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (38,32);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (39,33);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (40,34);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (41,35);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (42,36);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (43,37);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (44,38);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (45,39);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (46,40);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (47,41);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (48,42);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (49,31);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (50,43);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (51,44);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (52,45);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (53,46);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (54,47);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (55,48);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (56,48);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (57,49);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (58,35);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (59,50);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (60,51);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (61,52);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (62,53);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (63,54);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (64,55);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (65,56);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (66,34);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (67,57);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (68,58);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (69,59);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (70,60);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (71,60);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (72,61);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (73,62);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (74,63);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (75,64);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (76,65);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (77,66);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (78,67);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (79,68);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (80,48);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (81,69);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (82,70);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (83,71);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (84,72);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (85,72);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (86,72);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (87,72);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (88,73);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (89,74);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (90,75);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (91,76);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (92,77);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (93,78);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (94,79);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (95,80);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (96,81);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (97,82);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (98,83);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (99,84);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (100,85);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (101,86);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (102,87);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (103,88);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (104,89);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (105,90);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (106,91);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (107,67);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (108,92);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (109,93);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (110,88);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (111,94);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (112,95);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (113,96);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (114,97);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (115,98);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (116,97);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (117,99);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (118,100);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (119,101);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (120,102);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (121,97);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (122,97);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (123,92);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (124,103);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (125,102);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (126,104);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (127,105);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (128,106);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (129,46);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (130,107);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (131,108);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (132,109);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (133,110);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (134,111);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (135,112);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (136,113);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (137,114);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (138,114);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (139,114);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (140,114);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (141,114);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (142,82);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (143,115);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (144,76);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (145,116);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (146,117);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (147,118);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (148,107);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (149,119);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (150,120);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (151,121);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (152,122);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (153,123);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (154,123);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (155,123);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (156,124);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (157,125);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (158,126);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (159,127);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (160,38);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (161,128);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (162,129);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (163,130);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (164,131);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (165,59);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (166,132);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (167,133);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (168,134);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (169,135);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (170,136);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (171,137);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (172,138);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (173,139);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (174,139);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (175,140);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (176,141);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (177,142);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (178,143);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (179,144);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (180,145);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (181,146);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (182,72);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (183,147);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (184,148);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (185,60);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (186,149);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (187,150);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (188,60);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (189,151);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (190,72);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (191,152);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (192,153);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (193,154);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (194,154);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (195,154);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (196,154);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (197,74);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (198,154);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (199,74);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (200,74);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (201,74);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (202,74);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (203,155);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (204,156);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (205,157);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (206,158);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (207,159);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (208,160);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (209,161);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (210,162);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (211,163);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (212,164);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (213,165);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (214,134);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (215,166);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (216,167);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (217,168);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (218,169);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (219,170);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (220,171);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (221,172);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (222,173);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (223,174);
INSERT INTO Books_Author(Book_ID,Author_ID) VALUES (224,152);

INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (1,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (2,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (3,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (4,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (5,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (6,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (7,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (8,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (9,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (10,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (11,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (12,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (13,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (14,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (15,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (16,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (17,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (18,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (19,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (20,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (22,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (23,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (24,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (26,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (27,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (28,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (29,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (30,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (31,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (32,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (33,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (34,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (35,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (36,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (37,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (38,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (39,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (40,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (41,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (42,3);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (43,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (44,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (45,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (46,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (47,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (48,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (49,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (50,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (51,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (52,3);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (53,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (54,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (55,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (56,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (57,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (58,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (59,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (60,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (61,3);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (62,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (63,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (64,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (65,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (66,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (67,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (68,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (69,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (70,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (71,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (72,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (73,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (74,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (75,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (76,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (77,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (78,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (79,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (80,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (81,5);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (82,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (83,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (84,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (85,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (86,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (87,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (88,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (89,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (90,6);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (91,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (92,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (93,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (94,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (96,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (97,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (98,3);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (99,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (100,7);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (101,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (102,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (103,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (104,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (105,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (106,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (107,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (108,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (109,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (110,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (111,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (112,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (113,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (114,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (115,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (116,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (117,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (118,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (119,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (120,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (121,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (122,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (123,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (124,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (125,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (126,6);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (127,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (128,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (129,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (130,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (131,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (132,6);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (133,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (134,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (135,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (136,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (137,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (138,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (139,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (140,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (141,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (142,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (143,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (144,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (145,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (146,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (147,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (148,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (149,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (150,8);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (151,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (152,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (153,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (154,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (155,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (157,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (158,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (159,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (160,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (161,3);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (162,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (163,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (164,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (165,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (166,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (167,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (168,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (169,9);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (170,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (171,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (172,10);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (173,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (174,11);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (175,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (176,3);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (177,3);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (178,3);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (179,8);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (180,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (181,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (182,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (183,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (184,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (185,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (186,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (187,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (188,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (189,8);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (190,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (193,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (194,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (195,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (196,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (197,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (198,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (199,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (200,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (201,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (202,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (203,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (204,8);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (205,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (206,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (207,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (208,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (210,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (211,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (212,4);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (213,11);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (214,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (216,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (217,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (218,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (219,2);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (220,1);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (221,10);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (222,12);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (224,3);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (1,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (3,15);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (4,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (5,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (6,15);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (7,15);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (8,15);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (9,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (10,15);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (11,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (12,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (13,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (14,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (16,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (17,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (18,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (20,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (22,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (23,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (24,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (26,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (27,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (28,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (29,19);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (30,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (31,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (32,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (33,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (34,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (35,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (36,21);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (37,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (38,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (39,22);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (40,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (41,23);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (42,24);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (43,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (44,25);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (45,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (46,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (47,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (48,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (49,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (50,26);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (51,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (52,24);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (53,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (54,27);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (55,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (56,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (57,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (58,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (59,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (60,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (61,24);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (62,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (63,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (64,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (65,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (66,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (67,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (68,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (69,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (70,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (71,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (72,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (73,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (74,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (75,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (76,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (77,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (78,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (79,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (80,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (81,29);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (82,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (83,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (84,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (85,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (86,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (87,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (88,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (89,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (90,30);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (91,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (92,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (93,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (94,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (96,22);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (97,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (98,24);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (99,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (100,31);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (101,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (102,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (103,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (104,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (105,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (106,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (107,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (108,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (109,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (110,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (111,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (112,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (113,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (114,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (115,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (116,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (117,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (118,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (119,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (120,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (121,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (122,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (123,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (124,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (125,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (126,30);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (127,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (128,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (129,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (130,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (131,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (132,30);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (134,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (135,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (136,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (137,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (138,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (139,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (140,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (141,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (142,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (143,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (144,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (145,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (146,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (147,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (148,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (149,25);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (150,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (151,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (152,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (153,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (154,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (155,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (157,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (158,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (159,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (160,25);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (161,24);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (162,15);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (163,15);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (164,15);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (165,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (166,15);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (167,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (168,32);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (169,33);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (170,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (171,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (172,34);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (173,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (174,35);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (175,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (176,24);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (177,24);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (178,24);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (179,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (180,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (181,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (182,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (183,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (184,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (185,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (186,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (187,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (188,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (189,36);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (190,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (193,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (194,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (195,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (196,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (197,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (198,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (199,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (200,37);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (201,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (202,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (203,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (204,38);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (205,15);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (206,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (207,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (208,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (210,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (211,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (212,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (213,35);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (214,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (216,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (217,17);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (218,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (219,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (220,26);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (221,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (222,39);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (224,24);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (1,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (2,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (4,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (5,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (9,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (11,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (12,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (13,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (15,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (16,42);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (17,43);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (18,44);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (19,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (20,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (22,45);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (23,46);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (24,47);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (26,42);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (27,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (28,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (33,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (34,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (35,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (36,48);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (37,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (38,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (39,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (40,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (41,49);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (42,50);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (43,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (44,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (45,51);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (46,52);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (47,53);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (48,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (49,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (51,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (52,54);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (53,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (55,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (56,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (59,55);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (60,56);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (61,23);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (62,57);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (63,58);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (64,59);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (65,58);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (66,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (68,60);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (69,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (70,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (71,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (72,61);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (73,58);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (74,55);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (75,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (76,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (77,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (78,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (79,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (80,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (81,63);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (82,60);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (83,64);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (84,59);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (85,65);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (86,47);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (87,58);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (88,58);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (89,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (90,66);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (91,67);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (92,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (93,68);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (94,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (96,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (97,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (98,69);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (99,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (101,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (102,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (103,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (104,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (105,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (106,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (107,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (108,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (109,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (110,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (111,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (112,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (113,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (114,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (115,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (116,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (117,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (118,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (119,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (120,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (121,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (122,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (123,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (124,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (125,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (126,66);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (127,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (129,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (130,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (132,66);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (133,14);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (134,70);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (135,71);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (136,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (137,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (138,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (139,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (140,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (141,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (142,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (143,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (144,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (146,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (147,72);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (148,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (149,73);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (151,74);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (153,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (154,16);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (155,55);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (157,51);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (158,52);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (159,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (160,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (161,75);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (165,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (167,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (170,13);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (172,76);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (173,77);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (174,78);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (175,64);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (176,79);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (177,75);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (178,80);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (179,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (180,81);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (181,60);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (182,58);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (183,26);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (184,82);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (185,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (186,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (187,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (188,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (190,58);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (193,55);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (194,55);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (195,55);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (196,55);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (197,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (198,55);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (199,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (200,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (201,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (202,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (203,82);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (204,28);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (206,62);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (208,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (212,83);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (213,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (216,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (217,41);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (218,55);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (219,84);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (224,85);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (1,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (2,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (9,86);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (15,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (18,87);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (19,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (20,88);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (22,89);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (27,88);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (33,90);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (34,91);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (36,92);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (39,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (40,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (43,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (45,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (51,93);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (52,94);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (64,95);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (66,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (68,96);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (69,86);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (70,86);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (71,86);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (79,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (82,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (83,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (84,95);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (89,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (90,97);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (92,86);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (93,98);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (94,99);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (96,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (97,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (99,88);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (126,100);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (132,97);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (133,101);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (134,102);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (136,103);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (137,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (138,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (139,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (140,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (141,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (142,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (144,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (153,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (154,40);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (157,104);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (159,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (161,105);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (165,86);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (172,106);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (173,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (175,107);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (177,105);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (179,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (180,108);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (181,96);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (184,22);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (185,86);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (186,86);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (187,86);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (188,86);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (197,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (199,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (201,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (202,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (203,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (204,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (216,86);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (217,99);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (22,109);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (36,110);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (51,111);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (90,112);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (93,113);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (132,112);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (134,18);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (136,20);
INSERT INTO Books_Genre(Book_ID,Genre_ID) VALUES (175,114);
