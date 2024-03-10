class apb_agt_top extends uvm_env;

        `uvm_component_utils(apb_agt_top)

        env_config env_configh;
        apb_agt_config p_configh;
        apb_agent p_agnth;

        extern function new (string name ="apb_agt_top",uvm_component parent);
        extern function void build_phase (uvm_phase phase);

        endclass

        function apb_agt_top ::new(string name ="apb_agt_top",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void apb_agt_top::build_phase (uvm_phase phase);
                if(!uvm_config_db #(env_config)::get(this,"","env_config",env_configh))
                        `uvm_fatal("ahb_agt_top","cannot get config data");
        if(env_configh.has_apb_agent)
                begin
                p_agnth = apb_agent::type_id::create("p_agnth",this);
                uvm_config_db #(apb_agt_config)::set(this,"p_agnth*","apb_agt_config",env_configh.p_configh);
                end

        endfunction
