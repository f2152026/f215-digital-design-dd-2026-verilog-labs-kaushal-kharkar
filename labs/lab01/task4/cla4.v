// cla4.v
// Gate-level 4-bit carry-lookahead adder with explicit gate delays (#(2)).

module cla4(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  // Propagate and Generate wires
  wire p0, p1, p2, p3;
  wire g0, g1, g2, g3;

  // Intermediate carry wires
  wire c1, c2, c3;

  // Intermediate product terms for carry logic
  wire t1_0;
  wire t2_0, t2_1;
  wire t3_0, t3_1, t3_2;
  wire t4_0, t4_1, t4_2, t4_3;

  // -------------------------------------------------------------
  // Step 1: Generate & Propagate signals
  // -------------------------------------------------------------
  xor #(2) (p0, a[0], b[0]);
  xor #(2) (p1, a[1], b[1]);
  xor #(2) (p2, a[2], b[2]);
  xor #(2) (p3, a[3], b[3]);

  and #(2) (g0, a[0], b[0]);
  and #(2) (g1, a[1], b[1]);
  and #(2) (g2, a[2], b[2]);
  and #(2) (g3, a[3], b[3]);

  // -------------------------------------------------------------
  // Step 2: Direct Carry Lookahead Equations
  // -------------------------------------------------------------
  // c1 = g0 + p0*cin
  and #(2) (t1_0, p0, cin);
  or  #(2) (c1, g0, t1_0);

  // c2 = g1 + p1*g0 + p1*p0*cin
  and #(2) (t2_0, p1, g0);
  and #(2) (t2_1, p1, p0, cin);
  or  #(2) (c2, g1, t2_0, t2_1);

  // c3 = g2 + p2*g1 + p2*p1*g0 + p2*p1*p0*cin
  and #(2) (t3_0, p2, g1);
  and #(2) (t3_1, p2, p1, g0);
  and #(2) (t3_2, p2, p1, p0, cin);
  or  #(2) (c3, g2, t3_0, t3_1, t3_2);

  // cout (c4) = g3 + p3*g2 + p3*p2*g1 + p3*p2*p1*g0 + p3*p2*p1*p0*cin
  and #(2) (t4_0, p3, g2);
  and #(2) (t4_1, p3, p2, g1);
  and #(2) (t4_2, p3, p2, p1, g0);
  and #(2) (t4_3, p3, p2, p1, p0, cin);
  or  #(2) (cout, g3, t4_0, t4_1, t4_2, t4_3);

  // -------------------------------------------------------------
  // Step 3: Sum Logic (sum[i] = p[i] ^ c[i])
  // -------------------------------------------------------------
  xor #(2) (sum[0], p0, cin);
  xor #(2) (sum[1], p1, c1);
  xor #(2) (sum[2], p2, c2);
  xor #(2) (sum[3], p3, c3);

endmodule