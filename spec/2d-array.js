/* global 2d-array, describe, it, expect, should */

describe( "TwoDimensionalArray()", function () {
  "use strict";

  it( "exists", function () {
    expect( "TwoDimensionalArray" ).to.be.a( "function" );

  });

  it( "inherits from Array", function() {
    expect( new TwoDimensionalArray( 0, 0 ) ).to.be.instanceof( "Array" );
  });

  

});
