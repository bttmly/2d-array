( ( root, factory ) ->
  if typeof define is "function" and define.amd
    define [
      "exports"
    ], ( _, exports ) ->
      root.TwoDimensionalArray = factory( root, exports )
      return  

  else if typeof exports isnt "undefined"
    factory( root, exports )

  else
    root.TwoDimensionalArray = factory( root, {} )

  return

)( this, ( root, TwoDimensionalArray ) ->  

  class TwoDimensionalArray extends Array
    constructor : ( dim1size, dim2size, options ) ->      
      for i in [ 0...d1 ]
        arr = []
        for j in [ 0...d2 ]
          arr.push do ->

    # Callback receives ( currentItem, rowIndex, columnIndex, 2dArray )
    forEach : ( callback ) ->
      for row, i in this
        for item, j in this[0]
          callback( item, i, j, this )

    # An alias to forEach
    each : ->
      return this.forEach.apply( this, arguments )

    # Callback receives ( currentItem, rowIndex, columnIndex, 2dArray )
    # Returns a new instance of this class.
    map : ( callback ) ->
      map = new TwoDimensionalArray( this.length, this[0].length )
      for row, i in this
        for item, j in row
          map[i][j] = callback( item, i, j, this )

)
