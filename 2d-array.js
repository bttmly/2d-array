var TwoDimensionalArray = ( function() {
  "use strict";

  function TwoDimensionalArray( x, y, opt ) {
    opt = opt || {};
    var fill = opt.fill || 0;
    var i = 0;
    var j = 0;
    while ( i < x ) {
      j = 0;
      this.push( [] );
      while ( j < y ) {
        this[i][j] = ( typeof fill === "function" ? fill( i, j, this ) : fill );
        j += 1;
      }
      i += 1;
    }
  }

  TwoDimensionalArray.prototype = Object.create( Array.prototype );

  TwoDimensionalArray.prototype.forEach = function( callback, thisArg ) {
    var i = 0;
    var j = 0;
    var x = this.length;
    var y = this[0].length;
    thisArg = thisArg || null;
    while ( i < x ) {
      j = 0;
      while ( j < y ) {
        callback.call( thisArg, i, j, this[i][j], this );
        j += 1;
      }
      i += 1;
    }
  };

  TwoDimensionalArray.prototype.map = function( callback, thisArg ) {
    var results = new TwoDimensionalArray( this.length, this[0].length );
    this.forEach( function( x, y, item, arr ) {
      results[x][y] = callback.call( thisArg, x, y, item, arr );
    });
    return results;
  };

  return TwoDimensionalArray;
})();

module.exports = TwoDimensionalArray;