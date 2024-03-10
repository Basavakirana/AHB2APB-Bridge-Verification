module top;

        import test_pkg::*;
        import uvm_pkg::*;

        bit clk;
        always #10 clk =~clk;

//      `include "uvm_macros.svh"

        ahb_xtn ahb_xtnh;

         ahb2apb_if in(clk);

         rtl_top RTL(
            .Hclk(clk),
            .Hresetn(in.Hrstn),
            .Htrans(in.Htrans),
            .Hsize(in.Hsize),
            .Hreadyin(in.Hreadyin),
            .Hwdata(in.Hwdata),
            .Haddr(in.Haddr),
            .Hwrite(in.Hwrite),
            .Hrdata(in.Hrdata),
            .Hresp(in.Hresp),
            .Hreadyout(in.Hreadyout),
            .Pselx(in.Pselx),
            .Pwrite(in.Pwrite),
            .Penable(in.Penable),
            .Prdata(in.Prdata),
            .Paddr(in.Paddr),
            .Pwdata(in.Pwdata)
            ) ;


        initial
                begin
                        `ifdef VCS
                        $fsdbDumpvars(0, top);
                        `endif

                        uvm_config_db #(virtual ahb2apb_if)::set(null,"*","vif",in);
                run_test();
                end

        initial begin
                ahb_xtnh = ahb_xtn::type_id::create("ahb_xtnh");
                assert(ahb_xtnh.randomize());
                ahb_xtnh.print(uvm_default_tree_printer);
        end

endmodule
