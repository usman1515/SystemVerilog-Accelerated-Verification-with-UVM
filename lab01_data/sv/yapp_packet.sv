/*-----------------------------------------------------------------
File name     : yapp_packet.sv
Description   : lab01_data YAPP UVC packet template file
-------------------------------------------------------------------*/

// Define your enumerated type(s) here
typedef enum bit {BAD_PARITY, GOOD_PARITY} parity_t;

class yapp_packet extends uvm_sequence_item;

	// Define protocol data
	rand bit 	[5:0] length;
	rand bit 	[1:0] addr;
	rand bit 	[7:0] payload [];
	bit 		[7:0] parity;

	// Define control knobs
	rand parity_t parity_type;
	rand int packet_delay;

	// Enable automation of the packet's fields using UVM macros
	`uvm_object_utils_begin(yapp_packet)
		`uvm_field_int(length,UVM_ALL_ON + UVM_DEC)
		`uvm_field_int(addr,UVM_ALL_ON + UVM_HEX)
		`uvm_field_array_int(payload,UVM_ALL_ON + UVM_HEX)
		`uvm_field_int(parity,UVM_ALL_ON + UVM_BIN)
		`uvm_field_enum(parity_t,parity_type,UVM_ALL_ON)
		`uvm_field_int(packet_delay,UVM_ALL_ON + UVM_DEC + UVM_NOCOMPARE)
	`uvm_object_utils_end

	// Constructor
	function new(string name="yapp_packet");
		super.new(name);
	endfunction

	// Define packet constraints
	constraint default_valid_addr	{addr < 3;}		// {addr != 2'd3;}
	constraint default_packet_len	{length > 0; length < 64;}
	constraint default_payload_size	{length == payload.size();}
	constraint default_parity_dist	{parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1};}
	constraint default_packet_delay	{packet_delay >= 0; packet_delay <= 20;}

	// Add methods for parity calculation and class construction

	// Calculates correct parity over the header and payload
	function bit [7:0] calc_parity();
		calc_parity = {length,addr};
		for (int i=0; i<length; i=i+1) begin
			calc_parity = calc_parity ^ payload[i];
		end
	endfunction

	// sets parity field according to parity_type
	function void set_parity();
		parity = calc_parity();
		if (parity == BAD_PARITY) begin
			parity++;
		end
	endfunction

	// post_randomize() - sets parity
	function void post_randomize();
		set_parity();
	endfunction

endclass: yapp_packet
