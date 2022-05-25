/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab01_data top module template file
-----------------------------------------------------------------*/

module top;

    // import the UVM library
    import uvm_pkg::*;

    // include the UVM macros
    `include "uvm_macros.svh"

    // import the YAPP package
    import yapp_pkg::*;

    yapp_packet packet;
    yapp_packet packet_copy;
    yapp_packet packet_clone;
    int ok;

    initial begin
        packet_copy = new("packet_copy");

        // generate 5 random packets and use the print method to display the results
        for (int i=0; i<5; i=i+1) begin
            packet=new("packet");
            ok = packet.randomize();    // assert(packet.randomize());
            $display("\n============================= YAPP packet[%2d] ==============================",i);
			// // packet.print();
            // packet.print(uvm_default_tree_printer);
			// $display("\n");
            // packet.print(uvm_default_line_printer);
			// $display("\n");
            packet.print(uvm_default_table_printer);
			$display("=============================================================================");
        end

        // experiment with the copy, clone and compare UVM method
        $display("===== Copying YAPP Packet");
        packet_copy.copy(packet);
        packet_copy.print();

        $display("===== Cloning YAPP Packet");
        $cast(packet_clone,packet.clone());
        packet_clone.print();

        $display("===== Comparing YAPP Packets");
        if (!packet_copy.compare(packet)) begin
            $display("YAPP packet content NOT SAME");
            packet.print();
            packet_copy.print();
        end
    end

endmodule : top
