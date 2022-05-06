SELECT
    date(`opportunity_changes_history`.`created`) AS `date`,
    `people`.`name` AS `AAC`,
    count(distinct `opportunity_changes_history`.`opportunity_id`) AS `opps_commited_daily_remote`
FROM
    `opportunity_changes_history`
    LEFT JOIN `opportunities` `opportunities__via__opportunit` ON `opportunity_changes_history`.`opportunity_id` = `opportunities__via__opportunit`.`id`
    LEFT JOIN `people` ON `opportunities__via__opportunit`.`applicant_coordinator_person_id`= `people`.`id`
WHERE
    (
        `opportunity_changes_history`.`type` = 'outbound'
        AND `opportunity_changes_history`.`value` = 0
        AND `opportunities__via__opportunit`.`reviewed` > "2021-7-18"
        AND `opportunities__via__opportunit`.`reviewed` < date(now(6))
        AND `opportunities__via__opportunit`.`remote` = TRUE
        AND date(`opportunity_changes_history`.`created`) = date(`opportunities__via__opportunit`.`reviewed`)
    )
GROUP BY
    date(`opportunity_changes_history`.`created`),
    `people`.`name`
ORDER BY
    date(`opportunity_changes_history`.`created`) ASC