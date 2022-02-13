%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import (signed_div_rem, unsigned_div_rem, sign, assert_nn, abs_value, assert_not_zero, sqrt)
from starkware.cairo.common.math_cmp import (is_nn, is_le, is_not_zero)
from starkware.cairo.common.memcpy import memcpy
from starkware.cairo.common.alloc import alloc

from contracts.array import array_concat

#
# Define the string struct
#
struct Str:
    member arr_len : felt
    member arr : felt*
end

#
# Concatenate two strings
#
func str_concat {range_check_ptr} (
        str1 : Str,
        str2 : Str
    ) -> (
        res : Str
    ):

    let (
        arr_res_len : felt,
        arr_res : felt*
    ) = array_concat (
        arr1_len = str1.arr_len,
        arr1 = str1.arr,
        arr2_len = str2.arr_len,
        arr2 = str2.arr
    )

    return ( Str(arr_res_len, arr_res) )
end

#
# Concatenate an array of Str's into one Str
#
func str_concat_array {range_check_ptr} (
        arr_str_len : felt,
        arr_str : Str*
    ) -> (
        res : Str
    ):
    alloc_locals

    let (arr_init) = alloc()
    let (arr_len, arr) = _recurse_str_concat_array (
        arr_str_len = arr_str_len,
        arr_str = arr_str,
        arr_len = 0,
        arr = arr_init,
        idx = 0
    )

    let res = Str (arr_len, arr)
    return (res)
end


func _recurse_str_concat_array {range_check_ptr} (
        arr_str_len : felt,
        arr_str : Str*,
        arr_len : felt,
        arr : felt*,
        idx : felt
    ) -> (
        arr_final_len : felt,
        arr_final : felt*
    ):

    if idx == arr_str_len:
        return (arr_len, arr)
    end

    let (
        arr_nxt_len : felt,
        arr_nxt : felt*
    ) = array_concat (
        arr1_len = arr_len,
        arr1 = arr,
        arr2_len = arr_str[idx].arr_len,
        arr2 = arr_str[idx].arr
    )

    #
    # Tail recursion
    #
    let (
        arr_final_len : felt,
        arr_final : felt*
    ) = _recurse_str_concat_array (
        arr_str_len = arr_str_len,
        arr_str = arr_str,
        arr_len = arr_nxt_len,
        arr = arr_nxt,
        idx = idx + 1
    )

    return (arr_final_len, arr_final)
end

#
# Create an instance of Str from single-felt string literal
#
func str_from_literal {range_check_ptr} (
    literal : felt) -> (str : Str):

    let len = 1
    let (arr : felt*) = alloc()
    assert arr[0] = literal

    return ( Str (len,arr) )
end

#
# Create instance of Str that is empty
#
func str_empty  {range_check_ptr} (
    ) -> (str : Str):

    let len = 0
    let (arr : felt*) = alloc()

    return ( Str (len,arr) )
end
