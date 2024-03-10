class vsequence extends uvm_sequence #(uvm_sequence_item);

        `uvm_object_utils(vsequence)

        ahb_sequencer h_seqrh;
        apb_sequencer p_seqrh;
        vsequencer vseqrh;
        ahb_sequence h_seqh;
        apb_sequence p_seqh;

        extern function new (string name ="vsequence");

        endclass

        function vsequence ::new(string name ="vsequence");
                super.new(name);
        endfunction
