class ahb2apb_sb extends uvm_scoreboard;


        `uvm_component_utils(ahb2apb_sb)

        uvm_tlm_analysis_fifo #(ahb_xtn) fifo_ahb;
        uvm_tlm_analysis_fifo #(apb_xtn) fifo_apb;

        ahb_xtn ahb_data;
        apb_xtn apb_data;

        ahb_xtn ahb_cov_data;
        apb_xtn apb_cov_data;

        env_config e_cfg;

//      ahb_xtn q[$];

        int data_verified_count;

        extern function new (string name = "ahb2apb_sb", uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern function void check_data (apb_xtn xtn);
        extern function void compare_data (int Hdata, Pdata, Haddr, Paddr);
        extern function void report_phase (uvm_phase phase);

        covergroup ahb_cg;
                option.per_instance = 1;


                SIZE: coverpoint ahb_cov_data.Hsize {bins b2[] = {[0:2]} ;}

                TRANS: coverpoint ahb_cov_data.Htrans {bins trans[] = {[2:3]} ;}


                ADDR: coverpoint ahb_cov_data.Haddr {bins first_slave = {[32'h8000_0000:32'h8C00_03ff]} ;}
                        //                           bins second_slave = {[32'h8400_0000:32'h8400_03ff]};
                          //                           bins third_slave = {[32'h8800_0000:32'h8800_03ff]};
                            //                         bins fourth_slave = {[32'h8C00_0000:32'h8C00_03ff]};}

                DATA_IN: coverpoint ahb_cov_data.Hwdata {bins low = {[0:32'hffff_ffff]};}
                                              //           bins mid1 = {[32'h0001_ffff:32'hffff_ffff]};}

                DATA_OUT : coverpoint ahb_cov_data.Hrdata {bins low = {[0:32'hffff_ffff]};}
                                             //              bins mid1 = {[32'h0001_ffff:32'hffff_ffff]};}
                WRITE : coverpoint ahb_cov_data.Hwrite;

//              SIZEXWRITE: cross SIZE, WRITE;

        endgroup

        covergroup apb_cg;
                option.per_instance = 1;

                ADDR : coverpoint apb_cov_data.Paddr {bins first_slave = {[32'h8000_0000:32'h8C00_03ff]};}
                                  //                    bins second_slave = {[32'h8400_0000:32'h8400_03ff]};
                                    //                  bins third_slave = {[32'h8800_0000:32'h8800_03ff]};
                                      //                bins fourth_slave = {[32'h8C00_0000:32'h8C00_03ff]};}

                DATA_IN : coverpoint apb_cov_data.Pwdata {bins low = {[0:32'hffff_ffff]};}
                          //                                bins mid1 = {[32'h0001_ffff:32'hffff_ffff]};}

                DATA_OUT : coverpoint apb_cov_data.Prdata {bins low = {[0:32'hffff_ffff]};}

                WRITE : coverpoint apb_cov_data.Pwrite;

                SEL : coverpoint apb_cov_data.Pselx {bins first_slave = {[4'b0001 : 4'b1000]};}
                                          //           bins second_slave = {4'b0010};
                                           //          bins third_slave = {4'b0100};
                                          //           bins fourth_slave = {4'b1000};}

//              WRITEXSEL: cross WRITE, SEL;
        endgroup
        endclass

        function ahb2apb_sb::new (string name = "ahb2apb_sb", uvm_component parent);
                super.new (name, parent);
//              ahb_cov_data = new();
//              apb_cov_data = new();
                ahb_cg = new();
                apb_cg = new();
        endfunction

        function void  ahb2apb_sb::build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db #(env_config)::get(this, "", "env_config", e_cfg))
                        `uvm_fatal("CONFIG", "Cannot get() e_cfg, have you set() it?")

                fifo_ahb = new("fifo_ahb",this);
                fifo_apb = new("fifo_apb",this);
                ahb_data = ahb_xtn::type_id::create("ahb_data");
                apb_data = apb_xtn::type_id::create("apb_data");
        endfunction

        task ahb2apb_sb::run_phase(uvm_phase phase);

        fork

                begin
                forever
                        begin
                                fifo_ahb.get(ahb_data);
