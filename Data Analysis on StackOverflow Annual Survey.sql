-- 						Stack Overflow Annual Developers Survey


-- Data Source - https://insights.stackoverflow.com/survey

-- 	About the Project 
--I have downloaded the dataset from the stackoverflow official website . 
--Using the PostgreSQL database system I have done data analysis on this dataset  which helped me 
--to answer the below questions 

-- Q1. Are you more likely to get a job as a developer if you only have a Bachelor's degree?
-- Q2 . How much does remote working matter to employees?
-- Q3. Which online learning platform is most popular to learn how to code?
-- Q4. Which job role is paying more salary in India?
-- Q5 . How frequently do people who are just learning how to code visit StackOverflow ?

 
 
 
CREATE TABLE survey (
  ResponseId VARCHAR(1000),
  MainBranch VARCHAR(1000),
  Employment VARCHAR(1000),
  RemoteWork VARCHAR(1000),
  CodingActivities VARCHAR(1000),
  EdLevel VARCHAR(1000),
  LearnCode VARCHAR(1000),
  LearnCodeOnline VARCHAR(1000),
  LearnCodeCoursesCert VARCHAR(1000),
  YearsCode VARCHAR(1000),
  YearsCodePro VARCHAR(1000),
  DevType VARCHAR(1000),
  OrgSize VARCHAR(1000),
  PurchaseInfluence VARCHAR(1000),
  BuyNewTool VARCHAR(1000),
  Country VARCHAR(1000),
  Currency VARCHAR(1000),
  CompTotal VARCHAR(1000),
  CompFreq VARCHAR(1000),
  LanguageHaveWorkedWith VARCHAR(1000),
  LanguageWantToWorkWith VARCHAR(1000),
  DatabaseHaveWorkedWith VARCHAR(1000),
  DatabaseWantToWorkWith VARCHAR(1000),
  PlatformHaveWorkedWith VARCHAR(1000),
  PlatformWantToWorkWith VARCHAR(1000),
  WebframeHaveWorkedWith VARCHAR(1000),
  WebframeWantToWorkWith VARCHAR(1000),
  MiscTechHaveWorkedWith VARCHAR(1000),
  MiscTechWantToWorkWith VARCHAR(1000),
  ToolsTechHaveWorkedWith VARCHAR(1000),
  ToolsTechWantToWorkWith VARCHAR(1000),
  NEWCollabToolsHaveWorkedWith VARCHAR(1000),
  NEWCollabToolsWantToWorkWith VARCHAR(1000),
  OpSysProfessionalUse VARCHAR(1000),
  OpSysPersonalUse VARCHAR(1000),
  VersionControlSystem VARCHAR(1000),
  VCInteraction VARCHAR(1000),
  VCHostingPersonalUse VARCHAR(1000),
  VCHostingProfessionalUse VARCHAR(1000),
  OfficeStackAsyncHaveWorkedWith VARCHAR(1000),
  OfficeStackAsyncWantToWorkWith VARCHAR(1000),
  OfficeStackSyncHaveWorkedWith VARCHAR(1000),
  OfficeStackSyncWantToWorkWith VARCHAR(1000),
  Blockchain VARCHAR(1000),
  NEWSOSites VARCHAR(1000),
  SOVisitFreq VARCHAR(1000),
  SOAccount VARCHAR(1000),
  SOPartFreq VARCHAR(1000),
  SOComm VARCHAR(1000),
  Age VARCHAR(1000),
  Gender VARCHAR(1000),
  Trans VARCHAR(1000),
  Sexuality VARCHAR(1000),
  Ethnicity VARCHAR(1000),
  Accessibility VARCHAR(1000),
  MentalHealth VARCHAR(1000),
  TBranch VARCHAR(1000),
  ICorPM VARCHAR(1000),
  WorkExp VARCHAR(1000),
  Knowledge_1 VARCHAR(1000),
  Knowledge_2 VARCHAR(1000),
  Knowledge_3 VARCHAR(1000),
  Knowledge_4 VARCHAR(1000),
  Knowledge_5 VARCHAR(1000),
  Knowledge_6 VARCHAR(1000),
  Knowledge_7 VARCHAR(1000),
  Frequency_1 VARCHAR(1000),
  Frequency_2 VARCHAR(1000),
  Frequency_3 VARCHAR(1000),
  TimeSearching VARCHAR(1000),
  TimeAnswering VARCHAR(1000),
  Onboarding VARCHAR(1000),
  ProfessionalTech VARCHAR(1000),
  TrueFalse_1 VARCHAR(1000),
  TrueFalse_2 VARCHAR(1000),
  TrueFalse_3 VARCHAR(1000),
  SurveyLength VARCHAR(1000),
  SurveyEase VARCHAR(1000),
  ConvertedCompYearly VARCHAR(1000)
	);


#View the dataset 
SELECT * from survey;

SELECT count(*) AS column_count
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'survey';
  
  
  

   
 
-- Q1. Are you more likely to get a job as a developer if you only have a Bachelor's degree?

-- We can see that the majority of the respondants i.e 50.38% have a full time job as a developer
-- with only bachelors degree

select edlevel , employment  , mainbranch,  count(employment) as count from survey
where employment = 'Employed, full-time' and mainbranch = 'I am a developer by profession'
group by edlevel , employment , mainbranch
order by count desc




-- Q2 . How much does remote working matter to employees

-- We can see that both Men and Women prefer to work from home rather than work from office .

select  gender, remotework , count(remotework) as count from survey
where gender = 'Man' or gender = 'Woman'
group by gender , remotework
order by gender


-- Q3. Which online learning platform is most popular to learn how to code?

-- The Sector leading online platform among respondants on how to learn code are  Udemy (42.6%) 
-- followed by Coursera (35%)

alter table survey
add column learningplatform text

update survey
set learningplatform = split_part(LearnCodeCoursesCert , ';',1)

select learningplatform , count(*) as count from survey
where learningplatform not like 'NA'
group by learningplatform 
order by count desc


-- Q4. Which job role is paying more salary in India?

-- We can see that the Engineering managers earns the highest avg salary in India 
-- with a whopping avg salary of $188.3K


alter table survey
add column jobrole text

update survey
set jobrole = split_part(devType , ';',1)

update survey 
set ConvertedCompYearly = Null
where ConvertedCompYearly = 'NA'


select jobrole , ROUND(avg(ConvertedCompYearly::numeric)) as avg_salary_in_USD from survey
where ConvertedCompYearly is not null and jobrole not like 'NA' and country = 'India'
group by jobrole
order by avg_salary_in_USD desc




-- Q5 . How frequently do people who are just learning how to code visit StackOverflow ?

-- 2522 (~40%) respondants who are learing to code are frequent visitors of StavkOverflow . 
--They visit the website either Daily or multiple times a day

select SOVisitFreq , count(SOVisitFreq) as count from survey
where mainbranch = 'I am learning to code'
group by SOVisitFreq
order by count desc