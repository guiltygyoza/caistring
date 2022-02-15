import pytest
import os
from starkware.starknet.testing.starknet import Starknet
import asyncio
from random import choices

@pytest.mark.asyncio
async def test_svg ():
    starknet = await Starknet.empty()
    print()

    #
    # Test tpg svg
    #
    contract_tpg = await starknet.deploy('examples/tpg_web_svg.cairo')
    ret = await contract_tpg.return_svg().call()
    recovered_svg = felt_array_to_ascii(ret.result.arr)
    print(f'> tpg::return_svg(): {recovered_svg}')

    assert recovered_svg == '''<svg xmlns="http://www.w3.org/2000/svg" width="160" height="160"><polygon fill="#258ed6" points="110.62 149.06 102.63 10.94 51.62 42.59 110.62 149.06"><animate id="shape1" attributeName="points" to="85.43 103.6 147.1 18.21 19.97 103.6 85.43 103.6" dur="1.5s" fill="freeze" begin="0s; shape_og.end"/><animate id="shape2" attributeName="points" to="107.99 103.6 147.1 67.19 17.8 33.87 107.99 103.6" dur="1.5s" fill="freeze" begin="shape1.end"/><animate id="shape_og" attributeName="points" to="110.62 149.06 102.63 10.94 51.62 42.59 110.62 149.06" dur="1.5s" fill="freeze" begin="shape2.end"/><animate id="color1" begin="0s; color_og.end" fill="freeze" attributeName="fill" dur="1.5s" to="#52a747"></animate><animate id="color2" begin="color1.end" fill="freeze" attributeName="fill" dur="1.5s" to="#f1fb3b"></animate><animate id="color_og" begin="color2.end" fill="freeze" attributeName="fill" dur="1.5s" to="#258ed6"></animate></polygon></svg>'''


# @pytest.mark.asyncio
# async def test_svg_one_circle ():
#     starknet = await Starknet.empty()
#     contract = await starknet.deploy('contracts/mocks/SvgMock.cairo')
#     print()

#     ret = await contract.generate_one_circle_svg_test().call()
#     recovered_svg = felt_array_to_ascii(ret.result.str_arr)
#     print(recovered_svg)

#     assert recovered_svg == '''<svg width="300" height="300" xmlns="http://www.w3.org/2000/svg"><circle cx="150" cy="150" r="50" stroke="#3A3A3A" fill="#FCFC99" /></svg>'''


def felt_array_to_ascii (felt_array):
    ret = ""
    for felt in felt_array:
        ret += felt_to_ascii (felt)
    return ret


def felt_to_ascii (felt):
    bytes_object = bytes.fromhex( hex(felt)[2:] )
    ascii_string = bytes_object.decode("ASCII")
    return ascii_string
