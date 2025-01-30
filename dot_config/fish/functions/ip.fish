function ip --wraps='ip -c addr show' --description 'alias ip ip -c addr show'
    command ip $argv -c addr show
end
