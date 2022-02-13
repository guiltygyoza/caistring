%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from contracts.Str import (Str, str_concat_array, str_from_literal)
from contracts.html_paragraph import convert_str_array_to_html_string


@view
func return_html_paragraphs {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
    } () -> (arr_len : felt, arr : felt*):

    let (arr_str_len, arr_str : Str*) = _data_str_array ()

    let (arr_len : felt, arr : felt*) = convert_str_array_to_html_string (
        arr_str_len = arr_str_len,
        arr_str = arr_str
    )

    return (arr_len, arr)

end


func _data_str_array {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
    } () -> (arr_str_len : felt, arr_str : Str*):
    alloc_locals

    let (line0 : Str) = str_from_literal (':: Topology ::')
    let (line1 : Str) = str_from_literal ('where wizards stay up late.')

    let (arr_str : Str*) = alloc()
    assert arr_str[0] = line0
    assert arr_str[1] = line1
    return (2, arr_str)
end
