class ahb_agt_top extends uvm_env;

        `uvm_component_utils(ahb_agt_top)

        env_config env_configh;
        ahb_agt_config h_configh;
        ahb_agent h_agnth;

        extern function new (string name ="ahb_agt_top",uvm_component parent);
        extern function void build_phase (uvm_phase phase);

        endclass

        function ahb_agt_top ::new(string name ="ahb_agt_top",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void ahb_agt_top::build_phase (uvm_phase phase);
                if(!uvm_config_db #(env_config)::get(this,"","env_config",env_configh))
                        `uvm_fatal("ahb_agt_top","cannot get config data");
        if(env_configh.has_ahb_agent)
                begin
                h_agnth = ahb_agent::type_id::create("h_agnth",this);
                uvm_config_db #(ahb_agt_config)::set(this,"h_agnth*","ahb_agt_config",env_configh.h_configh);
                end
        endfunction
