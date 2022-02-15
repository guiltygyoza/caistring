%lang starknet

from contracts.Str import Str
from contracts.Svg import generate_one_circle_svg

#
# Test generate_one_circle_svg()
#
@view
func generate_one_circle_svg_test {range_check_ptr} () -> (
        str_arr_len : felt,
        str_arr : felt*
    ):
    let (svg_str) = generate_one_circle_svg ()

    return (svg_str.arr_len, svg_str.arr)
end