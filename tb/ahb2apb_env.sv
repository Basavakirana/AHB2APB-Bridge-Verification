class ahb2apb_env extends uvm_env;

        `uvm_component_utils(ahb2apb_env)

        ahb_agt_top h_toph;
        apb_agt_top p_toph;
        ahb2apb_sb sbh;
        vsequencer vseqrh;
        env_config env_configh;

        extern function new (string name ="ahb2apb_env", uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);

        endclass

        function ahb2apb_env::new(string name ="ahb2apb_env", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void ahb2apb_env:: build_phase (uvm_phase phase);
                if(!uvm_config_db #(env_config)::get(this,"","env_config",env_configh))
                        `uvm_fatal("env_configh","cannot get config data");
                super.build_phase(phase);
        if(env_configh.has_ahb_agent)
                begin
        //              uvm_config_db #(ahb_agt_config)::set(this,"h_agnth*","ahb_agt_config",env_configh.h_configh);
                        h_toph = ahb_agt_top::type_id::create("h_toph",this);
                end
        if(env_configh.has_apb_agent)
                begin
        //              uvm_config_db #(apb_agt_config)::set(this,"p_agnth*","apb_agt_config",env_configh.p_configh);
                        p_toph = apb_agt_top::type_id::create("p_toph",this);
                end
                if(env_configh.has_vseqr)
                        vseqrh = vsequencer::type_id::create("vseqrh",this);
                if(env_configh.has_scoreboard)
                        sbh = ahb2apb_sb::type_id::create("sbh",this);
        endfunction

        function void ahb2apb_env :: connect_phase (uvm_phase phase);

                if(env_configh.has_scoreboard)
                begin
                        h_toph.h_agnth.h_monh.monitor_port.connect(sbh.fifo_ahb.analysis_export);
                        p_toph.p_agnth.p_monh.monitor_port.connect(sbh.fifo_apb.analysis_export);
                end
        endfunction
