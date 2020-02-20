# This function should be executed before any conda command.
# It enables the displayal of the current conda env in the shell.
function conda-pre
	eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
