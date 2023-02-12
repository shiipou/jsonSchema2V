
import src.json_schema {
	JSONSchema
	JSONSchemaProperty
	JSONSchemaRef
	JSONSchemaPropertyOrRef
	load_from_string
}

fn test_json_schema_load_from_string() {
	json_str := '{
    "\$schema": "https://raw.githubusercontent.com/lenra-io/ex_component_schema/beta/priv/static/draft-lenra.json",
    "\$id": "components/view.schema.json",
    "title": "View",
    "description": "Element of type view",
    "type": "component",
    "properties": {
        "type": {
            "description": "The identifier of the component",
            "enum": [
                "view"
            ]
        },
        "name": {
            "description": "The name of the view",
            "type": "string"
        },
        "props": {
            "\$ref": "../defs/props.schema.json"
        },
        "query": {
            "description": "The query to apply to the data.",
            "type": "object"
        },
        "coll": {
            "description": "the collection where the query is applied",
            "type": "string"
        },
        "context": {
            "type": "boolean"
        }
    },
    "required": [
        "type",
        "name"
    ],
    "additionalProperties": false
}'

    schema := load_from_string(json_str) or { panic(err) }

	println(schema)


	id := schema.id
	assert typeof(id).idx == typeof[string]().idx, 'assertion failed for typecheck id: $id'
	assert id == 'components/view.schema.json', 'assertion failed for id: $id'

	title := schema.title
	assert typeof(title).idx == typeof[string]().idx, 'assertion failed for typecheck title: $title'
	assert title == 'View', 'assertion failed for title: $title'

	description := schema.description
	assert typeof(description).idx == typeof[string]().idx, 'assertion failed for typecheck description: $description'
	assert description == 'Element of type view', 'assertion failed for description: $description'

	assert typeof(schema.type_).idx == typeof[string]().idx, 'assertion failed for typecheck type: $schema.type_'
	assert schema.type_ == 'component', 'assertion failed for type: $schema.type_'

	prop_type := schema.properties['type'] or { panic('property type not found') }
	println('prop_type $prop_type')
	// assert typeof(prop_type).idx == typeof[JSONSchemaProperty]().idx, 'assertion failed for typecheck prop_type: $prop_type'

	// prop_type_type := prop_type.type_
	// assert typeof(prop_type_type).idx == typeof[string]().idx, 'assertion failed for typecheck type: $prop_type_type'
	// assert prop_type_type == 'string', 'assertion failed for type: $prop_type_type'

	// prop_type_description := prop_type.description
	// assert typeof(prop_type_description).idx == typeof[string]().idx, 'assertion failed for typecheck description: $prop_type_description'
	// assert prop_type_description == 'The identifier of the component', 'assertion failed for description: $prop_type_description'

	// prop_type_enum := prop_type.enum_
	// assert typeof(prop_type_enum).idx == typeof[[]JSONSchemaTypeString]().idx, 'assertion failed for typecheck enum: $prop_type_enum'
	// assert prop_type_enum[0] as string == 'view' , 'assertion failed for enum: $prop_type_enum'


	// prop_name := schema.properties['name']! as JSONSchemaProperty
	// assert typeof(prop_name).idx == typeof[JSONSchemaProperty]().idx, 'assertion failed for typecheck prop_name: $prop_name'

	// prop_name_description := prop_name.description
	// assert typeof(prop_name_description).idx == typeof[string]().idx, 'assertion failed for typecheck description: $prop_name_description'
	// assert prop_name_description == 'The name of the view' , 'assertion failed for description: $prop_name_description'

	// prop_name_type := prop_name.type_
	// assert typeof(prop_name_type).idx == typeof[string]().idx, 'assertion failed for typecheck type: $prop_name_type'
	// assert prop_name_type == 'string' , 'assertion failed for type: $prop_name_type'


	// prop_props := schema.properties['props']! as JSONSchemaRef
	// assert typeof(prop_props).idx == typeof[JSONSchemaProperty]().idx, 'assertion failed for typecheck prop_props: $prop_props'

	// prop_props_ref := prop_props.ref
	// assert typeof(prop_props_ref).idx == typeof[string]().idx, 'assertion failed for typecheck ref: $prop_props_ref'
	// assert prop_props_ref == '../defs/props.schema.json' , 'assertion failed for ref: $prop_props_ref'


	// prop_query := schema.properties['query']! as JSONSchemaProperty
	// assert typeof(prop_query).idx == typeof[JSONSchemaProperty]().idx, 'assertion failed for typecheck prop_query: $prop_query'

	// prop_query_description := prop_query.description
	// assert typeof(prop_query_description).idx == typeof[string]().idx, 'assertion failed for typecheck description: $prop_query_description'
	// assert prop_query_description == 'The query to apply to the data.' , 'assertion failed for description: $prop_query_description'

	// prop_query_type := prop_query.type_
	// assert typeof(prop_query_type).idx == typeof[string]().idx, 'assertion failed for typecheck type: $prop_query_type'
	// assert prop_query_type == 'object' , 'assertion failed for type: $prop_query_type'


	// prop_coll := schema.properties['coll']! as JSONSchemaProperty

	// prop_coll_description := prop_coll.description
	// assert typeof(prop_coll_description).idx == typeof[string]().idx, 'assertion failed for typecheck description: $prop_coll_description'
	// assert prop_coll_description == 'the collection where the query is applied' , 'assertion failed for description: $prop_coll_description'

	// prop_coll_type := prop_coll.type_
	// assert typeof(prop_coll_type).idx == typeof[string]().idx, 'assertion failed for typecheck type: $prop_coll_type'
	// assert prop_coll_type == 'string' , 'assertion failed for type: $prop_coll_type'


	// prop_context := schema.properties['context']! as JSONSchemaProperty

	// prop_context_type := prop_context.type_
	// assert typeof(prop_context_type).idx == typeof[string]().idx, 'assertion failed for typecheck type: $prop_context_type'
	// assert prop_context_type == 'boolean' , 'assertion failed for type: $prop_context_type'

	// required := schema.required
	// assert typeof(required).idx == typeof[[]string]().idx, 'assertion failed for typecheck required: $required'
	// assert required[0] == 'type', 'assertion failed for required: $required'
	// assert required[1] == 'name', 'assertion failed for required: $required'

	// additional_properties := schema.additional_properties
	// assert typeof(additional_properties).idx == typeof[bool]().idx, 'assertion failed for typecheck additional_properties: $additional_properties'
	// assert additional_properties == false, 'assertion failed for additional_properties: $additional_properties'
}