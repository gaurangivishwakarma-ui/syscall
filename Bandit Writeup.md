# Bandit Writeup (Levels 0–20)

### Level 0 to 1
+ for the first level, I just used the cat command on the readme file
+
+ `cat readme`
+
+ `password for level 1 is : ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If`

---

### Level 1 to 2
+ the next one I had to use quotes and a slash to read it. 
+
+ `cat "./-"`
+
+ `password for level 2 is : 263JGJPfgU6LtdEvgfWU1XP5yac29mFx`

---

### Level 2 to 3
+ here the file had spaces in it. I just wrapped it in quotes and did the cat again. 
+
+ `cat ./"--spaces in this filename--"`
+
+ `password for level 3 is : MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx`

---

### Level 3 to 4
+ I went into the inhere folder and had to use ls with the a flag to see the hidden files. then I just read the hidden file. 
+
+ `cd inhere/`
+ `ls -ah`
+ `cat ...Hiding-From-You`
+
+ `password for level 4 is : 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ`

---

### Level 4 to 5
+ There were a bunch of files there. I used the strings command until, I found the one that had normal readable text. 
+
+ `strings ./"-file00"`
+ `strings ./"-file01"`
+ `strings ./"-file02"`
+ `strings ./"-file03"`
+ `strings ./"-file04"`
+ `strings ./"-file05"`
+ `strings ./"-file06"`
+ `strings ./"-file07"`
+
+ `password for level 5 is : 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw`

---

### Level 5 to 6
+ I needed to find a specific file by its size and type. used the find command to locate the exact one and read it. 
+
+ `find ./inhere/ -type f -size 1033c ! -executable`
+ `cat ./inhere/maybehere07/.file2`
+
+ `password for level 6 is : HWasnPhtq9AVKe0dmk45nxy20cvUa6EG`

---

### Level 6 to 7
+ searched the whole system for files owned by bandit7 and grouped by bandit6, then just read the file it found. 
+
+ `find / -type f -user bandit7 -group bandit6 -size 33c 2>/dev/null`
+ `cat /var/lib/dpkg/info/bandit7.password`
+
+ `password for level 7 is : morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj`

---

### Level 7 to 8
+ just grepped the word millionth in the data file to grab the right line. 
+
+ `cat data.txt | grep "millionth"`
+
+ `password for level 8 is : dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc`

---

### Level 8 to 9
+ sorted the text file first and then used uniq to find the only line that did not repeat. 
+
+ `sort data.txt | uniq -u`
+
+ `password for level 9 is : 4CKMh1JI91bUIZZPXDqGanal4xvAg0JM`

---

### Level 9 to 10
+ the file was messy so I used strings to print out the readable stuff. the password was hiding right by some equals signs. 
+
+ `strings data.txt | grep "="`
+
+ `password for level 10 is : FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey`

---

### Level 10 to 11
+ for this one the text inside the file clearly looked like base64 encoding. so I just read the file and piped it directly into the base64 decode command to get the flag.
+
+ `cat data.txt | base64 -d`
+
+ `password for level 11 is : dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr`

---

### Level 11 to 12
+ I just took the text and dropped it into cyberchef to decode it.
+
+ `password for level 12 is : 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4`

---

### Level 12 to 13
+ using mv to rename, file to check repeatedly gunzip bunzip2 extract tar 
+
+ `password for level 13 is : FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn`

---

### Level 13 to 14
+ I just had to use ssh -i and share the path where I saved private key
+
+ `password for level 14 is : MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS`

---

### Level 14 to 15
+ just connected to local host using netcat and pasted the password of current level
+
+ `nc localhost 30000`
+ `MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS`
+ Correct!
+
+ `password for level 15 is : 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo`

---

### Level 15 to 16
+ used openssl to connect to the local host on the required port
+
+ `openssl s_client -connect localhost:30001`
+
+ `password for level 16 is : kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx`

---

### Level 16 to 17
+ to find which port were listing used this command to find it:
+
+ `nc -zv localhost 31000-32000`
+
+ these were the ports that were listening:
+
+ Connection to localhost (127.0.0.1) 31046 port [tcp/*] succeeded!  
+ Connection to localhost (127.0.0.1) 31518 port [tcp/*] succeeded!  
+ Connection to localhost (127.0.0.1) 31691 port [tcp/*] succeeded!  
+ Connection to localhost (127.0.0.1) 31790 port [tcp/*] succeeded!  
+ Connection to localhost (127.0.0.1) 31960 port [tcp/*] succeeded!  
+
+ `openssl s_client -connect localhost:31790`
+ (was using this command initially to send the password but it just showed KEYUPDATE so after some research found , I had to used -ign_eof flag.)
+
+ `echo "kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx" | openssl s_client -ign_eof -connect localhost:31790`
+
+ `nano ssh_key`
+ `chmod 600 ssh_key`
+
+ using this logged into level 17

---

### Level 17 to 18
+ used the diff command to find the only line that was different between the two files 
+
+ `diff passwords.old passwords.new`
+ 42c42  
+ < pGozC8kOHLkBMOaL0ICPvLV1IjQ5F1VA  
+ ---  
+ > x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO  
+
+ `password for level 18 is : x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO`

---

### Level 18 to 19
+ used this command to log into the server skipping the bash file 
+
+ `ssh -i ssh_key -p 2220 bandit18@bandit.labs.overthewire.org "bash --noprofile --norc"`
+ then it asked for password and  after that it didnt show the normal "$" prompt but still a shell was spawned.
+
+ `ls`
+ `cat readme`
+
+ `password for level 19 is : cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8`

---

### Level 19 to 20
+ ran the binary and it showed "put commands in arguments" so ran the bianry with arguments and it read the flag
+
+ `./bandit20-do cat /etc/bandit_pass/bandit20`
+
+ `password for level 20 is : 0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO`


---END---
