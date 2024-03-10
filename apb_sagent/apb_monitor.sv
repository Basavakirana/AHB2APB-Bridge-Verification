class apb_monitor extends uvm_monitor;

        `uvm_component_utils(apb_monitor)

        virtual ahb2apb_if.APB_MON_MP vif;
        uvm_analysis_port #(apb_xtn) monitor_port;

        apb_agt_config p_configh;

        extern function new(string name ="apb_monitor",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern task collect_data();
        extern function void report_phase (uvm_phase phase);

        endclass

        function apb_monitor::new (string name ="apb_monitor",uvm_component parent);
                super.new(name,parent);
                monitor_port = new("monitor_port",this);
        endfunction

        function void apb_monitor::build_phase (uvm_phase phase);
                if(!uvm_config_db #(apb_agt_config)::get(this,"","apb_agt_config",p_configh))
                        `uvm_fatal("apb_driver","cannot get config data");
        endfunction

        function void apb_monitor::connect_phase (uvm_phase phase);
                vif = p_configh.vif;
        endfunction

        task apb_monitor::run_phase(uvm_phase phase);
                forever
                        begin
                                collect_data();
                        end
        endtask

        task apb_monitor:: collect_data();
                apb_xtn xtn;
                xtn = apb_xtn::type_id::create("xtn");
                while(!vif.apb_mon_cb.Penable)
                @(vif.apb_mon_cb);
//                      #20;
                        xtn.Paddr = vif.apb_mon_cb.Paddr;
//                      #40;
                        xtn.Pwrite = vif.apb_mon_cb.Pwrite;
                        xtn.Pselx = vif.apb_mon_cb.Pselx;

                if(xtn.Pwrite==1)
                        xtn.Pwdata = vif.apb_mon_cb.Pwdata;
                else
                        xtn.Prdata = vif.apb_mon_cb.Prdata;
                @(vif.apb_mon_cb);

              repeat(2)
                      @(vif.apb_mon_cb);

                p_configh.mon_data_count++;
                monitor_port.write(xtn);
                `uvm_info("apb_monitor",$sformatf("printing from monitor \n %s",xtn.sprint()),UVM_LOW)
        endtask

        function void apb_monitor::report_phase (uvm_phase phase);
                `uvm_info(get_type_name(),$sformatf("report: apb_monitor recieved %0d transactions",p_configh.mon_data_count),UVM_LOW)
        endfunction
