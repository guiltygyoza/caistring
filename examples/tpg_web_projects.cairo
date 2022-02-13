%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.registers import get_label_location
from starkware.cairo.common.alloc import alloc
from contracts.Str import (Str, str_concat_array, str_from_literal)
from contracts.html_table import convert_str_table_to_html_string


@view
func return_html_table {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
    } () -> (arr_len : felt, arr : felt*):

    let (arr_str_len, arr_str : Str*) = _data_str_array ()

    let (arr_len : felt, arr : felt*) = convert_str_table_to_html_string (
        row_cnt = 2,
        col_cnt = 1,
        arr_str_len = arr_str_len,
        arr_str = arr_str
    )

    return (arr_len, arr)

end


func _data_str_array {syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
    } () -> (arr_str_len : felt, arr_str : Str*):
    alloc_locals

    #
    # row 0 col 0
    # <a href="https://github.com/topology-gg/fountain" target="_blank" rel="noopener noreferrer">Fountain</a>
    #
    let (r0c0_0 : Str) = str_from_literal ('<a href="https://github.com/')
    let (r0c0_1 : Str) = str_from_literal ('topology-gg/fountain" target')
    let (r0c0_2 : Str) = str_from_literal ('="_blank" rel="noopener ')
    let (r0c0_3 : Str) = str_from_literal ('noreferrer">Fountain</a>')
    let (a : Str*) = alloc()
    assert a[0] = r0c0_0
    assert a[1] = r0c0_1
    assert a[2] = r0c0_2
    assert a[3] = r0c0_3
    let (r0c0 : Str) = str_concat_array (4, a)

    #
    # row 1 col 0
    # <a href="https://github.com/topology-gg/christopher" target="_blank" rel="noopener noreferrer">Christopher</a>
    #
    let (r1c0_0 : Str) = str_from_literal ('<a href="https://github.com/')
    let (r1c0_1 : Str) = str_from_literal ('topology-gg/christopher" ')
    let (r1c0_2 : Str) = str_from_literal ('target="_blank" rel=')
    let (r1c0_3 : Str) = str_from_literal ('"noopener noreferrer"')
    let (r1c0_4 : Str) = str_from_literal ('>Christopher</a>')
    let (a : Str*) = alloc()
    assert a[0] = r1c0_0
    assert a[1] = r1c0_1
    assert a[2] = r1c0_2
    assert a[3] = r1c0_3
    assert a[4] = r1c0_4
    let (r1c0 : Str) = str_concat_array (5, a)

    #
    # Pack and return
    #
    let (arr_str : Str*) = alloc()
    assert arr_str[0] = r0c0
    assert arr_str[1] = r1c0
    return (2, arr_str)
end
