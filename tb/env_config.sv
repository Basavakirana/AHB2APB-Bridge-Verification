class env_config extends uvm_object;

        `uvm_object_utils(env_config)

        virtual ahb2apb_if vif;

        bit has_ahb_agent =1;
        bit has_apb_agent =1;
        bit has_scoreboard =1;
        bit has_vseqr =1;

        ahb_agt_config h_configh;
        apb_agt_config p_configh;

        extern function new (string name ="env_config");

        endclass

        function env_config::new (string name ="env_config");
                super.new(name);
        endfunction
