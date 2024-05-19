#!/opt/homebrew/bin/fish

set -x project $argv[1]
set -x entity $argv[2]

echo "Wakatime: $project $entity"
echo $(wakatime --write --plugin "fish-wakatime/0.0.1" --entity-type app --project "$project" --entity $entity --category building)
