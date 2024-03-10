class apb_sequence extends uvm_sequence #(apb_xtn);

        `uvm_object_utils(apb_sequence)

        extern function new (string name ="apb_sequence");
//      extern task body();

        endclass

        function apb_sequence ::new(string name ="apb_sequence");
                super.new(name);
        endfunction

//      task apb_sequence::body();
//              begin
//                      req = apb_xtn::type_id::create("req");
//                      start_item(req);
//              assert(req.randomize());
//                      finish_item(req);
//              end
//endtask
