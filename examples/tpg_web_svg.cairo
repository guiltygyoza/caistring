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
    assert arr[2] = '160"><polygon fill="#75bcb2" p'
    assert arr[3] = 'oints="110.62 149.06 102.63 10'
    assert arr[4] = '.94 51.62 42.59 110.62 149.06"'
    assert arr[5] = '><animate id="shape1" attribut'
    assert arr[6] = 'eName="points" to="85.43 103.6'
    assert arr[7] = ' 147.1 18.21 19.97 103.6 85.43'
    assert arr[8] = ' 103.6" dur="5s" fill="freeze"'
    assert arr[9] = ' begin="0s; shape_og.end"/><an'
    assert arr[10] = 'imate id="shape2" attributeNam'
    assert arr[11] = 'e="points" to="107.99 103.6 14'
    assert arr[12] = '7.1 67.19 17.8 33.87 107.99 10'
    assert arr[13] = '3.6" dur="5s" fill="freeze" be'
    assert arr[14] = 'gin="shape1.end"/><animate id='
    assert arr[15] = '"shape_og" attributeName="poin'
    assert arr[16] = 'ts" to="110.62 149.06 102.63 1'
    assert arr[17] = '0.94 51.62 42.59 110.62 149.06'
    assert arr[18] = '" dur="5s" fill="freeze" begin'
    assert arr[19] = '="shape2.end"/><animate id="co'
    assert arr[20] = 'lor1" begin="0s; color_og.end"'
    assert arr[21] = ' fill="freeze" attributeName="'
    assert arr[22] = 'fill" dur="5s" to="#dce4ef"></'
    assert arr[23] = 'animate><animate id="color2" b'
    assert arr[24] = 'egin="color1.end" fill="freeze'
    assert arr[25] = '" attributeName="fill" dur="5s'
    assert arr[26] = '" to="#8661c1"></animate><anim'
    assert arr[27] = 'ate id="color_og" begin="color'
    assert arr[28] = '2.end" fill="freeze" attribute'
    assert arr[29] = 'Name="fill" dur="5s" to="#75bc'
    assert arr[30] = 'b2"></animate></polygon></svg>'

    return (31, arr)
end

