module gray_p #(parameter N = 5)
  (input clk,
   input rst,
   output logic [N-1:0] g3);
  
  logic [N-1:0] cnt, nc;
  logic par;
  
  always_ff @(posedge clk) begin
    if(rst) begin
      par <= 1;
    end
    else begin
      par <= ~par;
    end
  end
  
  always_ff @(posedge clk) begin
    if(rst) begin
      cnt <= 0;
    end
    else begin
      cnt <= nc;
    end
  end
  
  logic [N-1:0] temp; 
  logic [N-1:0] temp2;
	//logic flag;
  always_comb begin
	//f = 0;
    for(int i = 0; i<N; i++) begin
      if(i == N-1) begin
        temp = cnt << 1;
        if((cnt[i] == 1) && (temp == 0)) begin 
        	nc[i] = 0;
        end  
        else if (!cnt[i] && ((cnt << 1) >> 1) == {{N-1{1'b0}},1'b1} << i-1) begin 
          nc[i] = ~cnt[i];
        end
        else begin
          nc[i] = cnt[i];
        end
      end
      else if(i == 0) begin
        nc[0] = (par) ? ~cnt[0]:cnt[0];
      end
      else begin
        temp2 = ((cnt << N-i) >> N-i);
        if(!par && temp2 == {{N-1{1'b0}},1'b1} << i-1) begin
          nc[i] = ~cnt[i];
        end
        else begin 
          nc[i] = cnt[i];
        end
      end
    end
  end
      
    
  assign g3 = cnt;
    
endmodule