//                              q.push_back(ahb_data);
                        //      $display("Size of the queue = %d", q.size);
                                ahb_cov_data = ahb_data;
                                ahb_cg.sample();
                        end
                end

                begin
                forever
                        begin
                                fifo_apb.get(apb_data);
                                check_data(apb_data);
                                apb_cov_data = apb_data;
                                apb_cg.sample();
                        end
                end


        join
        endtask

        function void ahb2apb_sb::check_data(apb_xtn xtn);
  //            ahb_data = q.pop_front();

                if(ahb_data.Hwrite)
                begin
                case(ahb_data.Hsize)

                2'b00:
                begin
                        if(ahb_data.Haddr[1:0] == 2'b00)
                                compare_data(ahb_data.Hwdata[7:0], apb_data.Pwdata[7:0], ahb_data.Haddr, apb_data.Paddr);
                        if(ahb_data.Haddr[1:0] == 2'b01)
                                compare_data(ahb_data.Hwdata[15:8], apb_data.Pwdata[7:0], ahb_data.Haddr, apb_data.Paddr);
                        if(ahb_data.Haddr[1:0] == 2'b10)
                                compare_data(ahb_data.Hwdata[23:16], apb_data.Pwdata[7:0], ahb_data.Haddr, apb_data.Paddr);
                        if(ahb_data.Haddr[1:0] == 2'b11)
                                compare_data(ahb_data.Hwdata[31:24], apb_data.Pwdata[7:0], ahb_data.Haddr, apb_data.Paddr);

                end
                2'b01:
                begin
                        if(ahb_data.Haddr[1:0] == 2'b00)
                                compare_data(ahb_data.Hwdata[15:0], apb_data.Pwdata[15:0], ahb_data.Haddr, apb_data.Paddr);
                        if(ahb_data.Haddr[1:0] == 2'b10)
                                compare_data(ahb_data.Hwdata[31:16], apb_data.Pwdata[15:0], ahb_data.Haddr, apb_data.Paddr);
                end

                2'b10:
                        compare_data(ahb_data.Hwdata, apb_data.Pwdata, ahb_data.Haddr, apb_data.Paddr);

                endcase
                end

        else
                begin
                case(ahb_data.Hsize)

                2'b00:
                begin
                        if(ahb_data.Haddr[1:0] == 2'b00)
                                compare_data(ahb_data.Hrdata[7:0], apb_data.Prdata[7:0], ahb_data.Haddr, apb_data.Paddr);
                        if(ahb_data.Haddr[1:0] == 2'b01)
                                compare_data(ahb_data.Hrdata[7:0], apb_data.Prdata[15:8], ahb_data.Haddr, apb_data.Paddr);
                        if(ahb_data.Haddr[1:0] == 2'b10)
                                compare_data(ahb_data.Hrdata[7:0], apb_data.Prdata[23:16], ahb_data.Haddr, apb_data.Paddr);
                        if(ahb_data.Haddr[1:0] == 2'b11)
                                compare_data(ahb_data.Hrdata[7:0], apb_data.Prdata[31:24], ahb_data.Haddr, apb_data.Paddr);

                end

                2'b01:
                begin
                        if(ahb_data.Haddr[1:0] == 2'b00)
                                compare_data(ahb_data.Hrdata[15:0], apb_data.Prdata[15:0], ahb_data.Haddr, apb_data.Paddr);
                        if(ahb_data.Haddr[1:0] == 2'b10)
                                compare_data(ahb_data.Hrdata[15:0], apb_data.Prdata[31:16], ahb_data.Haddr, apb_data.Paddr);
                end

                2'b10:
                        compare_data(ahb_data.Hrdata, apb_data.Prdata, ahb_data.Haddr, apb_data.Paddr);

                endcase
        end
        endfunction

        function void ahb2apb_sb::compare_data(int Hdata, Pdata, Haddr, Paddr);

        if(Haddr == Paddr)
        begin
                $display("Address compared Successfully");
                $display("HADDR=%h, PADDR=%h", Haddr, Paddr);
        end
        else
        begin
                $display("Address not compared Successfully");
                $display("HADDR=%h, PADDR=%h", Haddr, Paddr);
        end

        if(Hdata == Pdata)
        begin
                $display("Data compared Successfully");
                $display("HDATA=%h, PDATA=%h", Hdata, Pdata);
        end
        else
        begin
                $display("Data not compared Successfully");
                $display("HDATA=%h, PDATA=%h", Hdata, Pdata);
        end

                data_verified_count ++;
                $display ("Data verified = %d", data_verified_count);
        endfunction

        function void ahb2apb_sb::report_phase (uvm_phase phase);
                `uvm_info(get_type_name(), $sformatf("report: ahb2apb_sb verified %0d transactions", data_verified_count),UVM_LOW)
        endfunction
