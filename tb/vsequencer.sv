class vsequencer extends uvm_sequencer #(uvm_sequence_item);

        `uvm_component_utils(vsequencer);

        ahb_sequencer h_seqrh;
        apb_sequencer p_seqrh;

        extern function new (string name ="vsequencer",uvm_component parent);

        endclass

        function vsequencer ::new (string name ="vsequencer",uvm_component parent);
                super.new(name,parent);
        endfunction
