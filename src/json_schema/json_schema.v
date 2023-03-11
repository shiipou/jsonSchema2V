module json_schema

import os
import x.json2 as json

pub type Type = JSONSchema

struct JSONSchema {
pub mut:
	version					string [json: "\$schema"]
	ref 					string [json: "\$ref"]
	id 						string [json: "\$id"]
	multiple_of 			int [json: "multipleOf"]
	maximum		 			int
	exclusive_maximum 		bool [json: "exclusiveMaximum"]
	minimum 				int
	exclusive_minimum 		bool [json: "exclusiveMinimum"]
	max_length 				int [json: "maxLength"]
	min_length 				int [json: "minLength"]
	pattern 				string
	max_items 				int [json: "maxItems"]
	min_items 				int [json: "minItems"]
	unique_items 			bool [json: "uniqueItems"]
	max_properties 			int [json: "maxProperties"]
	min_properties 			int [json: "minProperties"]
	required 				[]string = []
	properties 				map[string]Type = {}
	pattern_properties 		map[string]Type [json: "patternProperties"] = {}
	additional_properties 	json.Any [json: "additionalProperties"] = json.null
	dependencies 			map[string]Type = {}
	enum_ 					[]string [json: "enum"] = []
	type_ 					string [json: "type"]
	all_of 					[]Type [json: "allOf"] = []
	any_of 					[]Type [json: "anyOf"] = []
	one_of 					[]Type [json: "oneOf"] = []
	definitions 			map[string]Type = {}
	title 					string
	description 			string
	default_ 				json.Any [json: "default"] = json.null
	format 					string
	binary_encoding 		string [json: "binaryEncoding"]	
}

pub fn load_from_file(path string) !Type {
	data := os.read_file(path) or { panic(err) }
	return load_from_string(data)
}

pub fn load_from_string(data string) !Type {
	return json.decode[JSONSchema](data) or { panic(err) }
}
