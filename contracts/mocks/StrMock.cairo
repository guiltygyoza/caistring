%lang starknet

from contracts.Str import (Str, str_from_number)

#
# Test str_from_number() and extract the array from Str struct,
# because starknet unit test framework does not allow pointer return yet
#
@view
func str_from_number_test {range_check_ptr} (
    num : felt) -> (str_arr_len : felt, str_arr : felt*):
    let (str) = str_from_number(num)
    return (str.arr_len, str.arr)
end
