# Defined in - @ line 2
function org-push
	rclone copy --exclude-from ~/org/orgignore.txt ~/org/ dbrem:org/
end
