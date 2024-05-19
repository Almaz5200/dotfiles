
function _pure_item_wakatime
    if echo (pwd) | grep -qEi "^/Users/$USER/"
        set project (echo (pwd) | sed "s#^/Users/$USER/\\([^/]*\\).*#\\1#")
    else
        set project terminal
    end

    set entity (echo $history[1] | cut -d ' ' -f1)

    echo $project

    nohup ~/.track_wakatime.sh $project $entity >~/proofitworks 2>&1 &
end
