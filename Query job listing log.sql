SELECT
    o.id as ID,
    o.objective as 'Job title',
    -- url,
    -- Manager_link,
    -- location,
    o.created as 'Created date',
    o.reviewed as 'Approved date',
    -- closing date,
    o.locale as 'Language of the post',
    o.commitment_id as 'Type of job',
    o.fulfillment as 'Type of service',
    -- Recruiter_advisor,
    o.status as 'Status',
    o.last_updated as 'Changes history',
    sum(case when oc.id is not null and oc.interested is not null then 1 else 0 end) as 'Completed Applications'
    
    
    

FROM opportunities as o

left join opportunity_candidates as oc on o.id = oc.opportunity_id

WHERE true
    and objective <> 'Shared by an intermediary'
    and review = 'approved'

group by o.id
order by o.created desc;