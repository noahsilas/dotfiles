#compdef kf-check-consumer-group.sh

local result=$(kafka-consumer-groups.sh --bootstrap-server kafka.hstl.io:9092 --list 2>/dev/null)
local -a consumerGroups=( ${(f)result} )

_arguments '1:consumer group name:(${consumerGroups})'
