module json_schema

import os
import x.json2

pub struct JSONSchema {
pub mut:
	schema 			string [json: "\$schema"]
	id 				string [json: "\$id"]
	title 			string
	description 	string
	type_ 			string [json: "type"]
	properties 		map[string]JSONSchemaPropertyOrRef
	required 		[]string
	additional_properties bool [json: "additionalProperties"]
}

fn (s JSONSchema) from_json(data json2.Any) {
	s.schema = data["\$schema"].string() or { "" }
	s.id = data["\$id"].string() or { "" }
	s.title = data["title"].string() or { "" }
	s.description = data["description"].string() or { "" }
	s.type_ = data["type"].string() or { "" }
	s.properties = map[string]JSONSchemaPropertyOrRef{}
	for k, v in data["properties"].object() {
		if '\$ref' in v.object() {
			s.properties[k] = JSONSchemaRef{}
			s.properties[k].from_json(v)
		} else {
			s.properties[k] = JSONSchemaProperty{}
			s.properties[k].from_json(v)
		}
	}
	s.required = data["required"].array() or { [] }
	s.additional_properties = data["additionalProperties"].bool() or { false }
}

pub fn (s JSONSchema) to_json() string {
	return json2.encode(s)
}

pub fn load_from_file(path string) !JSONSchema {
	data := os.read_file(path) or { panic(err) }
	return load_from_string(data)
}

pub fn load_from_string(data string) !JSONSchema {
	json_data = json2.raw_decode(data) or { panic(err) }
	json_schema := JSONSchema{}
	json_schema.from_json(json_data)
	return json_schema
}
