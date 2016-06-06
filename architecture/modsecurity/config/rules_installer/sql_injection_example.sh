#!/usr/bin/env bash

#Install rules
sh /vagrant_data/rules/sql_injection_rules.sh


#Database creation

#mysql -u root -p
#create database sample;
#connect sample;
#create table users(username VARCHAR(100),password VARCHAR(100));
#insert into users values('jesin','pwd');
#insert into users values('alice','secret');
#quit;

#Attack description

#Open your browser, navigate to http://yourwebsite.com/login.php and enter the right pair of credentials.

#Username: jesin
#Password: pwd
#You'll see a message that indicates successful login. Now come back and enter a wrong pair of credentials-- you'll see the message Invalid username or password.

#We can confirm that the script works right. The next job is to try our hand with SQL injection to bypass the login page. Enter the following for the username field:

#' or true -- 
#Note that there should be a space after -- this injection won't work without that space. Leave the password field empty and hit the login button.

#Voila! The script shows the message meant for authenticated users.

