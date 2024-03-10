class ahb_monitor extends uvm_monitor;

        `uvm_component_utils(ahb_monitor)

        virtual ahb2apb_if.AHB_MON_MP vif;
        ahb_agt_config h_configh;
        uvm_analysis_port #(ahb_xtn) monitor_port;

        extern function new(string name ="ahb_monitor",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern task collect_data ();
        extern function void report_phase (uvm_phase phase);

        endclass

        function ahb_monitor::new (string name ="ahb_monitor",uvm_component parent);
                super.new(name,parent);
                monitor_port = new("monitor_port",this);
        endfunction

        function void ahb_monitor::build_phase (uvm_phase phase);
                if(!uvm_config_db #(ahb_agt_config)::get(this,"","ahb_agt_config",h_configh))
                        `uvm_fatal("ahb_driver","cannot get config data");
        endfunction

        function void ahb_monitor::connect_phase (uvm_phase phase);
                vif = h_configh.vif;
        endfunction

        task ahb_monitor::run_phase (uvm_phase phase);
                forever
                        begin
                                collect_data();
                        end
        endtask

        task ahb_monitor::collect_data();
                ahb_xtn xtn;
                xtn = ahb_xtn::type_id::create("xtn");
                #20;
                @(vif.ahb_mon_cb);
                while(~(vif.ahb_mon_cb.Htrans==2'b10 || vif.ahb_mon_cb.Htrans==2'b11))
                @(vif.ahb_mon_cb);
                xtn.Htrans = vif.ahb_mon_cb.Htrans;
                xtn.Hwrite = vif.ahb_mon_cb.Hwrite;
                xtn.Hsize = vif.ahb_mon_cb.Hsize;
                xtn.Haddr = vif.ahb_mon_cb.Haddr;

                @(vif.ahb_mon_cb);
                while(~vif.ahb_mon_cb.Hreadyout)
                @(vif.ahb_mon_cb);
                #20;
                        if(vif.ahb_mon_cb.Hwrite==1'b0)
                                xtn.Hrdata = vif.ahb_mon_cb.Hrdata;
                        else
                                xtn.Hwdata = vif.ahb_mon_cb.Hwdata;
                repeat(2)
                        @(vif.ahb_mon_cb);

                 h_configh.mon_data_count++;

                monitor_port.write(xtn);
                `uvm_info("ahb_monitor",$sformatf("printing from monitor \n %s",xtn.sprint()),UVM_LOW)
        endtask

        function void ahb_monitor::report_phase(uvm_phase phase);
                `uvm_info(get_type_name(),$sformatf("report: ahb_monitor recieved %0d transactions",h_configh.mon_data_count),UVM_LOW)
        endfunction
