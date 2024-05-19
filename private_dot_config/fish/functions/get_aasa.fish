function get_aasa
    set host $argv[1]
    echo "Checking AASA for $host"
    curl -L https://$host/.well-known/apple-app-site-association | jq
end
