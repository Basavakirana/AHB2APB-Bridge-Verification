class ahb_agent extends uvm_agent;

        `uvm_component_utils(ahb_agent)

        ahb_agt_config h_configh;
        ahb_driver h_drvh;
        ahb_monitor h_monh;
        ahb_sequencer h_seqrh;

        extern function new (string name ="ahb_agent",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);

        endclass

        function ahb_agent::new(string name ="ahb_agent",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void ahb_agent::build_phase (uvm_phase phase);
                super.build_phase (phase);
                        if(!uvm_config_db #(ahb_agt_config)::get(this,"","ahb_agt_config",h_configh))
                                `uvm_fatal("ahb_agent","cannot get config data");
                        h_monh = ahb_monitor::type_id::create("h_monh",this);
                        if(h_configh.is_active ==UVM_ACTIVE)
                                begin
                                        h_seqrh = ahb_sequencer::type_id::create("h_seqrh",this);
                                        h_drvh = ahb_driver::type_id::create("h_drvh",this);
                                end
        endfunction

        function void ahb_agent::connect_phase (uvm_phase phase);
                super.connect_phase(phase);
        if(h_configh.is_active ==UVM_ACTIVE)
                h_drvh.seq_item_port.connect(h_seqrh.seq_item_export);
        endfunction
