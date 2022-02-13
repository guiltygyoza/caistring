import pytest
import os
from starkware.starknet.testing.starknet import Starknet
import asyncio
from random import choices

@pytest.mark.asyncio
async def test_table ():

    starknet = await Starknet.empty()
    contract = await starknet.deploy('examples/tpg_web_projects.cairo')
    print()

    ret = await contract.return_html_table().call()
    recovered_html = felt_array_to_ascii(ret.result.arr)
    print(f'return_html_table(): {recovered_html}')

    assert recovered_html == '''<table><tr><td><a href="https://github.com/topology-gg/fountain" target="_blank" rel="noopener noreferrer">Fountain</a></td></tr><tr><td><a href="https://github.com/topology-gg/christopher" target="_blank" rel="noopener noreferrer">Christopher</a></td></tr></table>'''


def felt_array_to_ascii (felt_array):
    ret = ""
    for felt in felt_array:
        ret += felt_to_ascii (felt)
    return ret


def felt_to_ascii (felt):
    bytes_object = bytes.fromhex( hex(felt)[2:] )
    ascii_string = bytes_object.decode("ASCII")
    return ascii_string
