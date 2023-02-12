module main

import json_schema
import json_schema_to_v

fn main() {
	// Load the schema from a file
	schema := json_schema.load_from_file('schema.json')

	// Generate the V code
	code := json_schema_to_v.generate(schema)

	// Write the code to a file
	code.write_to_file('schema.v')
}
