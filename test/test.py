# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 0

    dut._log.info("Test project behavior")
    
    #######

    await send(dut, True, 0, 100)
    await send(dut, True, 1, 200)

    assert await send(dut, False, 0) == 100
    assert await send(dut, False, 1) == 200

    # await send(dut, True, 0, 100)
    # await send(dut, True, 1, 200)

    # assert await send(dut, False, 0) == 100
    # assert await send(dut, False, 1) == 200
    # assert await send(dut, False, 0) == 100

    # await send(dut, True, 0, 35)

    # assert await send(dut, False, 1) == 200


async def send(dut, write: bool, register: int, value: int = 0) -> int:
    dut.ui_in.value = value

    write_value = register << 1
    if write:
        write_value = set_bit(write_value, 0)
    
    dut.uio_in.value = write_value
    
    await ClockCycles(dut.clk, 1)

    return int(dut.uo_out.value)

# Source - https://stackoverflow.com/a/12174125
# Posted by Kos, modified by community. See post 'Timeline' for change history
# Retrieved 2026-03-14, License - CC BY-SA 3.0

def set_bit(value, bit):
    return value | (1<<bit)

def clear_bit(value, bit):
    return value & ~(1<<bit)
