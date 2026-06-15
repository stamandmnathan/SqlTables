

  SELECT match_id, player_id, minute,
         RANK() OVER (
           PARTITION BY match_id
           ORDER BY minute 
         ) AS goal_sequence_rank
  FROM Goals
  ORDER BY match_id, minute ;

