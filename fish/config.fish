/opt/homebrew/bin/brew shellenv | source

pixi completion --shell fish | source

# fish
for file in ~/.pixi/completions/fish/*
    source $file
end