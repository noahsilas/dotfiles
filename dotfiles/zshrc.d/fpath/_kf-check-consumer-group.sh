#compdef kf-check-consumer-group.sh

_arguments '1:consumer group name:->GroupName'

case "$state" in
  GroupName)
    local result=$(kafka-consumer-groups.sh --bootstrap-server kafka.hstl.io:9092 --list 2>/dev/null)
    _values "Consumer group name" ${(f)result}
    ;;
esac
