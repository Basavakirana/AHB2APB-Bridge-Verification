class apb_agent extends uvm_agent;

        `uvm_component_utils(apb_agent)

        apb_agt_config p_configh;
        apb_driver p_drvh;
        apb_monitor p_monh;
        apb_sequencer p_seqrh;

        extern function new (string name ="apb_agent",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);

        endclass

        function apb_agent::new(string name ="apb_agent",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void apb_agent::build_phase (uvm_phase phase);
                super.build_phase (phase);
                        if(!uvm_config_db #(apb_agt_config)::get(this,"","apb_agt_config",p_configh))
                                `uvm_fatal("ahb_agent","cannot get config data");
                        p_monh = apb_monitor::type_id::create("p_monh",this);
                        if(p_configh.is_active ==UVM_ACTIVE)
                                begin
                                       p_seqrh = apb_sequencer::type_id::create("p_seqrh",this);
                                        p_drvh = apb_driver::type_id::create("p_drvh",this);
                                end
        endfunction

        function void apb_agent::connect_phase (uvm_phase phase);
                super.connect_phase(phase);
        if(p_configh.is_active ==UVM_ACTIVE)
                p_drvh.seq_item_port.connect(p_seqrh.seq_item_export);
        endfunction
