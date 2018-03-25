# platformio_backend
[![Waffle.io - Columns and their card count](https://badge.waffle.io/Gitlings/platformio_frontend.svg?columns=all)](https://waffle.io/Gitlings/platformio_frontend)

### Running the server
Make sure you have the bundler installed, otherwise
```
$ gem install bundler
```

To run the server, do the following from the project directory:
- install the gems
```$ bundle```
- start rack application
```$ rackup config.ru```

### API
The websocket accepts **JSON string**.
```json
{
  "messageType": "addObject",
  "payload": {
    "objectType": "rectangle",
    "object": {
      "hashId": {},
      "position": {
        "x": 1,
        "y": -1
      },
      "color": "#6d7c7b"
    }
  }
}
```
All the properties listed above are required for any message.
Depending on the `"objectType"` there are other required properties:
- `"rectangle"` requires `"size": {"x": 1, "y": -1}`
- `"circle"` requires `"radius": 1`


### Contributing to the project
Before committing anything do the following:
- Install `rubocop` and `overcommit` gems
- Run `$ overcommit --install`

This will enable precommit checks in order to help maintain the code in a consistent style.
