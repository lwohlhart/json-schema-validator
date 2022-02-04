# json-schema-validator
Utility program to validate a set of JSON resources (local files or web resources) against a JSON Schema.

## Quickstart

The validator can analyze a list of JSON resources available on the web.
```bash
docker run -ti -v $(pwd)/examples_web:/data  wohlhart/json-schema-validator
```

The validator can analyze a list of local JSON files.
```bash
docker run -ti -v $(pwd)/examples_files:/data  wohlhart/json-schema-validator
```

Run with `--help` for full usage description.
```bash
docker run wohlhart/json-schema-validator --help
```

## Usage
If no arguments are specified, the `json-schema-validator` expects a `validation.schema.json` file and a `validation_list.json` file in the `/data` directory. Mount a local `data` directory into the docker container

```bash
mkdir -p data
# add your schema to data/validation.schema.json
# configure the data/validation_list.json file to contain all the resources you want to check
docker run -ti -v $(pwd)/data:/data wohlhart/json-schema-validator 
```

You can modify the parameters of the validator by passing commandline arguments.
```
Usage: json-schema-validator [options]

Options:
  -s, --schema <string>  json-schema to validate against (file or uri) (default: "validation.schema.json")
  -l, --list <string>    json file, list of uris to validate (default: "validation_list.json")
  -c, --cache <string>   cache directory (default: "cache")
  -t, --throttle <int>   throttle between http requests (ms) (default: 1000)
  -o, --out <string>     error log file (default: "validation_errors.log")
  -h, --help             display help for command
```


The `validation.schema.json` file is expected to be a valid JSON Schema definition (https://json-schema.org/). E.g.: 
```json
{
    "$schema": "http://json-schema.org/draft-06/schema#",
    "$ref": "#/definitions/Foo",
    "definitions": {
        "Foo": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "bar": {
                    "type": "integer"
                }
            },
            "required": [
                "bar",
            ],
            "title": "Foo"
        }
    }
}
```

The `validation_list.json` file is expected to be a plain array of strings declaring the json resources to check. E.g.
```json
[
     "https://jsonplaceholder.typicode.com/posts/1",
     "https://jsonplaceholder.typicode.com/posts/2",
     "local_file_in_data_directory.json"
]
```

You can also reference a schema that is hosted on the web. E.g.:
```bash
docker run -ti -v $(pwd)/data:/data --schema http://domain.foo/bar.schema.json
```
