module json_schema

pub type JSONSchemaType = string | bool | f32 | []JSONSchemaType | map[string]JSONSchemaType | JSONSchemaRef
pub type JSONSchemaPropertyOrRef = JSONSchemaProperty | JSONSchemaRef

pub struct JSONSchemaProperty {
pub mut:
	type_ 			string [json: "type"] = "string"
	description		string
	items 			[]JSONSchemaProperty [json: "items"] 	= []
	enum_			[]JSONSchemaType [json: "enum"] 		= []
	is_default 		bool [json: "default"] 					= true
	children 		map[string]JSONSchemaProperty			= {}
}

pub struct JSONSchemaRef {
pub mut:
	ref 			string [json: "\$ref"]
}
