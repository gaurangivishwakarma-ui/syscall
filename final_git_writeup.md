### https://gitexercises.fracz.com/exercise writeups


## level 1
`git start master`

`git verify`

## level 2

```git add A.txt
```

```git commit -m "commit-one-file"
```
## level 3
```git add A.txt
```
```git add B.txt
```
```git reset -- HEAD A.txt
```
## level 4
```touch .gitignore
```
```nano .gitignore
```
inside:
*.exe
*.o
*.jar
/libraries/

## level 5
git merge escaped
git commit -m "merge"

## level 6
git merge another-piece-of-work
nano equation.txt 
 git add .
 git commit -m "resolving conflicts"
gaurangi@fedora:~/Downloads/git_exercise/exercises$ git merge another-piece-of-work 
fatal: You have not concluded your merge (MERGE_HEAD exists).
Please, commit your changes before you merge.
gaurangi@fedora:~/Downloads/git_exercise/exercises$ git commit -m "resolving conflicts"
[merge-conflict 428120c] resolving conflicts


## level 7
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git start` 
* `Preparing the exercise environment, hold on...` 
* `Exercise save-your-work started!`        
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git stash`  
* `Saved working directory and Index state WIP on save-your-work: 26639a6 Excellent version with a bug`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ nano bug.txt`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git add bug.txt`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git commit -m "bug fixed"`  
* `[save-your-work 8d3a15a] bug fixed`  
* `1 file changed, 1 deletion(-)`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git stash pop`  
* `Auto-merging bug.txt`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ nano bug.txt`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git add bug.txt`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ ls`  
* `bug.txt program.txt README.md start.sh`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git add program.txt`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git commit -m "finished"`  
* `[save-your-work 8a59a4f] finished`  
* `2 files changed, 7 insertions(+), 2 deletions(-)`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git verify`  
* `Verifying the save-your-work exercise. Hold on...`  
* `Exercise: save-your-work`  
* `Status: PASSED`  

---

## level 8
* `gaurangi@fedora:~/Downloads/git_exercise/exercises$ git start next`  
* `Preparing the exercise environment, hold on...`  
* `Exercise remove-ignored started!`  
* `gaurangi@fedora:~/Downloads/git_exercise/exercises$ git rm ignored.txt`  
* `rm 'ignored.txt'`  
* `gaurangi@fedora:~/Downloads/git_exercise/exercises$ git status`  
* `deleted: ignored.txt`  
* `gaurangi@fedora:~/Downloads/git_exercise/exercises$ git commit --allow-empty -m "remov"`  
* `[remove-ignored 606d562] removed`  
* `gaurangi@fedora:~/Downloads/git_exercise/exercises$ git verify`  
* `Verifying the remove-ignored exercise. Hold on...`  
* `Status: PASSED`  

---

## level 9
* `gaurangi@fedora:~/Downloads/git_exercise/exercises$ git start next`  
* `Preparing the exercise environment, hold on...`  
* `Exercise case-sensitive-filename started!`  
* `gaurangi@fedora:~/Downloads/git_exercise/exercises$ git mv File.txt file.txt`  
* `gaurangi@fedora:~/Downloads/git_exercise/exercises$ git commit -m "renamed"`  
* `[case-sensitive-filename 2bc5aaa] renamed`  
* `rename File.txt => file.txt (100%)`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git verify`  
* `Status: PASSED`  

---

## level 10
* `Preparing the exercise environment, hold on...`  
* `Exercise fix-typo started!`  
* `gaurangi@fedora:~/Downloads/git_exercise/exercises$ nano file.txt`  
* `gaurangi@fedora:~/Downloads/git_exercise/exercises$ git add file.txt`  
* `gaurangi@fedora:~/Downloads/git_exercise/exercises$ git commit --amend`  
* `[fix-typo ca2b3d7] Add Hello world`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git verify`  
* `Status: PASSED`  

---

## level 11
* `Preparing the exercise environment, hold on...`  
* `Exercise forge-date started!`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git commit --amend`  
* `[forge-date 3bff71b] Late work`  
* `Date: Thu Mar 12 23:14:26 2026 +6538`  
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git commit -amend --date "Wed Feb 16 14:88 1987 +6166" -no-edit`  
* `[forge-date 66d5b98] Late work` 
* `Date: Mon Feb 16 14:08:00 1987 +0100` 
* `gaurangi@fedora:-/Downloads/git_exercise/exercises$ git verify` 
* `Status: PASSED`

##level 12


* `git rebase -i HEAD~2`
* `nano file.txt`
* `git add file.txt`
* `git commit --amend`
* `git rebase --continue`


