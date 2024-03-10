class ahb_agt_config extends uvm_object;

        `uvm_object_utils(ahb_agt_config)

        virtual ahb2apb_if vif;
        uvm_active_passive_enum is_active = UVM_ACTIVE;

        static int drv_data_count=0;
        static int mon_data_count=0;

        extern function new (string name = "ahb_agt_config");

        endclass

        function ahb_agt_config::new(string name ="ahb_agt_config");
                super.new(name);
        endfunction
