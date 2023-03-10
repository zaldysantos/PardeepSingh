-- survey info
create table SurveyInfo
(
	id int identity(1,1),
	title nvarchar(50),
	[description] nvarchar(max),
	flag int default 0 not null
);

-- survey question items
create table SurveyQuestions
(
	id int identity(1,1),
	surveyId int not null,
	question nvarchar(max) not null,
	choice1 nvarchar(max) not null,
	choice2 nvarchar(max) not null,
	choice3 nvarchar(max) not null,
	choice4 nvarchar(max) not null,
	choice5 nvarchar(max) not null,
	flag int default 0 not null
);

-- participants (users)
create table Participants
(
	id int identity(1,1),
	[name] nvarchar(50) not null,
	flag int default 0 not null
);

-- survey data (survey info and participant info)
create table SurveyHeader
(
	id int identity(1,1),
	surveyId int not null,
	participantId int not null,
	flag int default 0 not null
);

-- survey data (questions and answers)
create table SurveyDetails
(
	id int identity(1,1),
	headerId int not null,
	questionId int not null,
	answer int not null,
	flag int default 0 not null
);