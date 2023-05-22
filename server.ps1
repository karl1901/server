git add *
$commitInfo = Read-Host 'please input commitInfo'
git commit -m $commitInfo
git push
Pause