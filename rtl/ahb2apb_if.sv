interface ahb2apb_if (input bit clk);

                bit Hrstn;
                bit Hwrite;
                bit [2:0] Hsize;
                bit [1:0] Htrans;
                bit Hreadyin;
                bit Hreadyout;
                bit [31:0] Haddr;
                bit [2:0] Hburst;
                bit [1:0] Hresp;
                bit [31:0] Hwdata;
                bit [31:0] Hrdata;

                bit Penable;
                bit Pwrite;
                bit [31:0] Prdata;
                bit [31:0] Pwdata;
                bit [31:0] Paddr;
                bit [3:0] Pselx;

                clocking ahb_drv_cb @(posedge clk);
                default input #1 output #1;
                                output Hwrite;
                                output Hreadyin;
                                output Hwdata;
                                output Haddr;
                                output Htrans;
                                output Hburst;
                                output Hrstn;
                                output Hsize;
                                input Hrdata;
                                input Hreadyout;
                endclocking

                clocking ahb_mon_cb @(posedge clk);
                default input #1 output #1;
                                input Hwrite;
                                input Hreadyin;
                                input Hwdata;
                                input Haddr;
                                input Htrans;
                                input Hburst;
                                input Hrstn;
                                input Hsize;
                                input Hreadyout;
                                input Hrdata;
                endclocking

                modport AHB_DRV_MP (clocking ahb_drv_cb);
                modport AHB_MON_MP (clocking ahb_mon_cb);

                clocking apb_drv_cb @(posedge clk);
                default input #1 output #1;
                                output Prdata;
                                input Penable;
                                input Pwrite;
                                input Pselx;
                endclocking

                clocking apb_mon_cb @(posedge clk);
                default input #1 output #1;
                                input Prdata;
                                input Penable;
                                input Pwrite;
                                input Pselx;
                                input Paddr;
                                input Pwdata;
                endclocking

                modport APB_DRV_MP (clocking apb_drv_cb);
                modport APB_MON_MP (clocking apb_mon_cb);

parameter SINGLE = 3'b000, INCR4 = 3'b011, WRAP4 = 3'b010, INCR8 = 3'b101, WRAP8 = 3'b100, INCR16 = 3'b111, WRAP16 = 3'b110;
parameter IDLE = 2'b00, BUSY = 2'b01, NON_SEQ = 2'b10, SEQ = 2'b11;

property master_nowait_single;
        @(posedge clk) disable iff(( !Hrstn ))

        ( Hburst == SINGLE ) |-> ( Htrans == NON_SEQ || Htrans == IDLE);
endproperty

SINGLE_XTN: assert property (master_nowait_single);
property master_nowait_incr4_wrap4;
        @(posedge clk) disable iff(( !Hrstn ) ||
                                    ( ( Htrans == IDLE ) ||
                                      ( Htrans == BUSY ) )
                                                )

          ( Hburst == INCR4 || Hburst == WRAP4)   &&
          ( Htrans == NON_SEQ )  |=>
          ( ( Htrans == SEQ ) ) [*3];
endproperty

INCR4_WRAP4: assert property (master_nowait_incr4_wrap4)
                $display("Assertions Passed", $time);
             else
                $display("Assertions failed", $time);

property master_nowait_incr8_wrap8;
        @(posedge clk) disable iff(( !Hrstn ) ||
                                    ( ( Htrans == IDLE ) ||
                                      ( Htrans == BUSY ) )
                                                )

          ( Hburst == INCR8 || Hburst == WRAP8)   &&
          ( Htrans == NON_SEQ )  ##1
          ( ( Htrans == SEQ ) ) [*7] |-> 1;
endproperty

INCR8_WRAP8:  assert property (master_nowait_incr8_wrap8);

property master_nowait_incr16_wrap16;
        @(posedge clk) disable iff(( !Hrstn ) ||
                                    ( ( Htrans == IDLE ) ||
                                      ( Htrans == BUSY ) )
                                                )

          ( Hburst == INCR16 || Hburst == WRAP16)   &&
          ( Htrans == NON_SEQ )  ##1
          ( ( Htrans == SEQ ) ) [*15] |-> 1;
endproperty

INCR16_WRAP16: assert property (master_nowait_incr16_wrap16);

property only_one_bit_high_Psel;
//        @(posedge clk)  (Pselx == 4'b0000 || Pselx == 4'b1000 || Pselx == 4'b0100 || Pselx == 4'b0010 || Pselx == 4'b0001);

       @(posedge clk) $onehot0(Pselx);

endproperty;

ONLY_ONE_BIT_HIGH_PSEL: assert property (only_one_bit_high_Psel);

property penable_high_for_one_cycle;
        @(posedge clk) Penable[->1] |=> !(Penable);
endproperty

      PENABLE_HIGH: assert property (penable_high_for_one_cycle);



endinterface
