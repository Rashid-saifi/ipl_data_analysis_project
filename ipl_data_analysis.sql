create database ipl;
use ipl;

-- select all data from database to analyse the data
select * from ipl_ana;
-- most ipl matches played in a venue 
select count(distinct(match_id)) as Total_matches,venue from ipl_ana group by venue order by Total_matches desc  ;

--  most ipl runs by ipl teams
select batting_team,sum(run) from ipl_ana group by batting_team;
-- alter table ipl_ana change column over to overr


-- Average runs in power_play by each ipl team 
with mycte as (select
		batting_team,
		sum(run) AS powerplay_runs
	FROM
		ipl_ana
	WHERE
		overr <6
	GROUP BY
		batting_team,match_id
	ORDER BY
		powerplay_runs DESC)

select avg(powerplay_runs) as powerplay_runs,batting_team from mycte group by batting_team ;

-- most ipl century by a batsman
with my as (select striker,sum(runs_off_bat) as runs from ipl_ana group by striker ,match_id order by runs desc)
select striker ,count(runs) as century from my where runs>=100 group by striker  order by century desc;

-- most ipl half century by a batsman
with my as (select striker,sum(runs_off_bat) as runs from ipl_ana group by striker ,match_id order by runs desc)
select striker ,count(runs) as century from my where runs>=50 group by striker  order by century desc;

-- most sixes in ipl by a batsman in a match
select striker, count(runs_off_bat) as sixs from ipl_ana where runs_off_bat=6 group by start_date ,striker order by sixs desc;

-- most rours  in ipl by a batsman
select striker, count(runs_off_bat) as four from ipl_ana where runs_off_bat=4 group by start_date ,striker order by sixs desc;

-- most runs by a batsman in each season
select striker,sum(runs_off_bat) as runs ,season from ipl_ana group by striker ,season order by runs desc;

-- most sixes in an ipl season
select count(match_id) as sixs,season from ipl_ana where runs_off_bat=6 group by season order by sixs desc;

-- highest total by a ipl team 
select batting_team,sum(run) as total_runs from ipl_ana group by batting_team ,start_date order by  total_runs desc;
 
-- highest total  by a  batsman
select striker ,sum(runs_off_bat) as total_runs from ipl_ana group by striker ,start_date order by total_runs desc;

-- most runs conceded by a bowler in an inning 
select bowler ,sum(run) as run from ipl_ana group by bowler,start_date order by run desc ;

-- most dot balls by a bowler
select bowler,count(run) as dot_ball from ipl_ana where run=0 group by bowler ;

-- most wickets by an ipl team 
select bowling_team ,count(wicket_type) as wicket from ipl_ana group by bowling_team;

-- most wickets by a bowler
SELECT 
    Bowler, COUNT(*) AS Wicket
FROM
    ipl_ana
WHERE
    wicket_type IN ('caught' , 'bowled',
        'runout',
        'lbw',
        'retired hurt',
        'stumped',
        'caught and bowled',
        'hit wicket',
        'obstructing the field')
GROUP BY bowler
ORDER BY wicket DESC;

-- most wicket by a bowler in season
SELECT 
    Bowler,season,COUNT(*) AS Wicket
FROM
    ipl_ana
WHERE
    wicket_type IN ('caught' , 'bowled',
        'runout',
        'lbw',
        'retired hurt',
        'stumped',
        'caught and bowled',
        'hit wicket',
        'obstructing the field')
GROUP BY bowler,season
ORDER BY wicket DESC;

-- most no balls by ipl teams
SELECT 
    bowling_team,
    COUNT(*) AS total_no_balls
FROM 
    ipl_ana
WHERE 
    noballs = 1
GROUP BY 
    bowling_team
ORDER BY 
    total_no_balls DESC
LIMIT 5;




