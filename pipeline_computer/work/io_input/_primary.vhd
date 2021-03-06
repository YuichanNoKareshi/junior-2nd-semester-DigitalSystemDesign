library verilog;
use verilog.vl_types.all;
entity io_input is
    port(
        addr            : in     vl_logic_vector(31 downto 0);
        io_clk          : in     vl_logic;
        io_read_data    : out    vl_logic_vector(31 downto 0);
        in_port0        : in     vl_logic_vector(31 downto 0);
        in_port1        : in     vl_logic_vector(31 downto 0);
        and_model       : in     vl_logic;
        add_model       : in     vl_logic
    );
end io_input;
