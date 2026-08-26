// rca.v
// Identical structure to Task 2's ripple_adder -- reuse your wiring
// pattern directly.
//
// Required file: copy your completed FA_Gate.v from Task 2 (the version
// with delays already added, from part (a) or (b)) into this folder.
// No separate "delay" variant is needed -- Task 2's FA_Gate already has
// delays built in, and every gate/module from here on should too.
//
// TODO: instantiate four FA_Gate instances, same chaining pattern as
// Task 2 (FA0..FA3, carry chain c1,c2,c3).

module rca(
    input  [3:0] a,
    input  [3:0] b,
    input        cin,
    output [3:0] sum,
    output       cout
);

    wire c1, c2, c3;

    FA_Gate fa0 (sum[0], c1, a[0], b[0], cin);
    FA_Gate fa1 (sum[1], c2, a[1], b[1], c1);
    FA_Gate fa2 (sum[2], c3, a[2], b[2], c2);
    FA_Gate fa3 (sum[3], cout, a[3], b[3], c3);

endmodule