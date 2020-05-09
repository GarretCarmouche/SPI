/**
* starter.v
*
* Serial Peripheral Interface (SPI)
*
* Implement both sides of a SPI interface.
*
*/

module master_device(DATA_ADDR, SS_ADDR, SCLK, MOSI, MISO, SS);
// I/O PORTS (DO NOT MODIFY)
input         MISO;
output        MOSI, SCLK;
input   [1:0] SS_ADDR;
output  reg [3:0] SS;
input   [7:0] DATA_ADDR;

reg [7:0] DATA;
reg [7:0] tempData;

// ADD COMBINATIONAL LOGIC HERE
reg SCLK;
reg MOSI = 1;

integer i;
integer dataSize = 0;


always@(DATA_ADDR, SS_ADDR)
begin
  // ADD SEQUENTIAL LOGIC HERE
  MOSI = 1;
  SCLK = 1;
  if(SS_ADDR == 3'd0)begin
    SS = 4'b0111;
    for(i = 0; i < 64; i = i + 1)begin
      if(i < 8)begin
        MOSI = DATA_ADDR[i];
      end
      SCLK = !SCLK;
      #1;
      tempData[dataSize] = MISO;
      if(SCLK == 1) begin
        dataSize = dataSize + 1;
        if(dataSize == 8)begin
          dataSize = 0;
          DATA = tempData;
          tempData = 8'b00000000;
          #480;
        end
      end
    end
  end
  else if(SS_ADDR == 3'd1)begin
    SS = 4'b1011;
    for(i = 0; i < 64; i = i + 1)begin
      if(i < 8)begin
        MOSI = DATA_ADDR[i];
      end
      SCLK = !SCLK;
      #1;
      tempData[dataSize] = MISO;
      if(SCLK == 1) begin
        dataSize = dataSize + 1;
        if(dataSize == 8)begin
          dataSize = 0;
          DATA = tempData;
          tempData = 8'b00000000;
          #480;
        end
      end
    end
  end
  else if(SS_ADDR == 3'd2)begin
    SS = 4'b1101;
    for(i = 0; i < 64; i = i + 1)begin
      if(i < 8)begin
        MOSI = DATA_ADDR[i];
      end
      SCLK = !SCLK;
      #1;
      tempData[dataSize] = MISO;
      if(SCLK == 1) begin
        dataSize = dataSize + 1;
        if(dataSize == 8)begin
          dataSize = 0;
          DATA = tempData;
          tempData = 8'b00000000;
          #480;
        end
      end
    end
  end
  else if(SS_ADDR == 3'd3)begin
    SS = 4'b1110;
    for(i = 0; i < 64; i = i + 1)begin
      if(i < 8)begin
        MOSI = DATA_ADDR[i];
      end
      SCLK = !SCLK;
      #1;
      tempData[dataSize] = MISO;
      if(SCLK == 1) begin
        dataSize = dataSize + 1;
        if(dataSize == 8)begin
          dataSize = 0;
          DATA = tempData;
          tempData = 8'b00000000;
          #480;
        end
      end
    end
  end
end

endmodule

module slave_device(SCLK, MOSI, MISO, SS);
// I/O PORTS (DO NOT MODIFY)
input       MOSI, SCLK, SS;
output reg MISO;


// INTERNAL DATA REGISTERS (DO NOT MODIFY)
reg [7:0] reg0 = 8'h41; // Address = 8'h1A
reg [7:0] reg1 = 8'hDC; // Address = 8'h1B
reg [7:0] reg2 = 8'h3B; // Address = 8'h1C
reg [7:0] reg3 = 8'h4E; // Address = 8'h1D
reg [7:0] reg4 = 8'h8C; // Address = 8'h2A
reg [7:0] reg5 = 8'hB5; // Address = 8'h2B
reg [7:0] reg6 = 8'h05; // Address = 8'h2C
reg [7:0] reg7 = 8'hE5; // Address = 8'h2D

// ADD YOUR CODE HERE
initial MISO = 0;

reg [7:0] dataItem = 8'h41;
reg [7:0] lastData;
integer checkedBit = 0;
always @(posedge SCLK)
begin
  MISO = 0;
  if(SS == 0) begin
    if (checkedBit > 7) begin
      checkedBit = 0;
      if(dataItem == reg0) begin
        dataItem = reg1;
      end
      else if(dataItem == reg1) begin
        dataItem = reg2;
      end
      else if(dataItem == reg2) begin
        dataItem = reg3;
      end
      else if(dataItem == reg3) begin
        dataItem = reg4;
      end
      else if(dataItem == reg4) begin
        dataItem = reg5;
      end
      else if(dataItem == reg5) begin
        dataItem = reg6;
      end
      else if(dataItem == reg6) begin
        dataItem = reg7;
      end
      else if(dataItem == reg6) begin
        dataItem = reg0;
      end
    end
    MISO = dataItem[checkedBit];
    lastData[checkedBit] = MISO;
    checkedBit = checkedBit + 1;
  end
end

endmodule
