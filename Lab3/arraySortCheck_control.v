
module arraySortCheck_control(sorted, done, load_input, load_index, select_index, go, inversion_found, end_of_array, zero_length_array, clock, reset);
	output sorted, done, load_input, load_index, select_index;
    input go, inversion_found, end_of_array, zero_length_array;
    input clock, reset;
 
    wire sGarbage, sStart, sChecking, sSorted, sNotSorted;

    wire sGarbage_next = (sGarbage & ~go) | reset;

    wire sStart_next = (sStart & go | sGarbage & go | sSorted & go | sNotSorted & go) & ~reset;

    wire sChecking_next = (sStart & ~go | sChecking & ~inversion_found & ~end_of_array & ~zero_length_array) & ~reset;

    wire sSorted_next = (sChecking & ~inversion_found & (end_of_array | zero_length_array) | sSorted & ~go) & ~reset;

    wire sNotSorted_next = (sChecking & inversion_found | sNotSorted & ~go) & ~reset;

    dffe fsGarbage(sGarbage, sGarbage_next, clock, 1'b1, 1'b0);

	dffe fsStart(sStart, sStart_next, clock, 1'b1, 1'b0);

    dffe fsChecking(sChecking, sChecking_next, clock, 1'b1, 1'b0);

    dffe fsSorted(sSorted, sSorted_next, clock, 1'b1, 1'b0);

    dffe fsNotSorted(sNotSorted, sNotSorted_next, clock, 1'b1, 1'b0);

    assign load_input = sStart;
    assign load_index = sStart | sChecking;
    assign select_index = sChecking;
    assign sorted = sSorted;
    assign done = sSorted | sNotSorted;
endmodule
