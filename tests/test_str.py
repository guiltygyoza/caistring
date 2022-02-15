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

    print(f'> Testing str_from_number() ...')
    TEST_NUMS = [0, 1, 9, 127, 1000, 9876543210]
    for num in TEST_NUMS:
        ret = await contract.str_from_number_test(num).call()
        parsed = felt_to_ascii(ret.result.str_arr[0])
        assert felt_to_ascii(ret.result.str_arr[0]) == str(num)

    print(f'> Testing str_concat_literal() ...')
    for num in TEST_NUMS:
        ret = await contract.str_concat_literal_test (
            [1,2,3],
            num
        ).call()
        assert ret.result.str_arr_out == [1,2,3] + [num]

    print(f'> Testing pow2() over input=[0,250] ...')
    for i in range(0,250):
        ret = await contract.pow2_test(i).call()
        assert ret.result.y == 2**i

    print(f'> Testing literal_concat_known_length_dangerous() ...')
    TEST_LITERAL1_S = ['7', '77', '777']
    TEST_LITERAL2_S = ['aa', 'bbb', '0123456789abcdefghi']
    for l1, l2 in zip(TEST_LITERAL1_S, TEST_LITERAL2_S):
        ret = await contract.literal_concat_known_length_dangerous_test(
            ascii_to_felt (l1),
            ascii_to_felt (l2),
            len(l2)
        ).call()
        recovered_literal = felt_to_ascii (ret.result.res)
        assert recovered_literal == (l1 + l2), f"{recovered_literal} != {l1+l2}"



def felt_to_ascii (felt):
    bytes_object = bytes.fromhex( hex(felt)[2:] )
    ascii_string = str(bytes_object.decode("ascii"))
    return ascii_string

def ascii_to_felt (s):
    return int.from_bytes( s.encode('ascii'), 'big' )