module glitch_free_mux( input clk1, clk2, reset, select ,
output or_1
    );
   wire and_1;
   wire and_2;
   wire and_3;
   wire and_4;
   reg r_posedge_dff1;
   reg r_posedge_dff2;
   reg r_negedge_dff1;
   reg r_negedge_dff2; 
 
 //logic for glitch free mux  
 assign and_1 = select & (~ r_negedge_dff2);   
    always@(posedge clk1 or negedge reset)begin
          if (!reset)begin
              r_posedge_dff1 <= 1'd0;
          end
          else begin
              r_posedge_dff1 <=  and_1;
          end
     end
       
       
    always@(negedge clk1 or negedge reset)begin
          if (!reset)begin
              r_negedge_dff1 <= 1'd0;
          end
          else begin
              r_negedge_dff1 <=  r_posedge_dff1;
          end
     end   
     
 assign and_2 = (~select) & (~r_negedge_dff1);
     
     always@(posedge clk2 or negedge reset)begin
          if (!reset)begin
              r_posedge_dff2 <= 1'd0;
          end
          else begin
              r_posedge_dff2 <=  and_2;
          end
     end
       
       
    always@(negedge clk2 or negedge reset)begin
          if (!reset)begin
              r_negedge_dff2 <= 1'd0;
          end
          else begin
              r_negedge_dff2 <=  r_posedge_dff2;
          end
     end         
 
 assign and_3 = r_negedge_dff1 & clk1;
 assign and_4 = r_negedge_dff2 & clk2;
 assign or_1 =  and_3 | and_4 ;
           
endmodule
