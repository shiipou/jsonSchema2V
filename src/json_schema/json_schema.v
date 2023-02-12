module json_schema

import os
import json

pub struct JSONSchema {
pub:
	schema 			string [json: "\$schema"]
	id 				string [json: "\$id"]
	title 			string
	description 	string
	type_ 			string [json: "type"]
	properties 		map[string]JSONSchemaPropertyOrRef
	required 		[]string
	additional_properties bool [json: "additionalProperties"]
}

pub fn load_from_file(path string) ?JSONSchema {
	data := os.read_file(path) or { panic(err) }
	return load_from_string(data)
}

pub fn load_from_string(data string) ?JSONSchema {
	return json.decode(JSONSchema, data) or { panic(err) }
}
