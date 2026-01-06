function pixidir --description "Creates a pixi-compatible .envrc file for direnv"
    # Check if .envrc already exists to avoid overwriting
    if test -e .envrc
        echo "Error: .envrc already exists in this directory."
        return 1
    end

    # Create the .envrc file with the specified content
    echo 'watch_file pixi.toml pixi.lock
eval "$(pixi shell-hook)"

dotenv_if_exists .env' > .envrc

    direnv allow
    echo "Successfully created and activated .envrc file."
end