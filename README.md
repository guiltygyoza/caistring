# Working with strings in Cairo
- Yet another string library built to enable flexible manipulation
- Some functions to assemble and serve raw html from contract

### str.cairo
- `Str`: a struct that encapsulates a `felt` array
- `str_empty()`: returns an empty `Str` instance
- `str_from_literal(<string literal>)`: returns a `Str` instance that contains the string literal
- `str_concat(<first Str>, <second Str>)`: returns a `Str` instance that contains the concatenation of two input `Str`
- `str_concat_array(<length of Str array>, <pointer of Str array>)`: returns a `Str` instance that contains the concatenation of all input `Str` in the provided array

### html_paragraph.cairo
- `convert_str_array_to_html_string(<length of Str array>, <pointer of Str array>`: wraps each `Str` in a paragraph tag, and returns a `felt` array that contains the resulting html in hex string form.

### html_table.cairo
- `convert_str_table_to_html_string(<table row count>, <table column count>, <length of flattened Str array>, <pointer of flattened Str array>)`: turns the flattened array of `Str` into a html table given row and column count, and returns a `felt` array t hat contains the resulting html in hex string form.
