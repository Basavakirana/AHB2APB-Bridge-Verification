class ahb2apb_test extends uvm_test;

        `uvm_component_utils(ahb2apb_test)

        ahb2apb_env envh;
        env_config env_configh;
        ahb_agt_config h_configh;
        apb_agt_config p_configh;

        bit has_ahb_agent =1;
        int has_apb_agent =1;
        bit has_scoreboard =1;
        bit has_vseqr =1;

        extern function new (string name ="ahb2apb_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void start_of_simulation_phase (uvm_phase phase);

        endclass

        function ahb2apb_test::new (string name ="ahb2apb_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void ahb2apb_test:: build_phase (uvm_phase phase);
                envh = ahb2apb_env::type_id::create("envh",this);
                env_configh = env_config::type_id::create("env_configh");

                if(has_ahb_agent)
                        begin
                                h_configh =ahb_agt_config::type_id::create("h_configh");
                                h_configh.is_active =UVM_ACTIVE;
                                if(!uvm_config_db #(virtual ahb2apb_if) :: get(this,"","vif",h_configh.vif))
                                  `uvm_fatal("test","cannot get config data");
                                env_configh.h_configh = h_configh;
                        end
                if(has_apb_agent)
                        begin
                                p_configh =apb_agt_config::type_id::create("p_configh");
                                p_configh.is_active =UVM_ACTIVE;
                                if(!uvm_config_db #(virtual ahb2apb_if) :: get(this,"","vif",p_configh.vif))
                                  `uvm_fatal("test","cannot get config data");
                                env_configh.p_configh = p_configh;
                        end

                env_configh.has_ahb_agent = has_ahb_agent;
                env_configh.has_apb_agent = has_apb_agent;
                env_configh.has_scoreboard = has_scoreboard;
                env_configh.has_vseqr = has_vseqr;
                uvm_config_db #(env_config)::set(this,"*","env_config",env_configh);
                super.build_phase(phase);
        endfunction

        function void ahb2apb_test:: start_of_simulation_phase(uvm_phase phase);
                uvm_top.print_topology();
        endfunction

class simple_test extends ahb2apb_test;

        `uvm_component_utils(simple_test)

        simple_write seqh;

        extern function new (string name = "simple_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function simple_test::new(string name ="simple_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void simple_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task simple_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seqh = simple_write::type_id::create("seqh");
                seqh.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask
class incr4_test extends ahb2apb_test;

        `uvm_component_utils(incr4_test)

        incr_4 seq_h;

        extern function new (string name = "incr4_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function incr4_test::new(string name ="incr4_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void incr4_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task incr4_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = incr_4::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask

class incr4r_test extends ahb2apb_test;

        `uvm_component_utils(incr4r_test)

        incr_4r seq_h;

        extern function new (string name = "incr4r_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function incr4r_test::new(string name ="incr4r_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void incr4r_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task incr4r_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = incr_4r::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask

class wrap4_test extends ahb2apb_test;

        `uvm_component_utils(wrap4_test)

        wrap_4 seq_h;

        extern function new (string name = "wrap4_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function wrap4_test::new(string name ="wrap4_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void wrap4_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task wrap4_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = wrap_4::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask
class wrap4r_test extends ahb2apb_test;

        `uvm_component_utils(wrap4r_test)

        wrap_4r seq_h;

        extern function new (string name = "wrap4r_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function wrap4r_test::new(string name ="wrap4r_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void wrap4r_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task wrap4r_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = wrap_4r::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask

class read_test extends ahb2apb_test;

        `uvm_component_utils(read_test)

        simple_write1 seq_h;

        extern function new (string name = "read_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function read_test::new(string name ="read_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void read_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task read_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = simple_write1::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask

class incr8_test extends ahb2apb_test;

        `uvm_component_utils(incr8_test)

        incr_8 seq_h;

        extern function new (string name = "incr8_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function incr8_test::new(string name ="incr8_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void incr8_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task incr8_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = incr_8::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask
class incr8r_test extends ahb2apb_test;

        `uvm_component_utils(incr8r_test)

        incr_8r seq_h;

        extern function new (string name = "incr8r_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function incr8r_test::new(string name ="incr8r_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void incr8r_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task incr8r_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = incr_8r::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask

class incr16_test extends ahb2apb_test;

        `uvm_component_utils(incr16_test)

        incr_16 seq_h;

        extern function new (string name = "incr16_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function incr16_test::new(string name ="incr16_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void incr16_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task incr16_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = incr_16::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask

class incr16r_test extends ahb2apb_test;

        `uvm_component_utils(incr16r_test)

        incr_16r seq_h;

        extern function new (string name = "incr16r_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function incr16r_test::new(string name ="incr16r_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void incr16r_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task incr16r_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = incr_16r::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask
class wrap8_test extends ahb2apb_test;

        `uvm_component_utils(wrap8_test)

        wrap_8 seq_h;

        extern function new (string name = "wrap8_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function wrap8_test::new(string name ="wrap8_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void wrap8_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task wrap8_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = wrap_8::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask


class wrap8r_test extends ahb2apb_test;

        `uvm_component_utils(wrap8r_test)

        wrap_8r seq_h;

        extern function new (string name = "wrap8r_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function wrap8r_test::new(string name ="wrap8r_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void wrap8r_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task wrap8r_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = wrap_8r::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask


class wrap16_test extends ahb2apb_test;

        `uvm_component_utils(wrap16_test)
        wrap_16 seq_h;

        extern function new (string name = "wrap16_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function wrap16_test::new(string name ="wrap16_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void wrap16_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task wrap16_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = wrap_16::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask
class wrap16r_test extends ahb2apb_test;

        `uvm_component_utils(wrap16r_test)

        wrap_16r seq_h;

        extern function new (string name = "wrap16r_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function wrap16r_test::new(string name ="wrap16r_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void wrap16r_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task wrap16r_test::run_phase (uvm_phase phase);
                phase.raise_objection(this);
                seq_h = wrap_16r::type_id::create("seq_h");
                seq_h.start(envh.h_toph.h_agnth.h_seqrh);
                #10;
                phase.drop_objection(this);
        endtask
