CREATE DATABASE HashiCorp;
GO
USE HashiCorp;
GO
DROP TABLE IF EXISTS Projects;
GO
CREATE TABLE Projects(
  [Id] [varchar](25),
  [YearOfFirstCommit] int,
  [GitHubLink] [varchar](50)
);
GO