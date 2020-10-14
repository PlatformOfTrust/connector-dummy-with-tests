# connector-dummy-with-tests

## Translator

A translator standardizes the responses from a data source to the
Platform. The translator also adds security measures, such as signature
verification and signing the response.

This is built with [Python Bottle](https://bottlepy.org/docs/0.12/)

## Dummy Data generation
This translator returns dummy data, no real connection to an external API is made.
In order to determine the value to return when making a request the algorithm combines
two values: `timestamp` and the `id` from the params.

This dummy data return one value for each 30 minutes, simulating a real sensor.

It takes one digit from the timestamp and multiplies it by the defined INCREMENT_VALUE
and adds it to the base value. (for example 17 degrees)

It also computes the ASCII value of the id and takes the last digit and multiplies it
with the increment value.

In this way the result is always the same for the same date range and id. Some collisions
will be present for the same date range and different ids.

## Requirements

You need the following installed on your computer:

- Python 3.6
- poetry==1.0.3 (`pip install poetry==1.0.3`)
- [Yarn](https://yarnpkg.com/lang/en/docs/install/) - For documentation

## API documentation

The API uses [RAML](https://github.com/raml-org/raml-spec/blob/master/versions/raml-10/raml-10.md)
to document the API. To generate the documentation you need to install Yarn,
and run `poetry run invoke docs`.

This will generate an `index.html`-file under `docs/`. Open the file in your
browser to check that the documentation is in order.
