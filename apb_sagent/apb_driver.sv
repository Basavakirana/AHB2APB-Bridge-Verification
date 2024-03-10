class apb_driver extends uvm_driver #(apb_xtn);

        `uvm_component_utils(apb_driver)

        virtual ahb2apb_if.APB_DRV_MP vif;
        apb_agt_config p_configh;
        apb_xtn xtn;

        extern function new(string name ="apb_driver",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern task send_to_dut (apb_xtn xtn);
        extern function void report_phase (uvm_phase phase);

        endclass

        function apb_driver::new (string name ="apb_driver",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void apb_driver::build_phase (uvm_phase phase);
                if(!uvm_config_db #(apb_agt_config)::get(this,"","apb_agt_config",p_configh))
                        `uvm_fatal("ahb_driver","cannot get config data");
        endfunction

        function void apb_driver::connect_phase (uvm_phase phase);
                vif=p_configh.vif;
        endfunction

        task apb_driver::run_phase (uvm_phase phase);
                req =apb_xtn::type_id::create("req");

                forever
                        begin
//                              seq_item_port.get_next_item(req);
//                              req =apb_xtn::type_id::create("req");
                                send_to_dut(req);
//                              seq_item_port.item_done();
                        end
        endtask

        task apb_driver::send_to_dut(apb_xtn xtn);
                while(vif.apb_drv_cb.Pselx ==0)
                @(vif.apb_drv_cb);
                @(vif.apb_drv_cb);
                while(!vif.apb_drv_cb.Penable)
                @(vif.apb_drv_cb);
                        if(vif.apb_drv_cb.Pwrite==0)
                                vif.apb_drv_cb.Prdata <= {$random};

                repeat(2)
                        @(vif.apb_drv_cb);

                p_configh.drv_data_count++;
                `uvm_info("apb_driver",$sformatf("printing from driver \n %s",xtn.sprint()),UVM_LOW)
        endtask

        function void apb_driver::report_phase (uvm_phase phase);
                `uvm_info(get_type_name(),$sformatf("report: apb_driver sent %0d transactions",p_configh.drv_data_count),UVM_LOW)
        endfunction
