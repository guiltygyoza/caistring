%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import (unsigned_div_rem, sign, assert_nn, abs_value, assert_not_zero, sqrt)
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

#
# Convert felt (decimal) into ascii-encoded felt, return a string
# e.g. 7 => 55
# e.g. 77 => 55*256 + 55 = 14135
# fail if needed more than 31 characters
#
func str_from_number {range_check_ptr} (
    num : felt) -> (str : Str):
    alloc_locals

    #
    # Handle special case first
    #
    if num == 0:
        return str_from_literal ('0')
    end

    let (arr_ascii) = alloc()
    let (
        arr_ascii_len : felt
    ) = _recurse_ascii_array_from_number (
        remain = num,
        arr_ascii_len = 0,
        arr_ascii = arr_ascii
    )

    let (ascii) = _recurse_ascii_from_ascii_array_inverse (
        ascii = 0,
        len = arr_ascii_len,
        arr = arr_ascii,
        idx = 0
    )

    let (str : Str) = str_from_literal (ascii)
    # let str = Str (arr_ascii_len, arr_ascii)
    return (str)
end

func _recurse_ascii_array_from_number {range_check_ptr} (
        remain : felt,
        arr_ascii_len : felt,
        arr_ascii : felt*
    ) -> (
        arr_ascii_final_len : felt
    ):
    alloc_locals

    if remain == 0:
        return (arr_ascii_len)
    end

    let (remain_nxt, digit) = unsigned_div_rem (remain, 10)
    let (ascii) = ascii_from_digit (digit)
    assert arr_ascii[arr_ascii_len] = ascii

    #
    # Tail recursion
    #
    let (arr_ascii_final_len) = _recurse_ascii_array_from_number (
        remain = remain_nxt,
        arr_ascii_len = arr_ascii_len + 1,
        arr_ascii = arr_ascii
    )
    return (arr_ascii_final_len)
end

func _recurse_ascii_from_ascii_array_inverse {range_check_ptr} (
        ascii : felt,
        len : felt,
        arr : felt*,
        idx : felt
    ) -> (ascii_final : felt):

    if idx == len:
        return (ascii)
    end

    let ascii_nxt = ascii * 256 + arr[len-idx-1]

    #
    # Tail recursion
    #
    let (ascii_final) = _recurse_ascii_from_ascii_array_inverse (
        ascii = ascii_nxt,
        len = len,
        arr = arr,
        idx = idx + 1
    )
    return (ascii_final)
end

#
# Get ascii in decimal value from given digit
# note: does not check if input is indeed a digit
#
func ascii_from_digit (digit : felt) -> (ascii : felt):
    return (digit + '0')
end