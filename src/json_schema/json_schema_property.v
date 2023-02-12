module json_schema

import x.json2

pub type JSONSchemaType = string | bool | f32 | []JSONSchemaType | map[string]JSONSchemaType | JSONSchemaRef
pub type JSONSchemaPropertyOrRef = JSONSchemaProperty | JSONSchemaRef

fn (j JSONSchemaPropertyOrRef) from_json(data json2.Any) {
	json_data := data.as_map()
	if '\$ref' in json_data {
		json_schema_ref := j as JSONSchemaRef
		json_schema_ref.from_json(data)
	} else {
		json_schema_property := j as JSONSchemaProperty
		json_schema_property.from_json(data)
	}
}

pub struct JSONSchemaProperty {
pub mut:
	type_ 			string [json: "type"] = "string"
	description		string
	items 			[]JSONSchemaProperty [json: "items"] 	= []
	enum_			[]JSONSchemaType [json: "enum"] 		= []
	is_default 		bool [json: "default"] 					= true
	children 		map[string]JSONSchemaProperty			= {}
}

fn (mut s JSONSchemaProperty) from_json(data json2.Any) {
	json_data := data.as_map()
	s.type_ = json_data["type"].str() or { "string" }
	s.description = json_data["description"].str()
	items := json_data["items"].arr()
	for item in items {
		s.items << JSONSchemaProperty{}
		s.items.last().from_json(item)
	}
	enum_ := json_data["enum"].arr()
	for item in enum_ {
		s.enum_ << item
	}
	s.is_default = json_data["default"].bool()
	children := json_data["children"].as_map()
	for key, value in children {
		s.children[key] = JSONSchemaProperty{}
		s.children[key].from_json(value)
	}
}

fn (s JSONSchemaProperty) to_json() json2.Any {
	return json2.encode(s)
}


pub struct JSONSchemaRef {
pub mut:
	ref 			string [json: "\$ref"]
}

fn (mut s JSONSchemaRef) from_json(data json2.Any) {
	json_data := data.as_map()
	s.ref = json_data["\$ref"].str()
}

fn (s JSONSchemaRef) to_json() json2.Any {
	return json2.encode(s)
}
