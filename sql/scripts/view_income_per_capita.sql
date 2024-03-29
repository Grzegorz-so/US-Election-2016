create or replace view income_per_capita as

with
facts_and_winners as (
	select * from winning_per_county wpc
	join county_facts_csv cfc on wpc.fips = cfc.fips
),
democrats as (
	select
		county, party, candidate, votes,
		INC910213 as income
	from facts_and_winners
	where party like('Democrat')
	order by random() limit 939
),
republicans as (
	select
		county, party, candidate, votes,
		INC910213 as income
	from facts_and_winners
	where party like('Republican')
	order by random() limit 939
),
inc as (
	select * from democrats
	union (
		select * from republicans
	)
)

select
	county, party, candidate, votes, income
from inc
