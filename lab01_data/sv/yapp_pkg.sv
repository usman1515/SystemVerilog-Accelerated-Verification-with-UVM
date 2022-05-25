/*-----------------------------------------------------------------
File name     : yapp_pkg.sv
Description   : lab01_data yapp UVC package for accelerated UVM
-------------------------------------------------------------------*/

package yapp_pkg;

    // import the UVM library
    import uvm_pkg::*;
    // include the UVM macros
    `include "uvm_macros.svh"

    // include the YAPP packet definition
    `include "./sv/yapp_packet.sv"

endpackage : yapp_pkg