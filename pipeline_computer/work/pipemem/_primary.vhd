library verilog;
use verilog.vl_types.all;
entity pipemem is
    port(
        we              : in     vl_logic;
        addr            : in     vl_logic_vector(31 downto 0);
        datain          : in     vl_logic_vector(31 downto 0);
        clock           : in     vl_logic;
        dmem_clk        : in     vl_logic;
        dataout         : out    vl_logic_vector(31 downto 0);
        out_port0       : out    vl_logic_vector(31 downto 0);
        out_port1       : out    vl_logic_vector(31 downto 0);
        out_port2       : out    vl_logic_vector(31 downto 0);
        in_port0        : in     vl_logic_vector(31 downto 0);
        in_port1        : in     vl_logic_vector(31 downto 0);
        and_model       : in     vl_logic;
        add_model       : in     vl_logic;
        mem_dataout     : out    vl_logic_vector(31 downto 0);
        io_read_data    : out    vl_logic_vector(31 downto 0)
    );
end pipemem;
