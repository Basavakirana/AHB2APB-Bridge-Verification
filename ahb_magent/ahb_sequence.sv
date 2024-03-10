class ahb_sequence extends uvm_sequence #(ahb_xtn);

        `uvm_object_utils(ahb_sequence)

        bit[31:0] haddr;
        bit[1:0] hsize;
        bit[2:0] hburst;
        bit hwrite;
        bit htrans;

        extern function new (string name ="ahb_sequence");

        endclass

        function ahb_sequence ::new(string name ="ahb_sequence");
                super.new(name);
        endfunction

class simple_write extends ahb_sequence;

        `uvm_object_utils(simple_write)

        extern function new (string name ="simple_write");
        extern task body ();

        endclass

        function simple_write ::new(string name ="simple_write");
                super.new(name);
        endfunction

        task simple_write ::body();
                    begin
                        req = ahb_xtn::type_id::create("req");
                        start_item(req);
                        assert(req.randomize() with {Hwrite==1;Hburst==3'b000;Htrans==2'b10;});
                        $display("this is a ahb simple_write");
                        req.print;
                        finish_item(req);
                    end

                start_item(req);
                assert(req.randomize() with {Htrans==2'b00;});
                finish_item(req);
        endtask
class simple_write1 extends ahb_sequence;

        `uvm_object_utils(simple_write1)

        extern function new (string name ="simple_write1");
        extern task body ();

        endclass

        function simple_write1 ::new(string name ="simple_write1");
                super.new(name);
        endfunction

        task simple_write1 ::body();
                    begin
                        req = ahb_xtn::type_id::create("req");
                        start_item(req);
                        assert(req.randomize() with {Hwrite==0;Hburst==3'b000;Htrans==2'b10;});
                        $display("this is a ahb simple_read");
                        req.print;
                        finish_item(req);
                    end

                start_item(req);
                assert(req.randomize() with {Htrans==2'b00;});
                finish_item(req);
        endtask

class incr_4 extends ahb_sequence;

        `uvm_object_utils(incr_4)

        extern function new (string name ="incr_4");
        extern task body();

        endclass

        function incr_4::new(string name ="incr_4");
                super.new(name);
        endfunction

        task incr_4 ::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==1;Hburst==3'b011;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

                if(hburst == 3'b011)
                begin
                        for(int i=0;i<3;i++)
                        begin
                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+1'b1;});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+2'b10;});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+3'b100;});
                                finish_item(req);
                                haddr =req.Haddr;
                        end
                end
                end
                #20;
               start_item(req);
               assert(req.randomize() with {Htrans==2'b00;});
               finish_item(req);
        endtask
class incr_4r extends ahb_sequence;

        `uvm_object_utils(incr_4r)

        extern function new (string name ="incr_4r");
        extern task body();

        endclass

        function incr_4r::new(string name ="incr_4r");
                super.new(name);
        endfunction

        task incr_4r ::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==0;Hburst==3'b011;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

                if(hburst == 3'b011)
                begin
                        for(int i=0;i<3;i++)
                        begin
                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+1'b1;});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+2'b10;});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+3'b100;});
                                finish_item(req);
                                haddr =req.Haddr;
                        end
                end
                end
                #40;
               start_item(req);
               assert(req.randomize() with {Htrans==2'b00;});
               finish_item(req);
        endtask
class incr_8 extends ahb_sequence;

        `uvm_object_utils(incr_8)

        extern function new (string name ="incr_8");
        extern task body();

        endclass

        function incr_8::new(string name ="incr_8");
                super.new(name);
        endfunction

        task incr_8 ::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==1;Hburst==3'b101;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

               if(hburst == 3'b101)
                begin
                        for(int i=0;i<7;i++)
                        begin

                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+1'b1;});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+2'b10;});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+3'b100;});
                                finish_item(req);
                                haddr=req.Haddr;
                        end
                end
                end
                #40;
               start_item(req);
               assert(req.randomize() with {Htrans==2'b00;});
               finish_item(req);
        endtask
class incr_8r extends ahb_sequence;

        `uvm_object_utils(incr_8r)

        extern function new (string name ="incr_8r");
        extern task body();

        endclass

        function incr_8r::new(string name ="incr_8r");
                super.new(name);
        endfunction

        task incr_8r ::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==0;Hburst==3'b101;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

               if(hburst == 3'b101)
                begin
                        for(int i=0;i<7;i++)
                        begin

                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+1'b1;});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+2'b10;});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+3'b100;});
                                finish_item(req);
                                haddr=req.Haddr;
                        end
                end
                end
                #40;
               start_item(req);
               assert(req.randomize() with {Htrans==2'b00;});
               finish_item(req);
        endtask
class incr_16 extends ahb_sequence;

        `uvm_object_utils(incr_16)

        extern function new (string name ="incr_16");
        extern task body();

        endclass

        function incr_16::new(string name ="incr_16");
                super.new(name);
        endfunction

        task incr_16 ::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==1;Hburst==3'b111;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

                if(hburst == 3'b111)
                begin
                        for(int i=0;i<15;i++)
                        begin

                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+1'b1;});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+2'b10;});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+3'b100;});
                                finish_item(req);
                                haddr=req.Haddr;
                        end
                end
                end
                #40;
               start_item(req);
               assert(req.randomize() with {Htrans==2'b00;});
               finish_item(req);
        endtask
class incr_16r extends ahb_sequence;

        `uvm_object_utils(incr_16r)

        extern function new (string name ="incr_16r");
        extern task body();

        endclass

        function incr_16r::new(string name ="incr_16r");
                super.new(name);
        endfunction

        task incr_16r ::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==0;Hburst==3'b111;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

                if(hburst == 3'b111)
                begin
                        for(int i=0;i<15;i++)
                        begin

                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+1'b1;});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+2'b10;});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11; Haddr==haddr+3'b100;});
                                finish_item(req);
                                haddr=req.Haddr;
                        end
                end
                end
                #40;
               start_item(req);
               assert(req.randomize() with {Htrans==2'b00;});
               finish_item(req);
        endtask

class wrap_4 extends ahb_sequence;

        `uvm_object_utils(wrap_4)

        extern function new (string name ="wrap_4");
        extern task body();

        endclass

        function wrap_4 ::new(string name ="wrap_4");
                super.new(name);
        endfunction

        task wrap_4 ::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==1;Hburst==3'b010;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

                if(hburst == 3'b010)
                begin
                        for(int i=0;i<3;i++)
                        begin
                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:2],haddr[1:0]+1'b1};});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:3],haddr[2:0]+2'b10};});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:4],haddr[3:0]+3'b100};});
                                finish_item(req);
                                haddr = req.Haddr;
                        end
                end
                end
                #40;
                start_item(req);
                assert(req.randomize() with {Htrans==2'b00;});
                finish_item(req);
        endtask
class wrap_4r extends ahb_sequence;

        `uvm_object_utils(wrap_4r)

        extern function new (string name ="wrap_4r");
        extern task body();

        endclass

        function wrap_4r ::new(string name ="wrap_4r");
                super.new(name);
        endfunction

        task wrap_4r ::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==0;Hburst==3'b010;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

                if(hburst == 3'b010)
                begin
                        for(int i=0;i<3;i++)
                        begin
                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:2],haddr[1:0]+1'b1};});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:3],haddr[2:0]+2'b10};});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:4],haddr[3:0]+3'b100};});
                                finish_item(req);
                                haddr = req.Haddr;
                        end
                end
                end
                #40;
                start_item(req);
                assert(req.randomize() with {Htrans==2'b00;});
                finish_item(req);
        endtask
class wrap_8 extends ahb_sequence;

        `uvm_object_utils(wrap_8)

        extern function new (string name ="wrap_8");
        extern task body();

        endclass

        function wrap_8 ::new(string name ="wrap_8");
                super.new(name);
        endfunction

        task wrap_8 ::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==1;Hburst==3'b100;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

                if(hburst == 3'b100)
                begin
                        for(int i=0;i<7;i++)
                        begin
 //                       req = ahb_xtn::type_id::create("req");
                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:2],haddr[2:0]+1'b1};});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:4],haddr[3:0]+2'b10};});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:5],haddr[4:0]+3'b100};});
                                finish_item(req);
                                haddr=req.Haddr;
                        end
                end
                end
                #40;
                start_item(req);
                assert(req.randomize() with {Htrans==2'b00;});
                finish_item(req);
        endtask
class wrap_8r extends ahb_sequence;

        `uvm_object_utils(wrap_8r)

        extern function new (string name ="wrap_8r");
        extern task body();

        endclass

        function wrap_8r ::new(string name ="wrap_8r");
                super.new(name);
        endfunction

        task wrap_8r ::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==0;Hburst==3'b100;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

                if(hburst == 3'b100)
                begin
                        for(int i=0;i<7;i++)
                        begin
 //                       req = ahb_xtn::type_id::create("req");
                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:2],haddr[2:0]+1'b1};});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:4],haddr[3:0]+2'b10};});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:5],haddr[4:0]+3'b100};});
                                finish_item(req);
                                haddr=req.Haddr;
                        end
                end
                end
                #40;
                start_item(req);
                assert(req.randomize() with {Htrans==2'b00;});
                finish_item(req);
        endtask
class wrap_16 extends ahb_sequence;

        `uvm_object_utils(wrap_16)

        extern function new (string name ="wrap_16");
        extern task body();

        endclass

        function wrap_16 ::new(string name ="wrap_16");
                super.new(name);
        endfunction

        task wrap_16 ::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==1;Hburst==3'b110;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

                if(hburst == 3'b110)
                begin
                        for(int i=0;i<15;i++)
                        begin
//                        req = ahb_xtn::type_id::create("req");
                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:4],haddr[3:0]+1'b1};});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:5],haddr[4:0]+2'b10};});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:6],haddr[5:0]+3'b100};});
                                finish_item(req);
                                haddr=req.Haddr;
                        end
                end
                end
                #40;
                start_item(req);
                assert(req.randomize() with {Htrans==2'b00;});
                finish_item(req);
        endtask
class wrap_16r extends ahb_sequence;

        `uvm_object_utils(wrap_16r)

        extern function new (string name ="wrap_16r");
        extern task body();

        endclass

        function wrap_16r ::new(string name ="wrap_16r");
                super.new(name);
        endfunction

        task wrap_16r ::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==0;Hburst==3'b110;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

                if(hburst == 3'b110)
                begin
                        for(int i=0;i<15;i++)
                        begin
//                        req = ahb_xtn::type_id::create("req");
                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:4],haddr[3:0]+1'b1};});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:5],haddr[4:0]+2'b10};});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:6],haddr[5:0]+3'b100};});
                                finish_item(req);
                                haddr=req.Haddr;
                        end
                end
                end
                #40;
                start_item(req);
                assert(req.randomize() with {Htrans==2'b00;});
                finish_item(req);
        endtask
class un_seq extends ahb_sequence;

        `uvm_object_utils(un_seq)

        extern function new (string name ="un_seq");
        extern task body ();

        endclass

        function un_seq::new (string name ="un_seq");
                super.new(name);
        endfunction

        task un_seq::body();
                begin
                req = ahb_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {Htrans==2'b10;Hwrite==1;Hburst==3'b001;});
                finish_item(req);

                haddr = req.Haddr;
                hsize = req.Hsize;
                hburst = req.Hburst;
                hwrite = req.Hwrite;
                htrans =req.Htrans;

                if(hburst == 3'b001)
                begin
                        for(int i=0;i<req.length-1;i++)
                        begin
                                start_item(req);
                                if(hsize==0)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:2],haddr[1:0]+1'b1};});
                                if(hsize==1)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:3],haddr[2:0]+2'b10};});
                                if(hsize==2)
                                        assert(req.randomize() with {Hsize==hsize; Hburst==hburst; Hwrite==hwrite; Htrans==2'b11;
                                                                     Haddr=={haddr[31:4],haddr[3:0]+3'b100};});
                                finish_item(req);
                                haddr = req.Haddr;
                        end
                end
                end
                #40;
                start_item(req);
                assert(req.randomize() with {Htrans==2'b00;});
                   finish_item(req);
        endtask
