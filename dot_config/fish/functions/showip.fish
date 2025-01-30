function showip --wraps='ip -br -c addr show' --description 'alias showip ip -br -c addr show'
  ip -br -c addr show $argv
end
