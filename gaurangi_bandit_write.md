### Level 0 to 1
for the first level, I just used the cat command on the readme file

bandit0@bandit:~$ cat readme
Congratulations on your first steps into the bandit game!!
Please make sure you have read the rules at https://overthewire.org/rules/
If you are following a course, workshop, walkthrough or other educational activity,
please inform the instructor about the rules as well and encourage them to
contribute to the OverTheWire community so we can keep these games free!

The password you are looking for is: ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If


### Level 1 to 2
the next one I had to use quotes and a slash to read it. 


bandit1@bandit:~$ cat "./-"
263JGJPfgU6LtdEvgfWU1XP5yac29mFx
bandit1@bandit:~$ 


### Level 2 to 3
here the file had spaces in it. I just wrapped it in quotes and did the cat again. 

bandit2@bandit:~$ ls
--spaces in this filename--
bandit2@bandit:~$ cat ./"--spaces in this filename--"
MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx
bandit2@bandit:~$ 

### Level 3 to 4
i went into the inhere folder and had to use ls with the a flag to see the hidden files. then I just read the hidden file. 


bandit3@bandit:~$ ls
inhere
bandit3@bandit:~$ ls
inhere
bandit3@bandit:~$ ls -a
.  ..  .bash_logout  .bashrc  inhere  .profile
bandit3@bandit:~$ cd inhere/
bandit3@bandit:~/inhere$ ls
bandit3@bandit:~/inhere$ ls -ah
.  ..  ...Hiding-From-You
bandit3@bandit:~/inhere$ cat ...Hiding-From-You
2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
bandit3@bandit:~/inhere$ 


### Level 4 to 5
There were a bunch of files there. I used the strings command until, I found the one that had normal readable text. 

bandit4@bandit:~/inhere$ strings ./"-file00"
6);/:
bandit4@bandit:~/inhere$ strings ./"-file01"
bandit4@bandit:~/inhere$ strings ./"-file02"
bandit4@bandit:~/inhere$ strings ./"-file03"
bandit4@bandit:~/inhere$ strings ./"-file04"
bandit4@bandit:~/inhere$ strings ./"-file05"
bandit4@bandit:~/inhere$ strings ./"-file06"
Y["#
bandit4@bandit:~/inhere$ strings ./"-file07"
4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw
bandit4@bandit:~/inhere$ 

### Level 5 to 6
I needed to find a specific file by its size and type. used the find command to locate teh exact one and read it. 


bandit5@bandit:~$ ls
inhere
bandit5@bandit:~$ find ./inhere/ -type f -size 1033c ! -executable
./inhere/maybehere07/.file2
bandit5@bandit:~$ find ./inhere/ -type f -size 1033c ! -executable | strings
./inhere/maybehere07/.file2
bandit5@bandit:~$ find ./inhere/ -type f -size 1033c ! -executable | cat | strings
./inhere/maybehere07/.file2
bandit5@bandit:~$ cat ./inhere/maybehere07/.file2
HWasnPhtq9AVKe0dmk45nxy20cvUa6EG

### Level 6 to 7
searched the whole system for files owned by bandit7 and grouped by bandit6. then i just read the file it found. 


bandit6@bandit:/home$ find / -type f -user bandit7 -group bandit6 -size 33c 2>/dev/null
/var/lib/dpkg/info/bandit7.password
bandit6@bandit:/home$ cat | find / -type f -user bandit7 -group bandit6 -size 33c 2>/dev/null
/var/lib/dpkg/info/bandit7.password
^Xbandit6@bandit:/home$ ca/var/lib/dpkg/info/bandit7.passwordrd
morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj
bandit6@bandit:/home$ 


### Level 7 to 8
just grepped the word millionth in the data file to grab the right line. 

data.txt
bandit7@bandit:~$ cat data.txt | grep "millionth"
millionth	dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc
bandit7@bandit:~$ 

### Level 8 to 9
sorted the text file first and then used uniq to find the only line that did not repeat. 


bandit8@bandit:~$ sort data.txt | uniq -u
4CKMh1JI91bUIZZPXDqGanal4xvAg0JM
bandit8@bandit:~$ 
bandit8@bandit:~$ 


### Level 9 to 10
the file was messy so I used strings to print out the readable stuff. the password was hiding right by some equals signs. 




strings data.txt | grep "="

FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey


### level 10 to 11

for this one the text inside the file clearly looked like base64 encoding. so I just read the file and piped it directly into the base64 decode command to get the flag.

bandit10@bandit:~$ ls
data.txt
bandit10@bandit:~$ cat data.txt 
VGhlIHBhc3N3b3JkIGlzIGR0UjE3M2ZaS2IwUlJzREZTR3NnMlJXbnBOVmozcVJyCg==
bandit10@bandit:~$ cat data.txt | base64 -d 
The password is dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr
bandit10@bandit:~$ 

### level 11 to 12

I just took the text and dropped it into cyberchef to decode it.

The password is 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4
using cyberchef

### level 12 to 13

using mv to rename, file to check repeatedly gunzip bunzip2 extract tar 
Pass level 13: FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn

### level 13 to 14
I just had to use ssh -i and share the path where I saved private key

### level 14 to 15

Level 14 pass: MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS

bandit14@bandit:~$ nc localhost 30000
MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS
Correct!
Level 15 pass: 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo


### level 15 to 16


bandit15@bandit:~$ openssl s_client -connect localhost:30001


read R BLOCK
8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo
Correct!
Level 16 pass: kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx


###level 16 to 17

nc -zv localhost 31000-32000

Connection to localhost (127.0.0.1) 31046 port [tcp/*] succeeded!

Connection to localhost (127.0.0.1) 31518 port [tcp/*] succeeded! 

Connection to localhost (127.0.0.1) 31691 port [tcp/*] succeeded!

Connection to localhost (127.0.0.1) 31790 port [tcp/*] succeeded!

Connection to localhost (127.0.0.1) 31960 port [tcp/*] succeeded! 

openssl s_client -connect localhost:31790

echo "kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx" | openssl s_client -ign_eof -connect localhost:31790

Nano ssh_key

chmod 600 ssh_key 

using this logged into level 17

### level 17 to 18


bandit17@bandit:~$ diff passwords.old passwords.new
42c42
< pGozC8kOHLkBMOaL0ICPvLV1IjQ5F1VA
---
> x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO

### level  18 to 19


gaurangi@fedora:~$ ssh -i ssh_key -p 2220 bandit18@bandit.labs.overthewire.org "bash --noprofile --norc"
                         _                     _ _ _   
                        | |__   __ _ _ __   __| (_) |_ 
                        | '_ \ / _` | '_ \ / _` | | __|
                        | |_) | (_| | | | | (_| | | |_ 
                        |_.__/ \__,_|_| |_|\__,_|_|\__|
                                                       

                      This is an OverTheWire game server. 
            More information on http://www.overthewire.org/wargames

backend: gibson-1
bandit18@bandit.labs.overthewire.org's password: 


ls
readme
cat readme
cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8


### level 19 to 20

bandit19@bandit:~$ ./bandit20-do cat /etc/bandit_pass/bandit20
Pass 20: 0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO


_____END_______________________________________________________________________________________________________________________________________________________________________________________________________________






