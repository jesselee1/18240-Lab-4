`default_nettype none

module shapeLoaderTest();

    logic [2:0] LoadShape;
    logic [1:0] ShapeLocation;
    logic LoadShapeNow;
    logic [11:0] masterPattern;

    shapeLoader slTest(.*);

    initial begin
        $monitor($time,,
                "LoadShape = %b, ShapeLocation = %b, LoadShapeNow = %b, masterPattern = %b",
                LoadShape, ShapeLocation, LoadShapeNow, masterPattern);

            LoadShape <= 3'b001;
            ShapeLocation <= 2'b00;
        #5  LoadShapeNow <= 1;
        #5  LoadShapeNow <= 0;
        #5  LoadShape <= 3'b010;
            ShapeLocation <= 2'b10;
        #5  LoadShapeNow <= 1;
        #5  LoadShapeNow <= 0;
        #5  LoadShape <= 3'b011;
            ShapeLocation <= 2'b01;
        #5  LoadShapeNow <= 1;
        #5  LoadShapeNow <= 0;
        #5  LoadShape <= 3'b100;
            ShapeLocation <= 2'b11;
        #5  LoadShapeNow <= 1;
        #5  LoadShapeNow <= 0;

        #5  LoadShape <= 3'b101;
            ShapeLocation <= 2'b00;
        #5  LoadShapeNow <= 1;
        #5  LoadShapeNow <= 0;
        #5  LoadShape <= 3'b010;
            ShapeLocation <= 2'b00;
        #5  LoadShapeNow <= 1;
        #5  LoadShapeNow <= 0;
        #5  LoadShape <= 3'b110;
            ShapeLocation <= 2'b10;
        #5  LoadShapeNow <= 1;
        #5  LoadShapeNow <= 0;
        #5  LoadShape <= 3'b011;
            ShapeLocation <= 2'b01;
        #5  LoadShapeNow <= 1;
        #5  LoadShapeNow <= 0;
        #5  LoadShape <= 3'b100;
            ShapeLocation <= 2'b11;
        #5  LoadShapeNow <= 1;
        #5  LoadShapeNow <= 0;

        #5  $finish;
    end

endmodule: shapeLoaderTest
