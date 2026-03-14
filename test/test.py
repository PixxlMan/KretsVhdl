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

    send(dut, True, 0, 100)
    send(dut, True, 1, 200)

    assert send(dut, False, 0, 0) == 100
    assert send(dut, False, 1, 0) == 200
    assert send(dut, False, 0, 0) == 100


async def send(dut, write: bool, register: int, value: int) -> int:
    dut.ui_in.value = value

    if write:
        if register == 0:
            dut.uio_in.value = 1

        elif register == 1:
            dut.uio_in.value = 3
            
    else:
        if register == 0:
            dut.uio_in.value = 0
        elif register == 1:
            dut.uio_in.value = 2
    
    await ClockCycles(dut.clk, 1)

    return int(dut.uo_out.value)