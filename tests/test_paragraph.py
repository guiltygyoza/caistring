import pytest
import os
from starkware.starknet.testing.starknet import Starknet
import asyncio
from random import choices

@pytest.mark.asyncio
async def test_svg ():

    starknet = await Starknet.empty()
    contract = await starknet.deploy('examples/tpg_web_paragraph.cairo')
    print()

    ret = await contract.return_html_paragraphs().call()
    recovered_string = felt_array_to_ascii(ret.result.arr)
    print(f'> tpg::return_html_paragraphs(): {recovered_string}')

    assert recovered_string == "<p>:: Topology ::</p><p>where wizards stay up late.</p>"


def felt_array_to_ascii (felt_array):
    ret = ""
    for felt in felt_array:
        ret += felt_to_ascii (felt)
    return ret


def felt_to_ascii (felt):
    bytes_object = bytes.fromhex( hex(felt)[2:] )
    ascii_string = bytes_object.decode("ASCII")
    return ascii_string
