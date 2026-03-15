
###  Git Exercises Writeup
-
## Level 1
-
- simple level, just needed to git verify to complete
-
- `git start master`  
- `git verify`
-
---
-
## Level 2
-
- only needed to commit to one file so added one .txt file and commited the changes
-
- `git add A.txt`  
- `git commit -m "commit-one-file"`
-
---
-
## Level 3
-
- needed to add both files but only commit to one, so used the git reset command to unstage one file ( git reset --HEAD file.txt )
-
- `git add A.txt`  
- `git add B.txt`  
- `git reset -- HEAD A.txt`
-
---
-
## Level 4
-
- added the names of files and libraries inside .gitignore file so that git doesnt read them , and for the files that end in some extension, used '*' to find entries that have .extension in their names.
-
- `touch .gitignore`  
- `nano .gitignore`  
-
Inside `.gitignore`:
```
*.exe
*.o
*.jar
/libraries/
```
-
---
-
## Level 5
-
-used the git merge command
-
- `git merge escaped`  
- `git commit -m "merge"`
-
---
-
## Level 6
-
- resolved merge conflict manually then commited the changes.
-
- `git merge another-piece-of-work`  
- `nano equation.txt`  
- `git add .`  
- `git commit -m "resolving conflicts"`  
-
---
-
## Level 7
-
- to save my current working directory, used the git stash command and fixed the bug and commited the bug changes and after that did the changed in bug.txt and commited the changes.
-
- `git stash`  
- `nano bug.txt`  
- `git add bug.txt`  
- `git commit -m "bug fixed"`  
- `git stash pop`  
- `nano bug.txt`  
- `git add bug.txt`  
- `git add program.txt`  
- `git commit -m "finished"`  
-
---
-
## Level 8
-
- just removed the file and pushed the changes.
-
- `git rm ignored.txt`   
- `git commit --allow-empty -m "removed"`  
-
-
---
-
## Level 9
-
- used the git mv command to rename the file.
-
- `git mv File.txt file.txt`  
- `git commit -m "renamed"`  
-
-
---
-
## Level 10
-
- made the changes in file.txt, staged and commited using the flag --amend
-
- `nano file.txt`  
- `git add file.txt`  
- `git commit --amend`  
-
---
-
## Level 11
-
- used git ammend with the flag --date and chnaged it 
-
- `git commit --amend --date "Wed Feb 16 14:08 1987 +0100" --no-edit`  
-
---
-
## Level 12
-
- used git rebase interactively and pushed the head two behind, and then made the changes and used git ammend to make it look like it never happened then continued with the rebase
-
- `git rebase -i HEAD~2`  
- `nano file.txt`  
- `git add file.txt`  
- `git commit --amend`  
- `git rebase --continue`
-
---END-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

