<!--
# To generate a SQL Injection Attack
#
# Create the following database
#
# mysql -u root -p
# create database sample;
# connect sample;
# create table users(username VARCHAR(100),password VARCHAR(100));
# insert into users values('jesin','pwd');
# insert into users values('alice','secret');
# quit;
#
# Attack description
#
# Open your browser, navigate to 192.168.33.16/sql_injection_example.php and
# enter the right pair of credentials.
# - Username: jesin
# - Password: pwd
# You'll see a message that indicates successful login.Now come back
# and enter a wrong pair of credential, you'll see the message 
# Invalid username or password.
#
# Enter the following for the username field: ' or true -- 
# Note that there should be a space after -- this injection won't work without that space. 
# Leave the password field empty and hit the login button.
#
# Voila! The script shows the message meant for authenticated users.
-->

<html>
<body>
<?php
    if(isset($_POST['login']))
    {
        $username = $_POST['username'];
        $password = $_POST['password'];
        $con = mysqli_connect('localhost','root','','sample');
        $result = mysqli_query($con, "SELECT * FROM `users` WHERE username='$username' AND password='$password'");
        if(mysqli_num_rows($result) == 0)
            echo 'Invalid username or password';
        else
            echo '<h1>Logged in</h1><p>A Secret for you....</p>';
    }
    else
    {
?>
        <form action="" method="post">
            Username: <input type="text" name="username"/><br />
            Password: <input type="password" name="password"/><br />
            <input type="submit" name="login" value="Login"/>
        </form>
<?php
    }
?>
</body>
</html>
