function aptup --wraps='sudo apt update && sudo apt upgrade' --description 'alias aptup=sudo apt update && sudo apt upgrade'
  sudo apt update && sudo apt upgrade $argv; 
end
