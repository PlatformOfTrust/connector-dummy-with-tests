# Dummy connector tests

These tests show behavior of dummy connector as it is deployed on Platform of Trust environment.

## System requirements

- Python 3.6.x
- [Poetry](https://python-poetry.org/docs/)

## Installation

Install RobotFramework and dependencies:

    poetry install

Required packages should be already in poetry.lock, but in case you encounter issues, try adding them by:

    poetry add robotframework
    poetry add restinstance

## Usage

1. Create an user account on https://world-test.oftrust.net/ (or https://world-sandbox.oftrust.net/)
2. Get Bearer token as described here https://developer.oftrust.net/guides/get-bearer-token/ (this will be %POT_ACCESS_TOKEN in tests)
3. Create a group and then register an application as described here https://developer.oftrust.net/guides/register-application/ (groupId will be %POT_GROUP_ID_TEST while one of the application tokens will be %POT_ACCESS_TOKEN_APP3)
4. Get clientSecrets value (this will be %CLIENT_SECRET_WORLD)
5. Set environment variables which are necessary for executing robot tests:

        set POT_ACCESS_TOKEN=
        set POT_ACCESS_TOKEN_APP3=
        set CLIENT_SECRET_WORLD=
        set POT_GROUP_ID_TEST=

These can be set in a .bat file (if you are using Windows machine).
In case you are using ubuntu or mac OS use: 

        export POT_ACCESS_TOKEN=
        export POT_ACCESS_TOKEN_APP3=
        export CLIENT_SECRET_WORLD=
        export POT_GROUP_ID_TEST=
    
Execute test suite:

    poetry run -m robot.run -A robotargs.txt tests/dummy_connector.robot
    
or

    robot -A robotargs.txt tests/dummy_connector.robot
    

Results can be found in `result` folder.
