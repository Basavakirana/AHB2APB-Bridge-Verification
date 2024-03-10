class ahb_driver extends uvm_driver #(ahb_xtn);

        `uvm_component_utils(ahb_driver)

        virtual ahb2apb_if.AHB_DRV_MP vif;
        ahb_agt_config h_configh;
        ahb_xtn xtn;

        extern function new(string name ="ahb_driver",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern task drive_to_dut (ahb_xtn xtn);
        extern function void report_phase (uvm_phase phase);

        endclass

        function ahb_driver::new (string name ="ahb_driver",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void ahb_driver::build_phase (uvm_phase phase);
                if(!uvm_config_db #(ahb_agt_config)::get(this,"","ahb_agt_config",h_configh))
                        `uvm_fatal("ahb_driver","cannot get config data");
        endfunction

        function void ahb_driver::connect_phase (uvm_phase phase);
                vif = h_configh.vif;
        endfunction

        task ahb_driver ::run_phase (uvm_phase phase);
                @(vif.ahb_drv_cb);
                        vif.ahb_drv_cb.Hrstn<=0;
                @(vif.ahb_drv_cb);
                        vif.ahb_drv_cb.Hrstn<=1;
                forever
                        begin
                                seq_item_port.get_next_item(req);
//                              #40;
                                drive_to_dut(req);
                                seq_item_port.item_done();
                        end
        endtask

        task ahb_driver :: drive_to_dut(ahb_xtn xtn);
                @(vif.ahb_drv_cb);
                vif.ahb_drv_cb.Hwrite <= xtn.Hwrite;
                $display("display hwrite is =%d", xtn.Hwrite);
                vif.ahb_drv_cb.Htrans <= xtn.Htrans;
                vif.ahb_drv_cb.Hsize <= xtn.Hsize;
                vif.ahb_drv_cb.Haddr <= xtn.Haddr;
                vif.ahb_drv_cb.Hreadyin <= 1'b1;

                @(vif.ahb_drv_cb);
                while(~vif.ahb_drv_cb.Hreadyout)
                @(vif.ahb_drv_cb);
                        if(xtn.Hwrite==1)
                                vif.ahb_drv_cb.Hwdata <= xtn.Hwdata;
                                else
                                vif.ahb_drv_cb.Hwdata <= 32'b0;

                repeat(2)
                        @(vif.ahb_drv_cb);

                h_configh.drv_data_count++;
                `uvm_info("ahb_driver",$sformatf("printing from driver \n %s",xtn.sprint()),UVM_LOW)
        endtask

        function void ahb_driver::report_phase (uvm_phase phase);
                `uvm_info(get_type_name(),$sformatf("report: ahb_driver sent %0d transactions",h_configh.drv_data_count),UVM_LOW)
        endfunction
