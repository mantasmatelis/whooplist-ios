message=${1-"WL Update Script: No message inputted."}
git add -u
git commit -m "$message"
git push
