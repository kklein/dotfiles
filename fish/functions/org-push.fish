# Defined in - @ line 2
function org-push
	git --git-dir=/home/kevin/org/.git --work-tree=/home/kevin/org add *.org
    git --git-dir=/home/kevin/org/.git --work-tree=/home/kevin/org commit -m "Update."
    git --git-dir=/home/kevin/org/.git --work-tree=/home/kevin/org push origin master
    rclone copy --exclude-from ~/org/orgignore.txt ~/org/ dbrem:org/
end
