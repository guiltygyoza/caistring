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

    assert recovered_svg == '''<svg xmlns="http://www.w3.org/2000/svg" width="160" height="160"><polygon fill="#75bcb2" points="110.62 149.06 102.63 10.94 51.62 42.59 110.62 149.06"><animate id="shape1" attributeName="points" to="85.43 103.6 147.1 18.21 19.97 103.6 85.43 103.6" dur="5s" fill="freeze" begin="0s; shape_og.end"/><animate id="shape2" attributeName="points" to="107.99 103.6 147.1 67.19 17.8 33.87 107.99 103.6" dur="5s" fill="freeze" begin="shape1.end"/><animate id="shape_og" attributeName="points" to="110.62 149.06 102.63 10.94 51.62 42.59 110.62 149.06" dur="5s" fill="freeze" begin="shape2.end"/><animate id="color1" begin="0s; color_og.end" fill="freeze" attributeName="fill" dur="5s" to="#dce4ef"></animate><animate id="color2" begin="color1.end" fill="freeze" attributeName="fill" dur="5s" to="#8661c1"></animate><animate id="color_og" begin="color2.end" fill="freeze" attributeName="fill" dur="5s" to="#75bcb2"></animate></polygon></svg>'''


def felt_array_to_ascii (felt_array):
    ret = ""
    for felt in felt_array:
        ret += felt_to_ascii (felt)
    return ret


def felt_to_ascii (felt):
    bytes_object = bytes.fromhex( hex(felt)[2:] )
    ascii_string = bytes_object.decode("ASCII")
    return ascii_string
