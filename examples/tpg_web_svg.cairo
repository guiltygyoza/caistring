%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc

@view
func return_svg {
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
    } () -> (arr_len : felt, arr : felt*):
    alloc_locals

    let (arr) = alloc()
    assert arr[0] = '<svg xmlns="http://www.w3.org/'
    assert arr[1] = '2000/svg" width="160" height="'
    assert arr[2] = '160"><polygon fill="#258ed6" p'
    assert arr[3] = 'oints="110.62 149.06 102.63 10'
    assert arr[4] = '.94 51.62 42.59 110.62 149.06"'
    assert arr[5] = '><animate id="shape1" attribut'
    assert arr[6] = 'eName="points" to="85.43 103.6'
    assert arr[7] = ' 147.1 18.21 19.97 103.6 85.43'
    assert arr[8] = ' 103.6" dur="1.5s" fill="freez'
    assert arr[9] = 'e" begin="0s; shape_og.end"/><'
    assert arr[10] = 'animate id="shape2" attributeN'
    assert arr[11] = 'ame="points" to="107.99 103.6 '
    assert arr[12] = '147.1 67.19 17.8 33.87 107.99 '
    assert arr[13] = '103.6" dur="1.5s" fill="freeze'
    assert arr[14] = '" begin="shape1.end"/><animate'
    assert arr[15] = ' id="shape_og" attributeName="'
    assert arr[16] = 'points" to="110.62 149.06 102.'
    assert arr[17] = '63 10.94 51.62 42.59 110.62 14'
    assert arr[18] = '9.06" dur="1.5s" fill="freeze"'
    assert arr[19] = ' begin="shape2.end"/><animate '
    assert arr[20] = 'id="color1" begin="0s; color_o'
    assert arr[21] = 'g.end" fill="freeze" attribute'
    assert arr[22] = 'Name="fill" dur="1.5s" to="#52'
    assert arr[23] = 'a747"></animate><animate id="c'
    assert arr[24] = 'olor2" begin="color1.end" fill'
    assert arr[25] = '="freeze" attributeName="fill"'
    assert arr[26] = ' dur="1.5s" to="#f1fb3b"></ani'
    assert arr[27] = 'mate><animate id="color_og" be'
    assert arr[28] = 'gin="color2.end" fill="freeze"'
    assert arr[29] = ' attributeName="fill" dur="1.5'
    assert arr[30] = 's" to="#258ed6"></animate></po'
    assert arr[31] = 'lygon></svg>'

    return (32, arr)
end

