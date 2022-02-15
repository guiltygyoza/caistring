%lang starknet

from contracts.Str import (
    Str,
    str_from_number,
    str_concat_literal,
    literal_concat_known_length_dangerous,
    pow2
)

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

#
# Test str_concat_literal()
#
@view
func str_concat_literal_test {range_check_ptr} (
        str_arr_in_len : felt,
        str_arr_in : felt*,
        literal : felt
    ) -> (
        str_arr_out_len : felt,
        str_arr_out : felt*
    ):

    let str_in = Str (str_arr_in_len, str_arr_in)
    let (str_out) = str_concat_literal (str_in, literal)

    return (str_out.arr_len, str_out.arr)
end


#
# Test literal_concat_known_length_dangerous()
#
@view
func literal_concat_known_length_dangerous_test {range_check_ptr} (
        literal1 : felt,
        literal2 : felt,
        len2 : felt
    ) -> (
        res : felt
    ):
    let (res) = literal_concat_known_length_dangerous(literal1, literal2, len2)
    return (res)
end

#
# Test pow2()
#
@view
func pow2_test (x) -> (y):
    let (y) = pow2(x)
    return (y)
end