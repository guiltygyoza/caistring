import pytest
import os
from starkware.starknet.testing.starknet import Starknet
import asyncio
from random import choices

@pytest.mark.asyncio
async def test_str ():

    starknet = await Starknet.empty()
    contract = await starknet.deploy('contracts/mocks/StrMock.cairo')
    print()

    TEST_NUMS = [0, 1, 9, 1000, 9876543210]
    for num in TEST_NUMS:
        ret = await contract.str_from_number_test(num).call()
        parsed = felt_to_ascii(ret.result.str_arr[0])
        assert felt_to_ascii(ret.result.str_arr[0]) == str(num)
        print(f'> passed: {num}')


def felt_to_ascii (felt):
    bytes_object = bytes.fromhex( hex(felt)[2:] )
    ascii_string = bytes_object.decode("ASCII")
    return ascii_string
