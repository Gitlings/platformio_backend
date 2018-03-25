# platformio_backend
[![Waffle.io - Columns and their card count](https://badge.waffle.io/Gitlings/platformio_frontend.svg?columns=all)](https://waffle.io/Gitlings/platformio_frontend)

Make sure you have the bundler installed, otherwise
```
$ gem install bundler
```

To run the server, do the following from the project directory:
- install the gems
```$ bundle```
- start rack application
```$ rackup config.ru```

### Contributing to the progect
Before committing anything do the following:
- Install `rubocop` and `overcommit` gems
- Run `$ overcommit --install`

This will enable precommit checks in order to help maintain the code in a consistent style.
